import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'i_projectile_client.dart';

class HttpClient extends IProjectileClient<http.Request> {
  HttpClient(super.config);

  final http.Client _httpClient = http.Client();

  @override
  Future<void> sendRequest(ProjectileRequest request) async {
    try {
      // query into the URI
      final httpRequest = transformProjectileRequest(request);

      final httpSendRequest = await _httpClient
          .send(httpRequest)
          .timeout(const Duration(seconds: 5));

      final httpResponse = await http.Response.fromStream(httpSendRequest);

      final statusCode = httpResponse.statusCode;
      final responseHeaders = httpResponse.headers;
      var response = jsonDecode(httpResponse.body) as Map;
    } on TimeoutException catch (error, stackTrace) {
    } on SocketException catch (error, stackTrace) {
    } on Exception catch (error, stackTrace) {}
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
