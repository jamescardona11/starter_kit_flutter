import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projectile/core/core.dart';

class HttpClient extends IProjectileClient {
  HttpClient([super.config]);

  final http.Client _httpClient = http.Client();

  @override
  Future<SuccessResult> createRequest(
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

    return SuccessResult.def(
      statusCode: response.statusCode,
      headers: response.headers,
      data: data,
      originalRequest: request,
      // originalData: response.body,
    );
  }

  // if (!jsonResponse) {
  //   body = await response.stream.toBytes();
  // } else {
  //   body = await response.stream.transform(utf8.decoder).join();
  // }

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
      ..headers.addAll(request.headers.asMap)
      ..bodyFields = request.data;

    return httpRequest;
  }

  Future<http.MultipartRequest> _transformProjectileMultipartRequest(
    ProjectileRequest request,
  ) async {
    final uri = request.getUri(config.baseUrl);

    final httpRequest = http.MultipartRequest(request.methodStr, uri)
      ..headers.addAll(request.headers.asMap)
      ..fields.addAll(request.data)
      ..files.add(await createNativeMultipartObject(request.multipart!));

    return httpRequest;
  }
}
