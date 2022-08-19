import 'dart:async';
import 'dart:convert';

import 'package:base_ddd/core/networking/core/request_models/multipart_file.dart';
import 'package:http/http.dart' as http;

import '../core/misc_models/misc_models.dart';
import '../core/request_models/request_models.dart';
import '../core/response_models/response_models.dart';
import 'i_projectile_client.dart';

class HttpClient extends IProjectileClient {
  HttpClient([this.config = const BaseConfig()]);

  final BaseConfig config;
  final http.Client _httpClient = http.Client();

  @override
  Future<ResponseSuccess> createRequest(
    ProjectileRequest request,
  ) async {
    final httpRequest = transformProjectileRequest(request);

    final httpSendRequest =
        await _httpClient.send(httpRequest).timeout(config.timeout);

    final response = await http.Response.fromStream(httpSendRequest);
    final data = jsonDecode(response.body) as Map;

    return ResponseSuccess(
      statusCode: response.statusCode,
      headers: Headers.fromMap(response.headers),
      body: data,
      originalData: response.body,
      originalRequest: request,
    );
  }

  @override
  void finallyBlock() {
    _httpClient.close();
  }

  @override
  Future<http.MultipartFile> configureNativeMultipartObject(
    MultipartFileWrapper multipartFileWrapper,
  ) async {
    final type = multipartFileWrapper.type;

    if (type.isBytes) {
      return http.MultipartFile.fromBytes(
        multipartFileWrapper.field,
        multipartFileWrapper.valueBytes!,
        filename: multipartFileWrapper.filename,
        contentType: multipartFileWrapper.contentType,
      );
    } else if (type.isString) {
      return http.MultipartFile.fromString(
        multipartFileWrapper.field,
        multipartFileWrapper.valueString!,
        filename: multipartFileWrapper.filename,
        contentType: multipartFileWrapper.contentType,
      );
    } else {
      return http.MultipartFile.fromPath(
        multipartFileWrapper.field,
        multipartFileWrapper.valuePath!,
        filename: multipartFileWrapper.filename,
        contentType: multipartFileWrapper.contentType,
      );
    }
  }

  http.Request transformProjectileRequest(ProjectileRequest request) {
    final uri = request.getUri(config.baseUrl);

    final httpRequest = http.Request(
      request.method.value,
      uri,
    );

    httpRequest.headers
      ..addAll(request.headers.asMap)
      ..addAll({'content-type': request.contentType.value});

    httpRequest.bodyFields = request.data;

    return httpRequest;
  }
}
