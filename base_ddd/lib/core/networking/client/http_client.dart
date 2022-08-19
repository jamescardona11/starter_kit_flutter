import 'dart:async';
import 'dart:convert';

import 'package:base_ddd/core/networking/core/request_models/multipart_file.dart';
import 'package:http/http.dart' as http;

import '../core/misc_models/misc_models.dart';
import '../core/request_models/request_models.dart';
import '../core/response_models/response_models.dart';
import 'i_projectile_client.dart';

class HttpClient extends IProjectileClient {
  HttpClient([super.config]);

  final http.Client _httpClient = http.Client();

  @override
  Future<ResponseSuccess> createRequest(
    ProjectileRequest request,
  ) async {
    final http.BaseRequest httpRequest;

    if (!request.isMultipart) {
      httpRequest = _transformProjectileRequest(request);
    } else {
      httpRequest = await _transformProjectileMultipartRequest(request);
    }

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
  Future<http.MultipartFile> createNativeMultipartObject(
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

  @override
  void finallyBlock() {
    _httpClient.close();
  }

  http.Request _transformProjectileRequest(ProjectileRequest request) {
    final uri = request.getUri(config.baseUrl);

    final method =
        request.isMultipart ? Method.POST.value : request.method.value;

    final httpRequest = http.Request(
      method,
      uri,
    );

    request.headers
      ..addContentType(request.contentType.value)
      ..addBaseConfig(config);

    httpRequest
      ..headers.addAll(request.headers.asMap)
      ..bodyFields = request.data;

    return httpRequest;
  }

  Future<http.MultipartRequest> _transformProjectileMultipartRequest(
      ProjectileRequest request) async {
    final uri = request.getUri(config.baseUrl);

    request.headers.addContentType(request.contentType.value);

    final httpRequest = http.MultipartRequest(Method.POST.value, uri)
      ..headers.addAll(request.headers.asMap)
      ..fields.addAll(request.data)
      ..files.add(await createNativeMultipartObject(request.multipart!));

    return httpRequest;
  }
}
