import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../request_models/request_models.dart';
import '../response_models/response_models.dart';
import 'i_projectile_client.dart';

class HttpClient extends IProjectileClient {
  HttpClient([this.config = const BaseConfig()]);

  final BaseConfig config;
  final http.Client _httpClient = http.Client();

  @override
  Future<ProjectileResponse> createRequest(
    ProjectileRequest request,
  ) async {
    final httpRequest = transformProjectileRequest(request);

    final httpSendRequest =
        await _httpClient.send(httpRequest).timeout(config.timeout);

    final response = await http.Response.fromStream(httpSendRequest);
    final data = jsonDecode(response.body) as Map;

    return ProjectileResponse(
      statusCode: response.statusCode,
      headers: response.headers,
      body: data,
      originalData: response.body,
      originalRequest: request,
    );
  }

  @override
  void finallyBlock() {
    _httpClient.close();
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
