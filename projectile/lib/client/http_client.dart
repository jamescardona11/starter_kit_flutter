import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projectile/core/core.dart';

class HttpClient extends IProjectileClient {
  HttpClient([super.config]);

  final http.Client _httpClient = http.Client();

  @override
  Future<ProjectileResult> createRequest(
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

    dynamic data;

    if (request.responseType.isJson) {
      /// json
      data = jsonDecode(response.body);
    } else if (request.responseType.isBytes) {
      /// bytes
      data = response.bodyBytes;
    } else {
      /// plain
      data = response.body;
    }

    if (_isSuccessRequest(response.statusCode)) {
      return SuccessResult.def(
        statusCode: response.statusCode,
        headers: response.headers,
        data: _getDataWithData(data),
        originalRequest: request,
        // originalData: response.body,
      );
    } else {
      return FailureResult.def(
        originalRequest: request,
        error: _getDataWithData(data),
        statusCode: response.statusCode,
        headers: response.headers,
      );
    }
  }

  bool _isSuccessRequest(int? statusCode) =>
      statusCode != null &&
      ![
        400, // Bad Request
        401, // Unauthorized
        402, // Payment Required
        403, // Forbidden
        404, // Not Found
        405, // Method Not Allowed,
        413, // Request Entity Too Large
        414, // Request URI Too Long,
        415, // Unsupported Media Type
      ].contains(statusCode);

  dynamic _getDataWithData(dynamic data) =>
      (data as Map).containsKey('data') ? data['data'] : data;

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

    final httpRequest = http.Request(request.methodStr, uri)
      ..headers.addAll(request.headers!.asMap)
      ..bodyFields =
          request.data.map((key, value) => MapEntry(key, value.toString()));

    return httpRequest;
  }

  Future<http.MultipartRequest> _transformProjectileMultipartRequest(
    ProjectileRequest request,
  ) async {
    final uri = request.getUri(config.baseUrl);

    final httpRequest = http.MultipartRequest(request.methodStr, uri)
      ..headers.addAll(request.headers!.asMap)
      ..fields.addAll(
          request.data.map((key, value) => MapEntry(key, value.toString())))
      ..files.add(await createNativeMultipartObject(request.multipart!));

    return httpRequest;
  }
}
