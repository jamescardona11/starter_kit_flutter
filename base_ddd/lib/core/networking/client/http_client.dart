import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../request/request.dart';
import '../response/response.dart';
import '../result/export.dart';
import 'i_projectile_client.dart';

class HttpClient
    extends IProjectileClient<Result<IProjectileError, IProjectileResponse>> {
  HttpClient([this.config = const BaseConfig()]);

  final BaseConfig config;
  final http.Client _httpClient = http.Client();

  @override
  Future<Result<IProjectileError, IProjectileResponse>> sendRequest(
      ProjectileRequest request) async {
    try {
      // query into the URI
      final httpRequest = transformProjectileRequest(request);

      final httpSendRequest =
          await _httpClient.send(httpRequest).timeout(config.timeout);

      final response = await http.Response.fromStream(httpSendRequest);
      final data = jsonDecode(response.body) as Map;

      final base = BaseResponse(
        statusCode: response.statusCode,
        headers: response.headers,
        body: data,
        originalData: response.body,
        originalRequest: request,
      );

      // if (statusCode < 300)
      return Success(base.convert());

      // return Failure(
      //   FailureRequest(
      //     base.convert() as ErrorResponse,
      //   ),
      // );
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
    } finally {
      _httpClient.close();
    }
  }

  http.Request transformProjectileRequest(ProjectileRequest request) {
    final uri = request.getUri(config.baseUrl);

    final httpRequest = http.Request(
      request.method.value,
      uri,
    );

    httpRequest.headers
      ..addAll(request.headers)
      ..addAll({'content-type': request.contentType.value});

    httpRequest.bodyFields = request.data;

    return httpRequest;
  }
}
