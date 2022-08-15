import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:base_ddd/core/networking/result/failure.dart';
import 'package:base_ddd/core/networking/result/success.dart';
import 'package:http/http.dart' as http;

import '../request/request.dart';
import '../response/response.dart';
import '../result/result.dart';
import 'i_projectile_client.dart';

class HttpClient extends IProjectileClient<http.Request> {
  HttpClient(super.config);

  final http.Client _httpClient = http.Client();

  @override
  Future<Result<IProjectileError, IProjectileResponse>> sendRequest(
      ProjectileRequest request) async {
    try {
      // query into the URI
      final httpRequest = transformProjectileRequest(request);

      final httpSendRequest =
          await _httpClient.send(httpRequest).timeout(config.timeout);

      final httpResponse = await http.Response.fromStream(httpSendRequest);

      final statusCode = httpResponse.statusCode;
      final responseHeaders = httpResponse.headers;
      var response = jsonDecode(httpResponse.body) as Map;

      final base = BaseResponse(
        statusCode: statusCode,
        headers: responseHeaders,
        body: response,
        originalData: httpResponse.body,
        originalRequest: request,
      );

      return Success(base.convert());

      // Failure('value');
    } on TimeoutException catch (error, stackTrace) {
      return Failure(
        TimeoutError(
          cause: error.message ?? 'timeout',
          stackTrace: stackTrace,
          request: request,
        ),
      );
    } on SocketException catch (error, stackTrace) {
      return Failure(
        NoInternetConnectionError(
          cause: error.message,
          stackTrace: stackTrace,
          request: request,
        ),
      );
    } on Exception catch (error, stackTrace) {
      return Failure(
        UnknownError(
          cause: error.toString(),
          stackTrace: stackTrace,
          request: request,
        ),
      );
    }
  }

  @override
  http.Request transformProjectileRequest(ProjectileRequest request) {
    final uri = request.getUri(config.baseUrl);

    final httpRequest = http.Request(
      request.method.value,
      uri,
    );

    httpRequest.headers
      ..addAll(request.headers)
      ..addAll({'Content-Type': request.contentType.value});

    httpRequest.bodyFields = request.data;

    return httpRequest;
  }
}
