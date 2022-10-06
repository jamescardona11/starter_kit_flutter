import 'dart:async';
import 'package:dio/dio.dart' hide Headers;

import '../core/request_models/request_models.dart';
import '../core/response_models/response_models.dart';
import '../core/client/i_projectile_client.dart';

class DioClient extends IProjectileClient {
  final Dio _dioClient;

  DioClient(
    this._dioClient, [
    super.config,
  ]);

  @override
  Future<ResponseSuccess> createRequest(ProjectileRequest request) async {
    final url = request.getUrl();

    final data =
        request.isMultipart ? await _createFromMap(request) : request.data;

    final response = await _dioClient.request(
      url,
      options: getOptions(request),
      data: data,
    );

    return ResponseSuccess.def(
      statusCode: response.statusCode,
      headers: response.headers.map,
      data: response.data,
      // originalData: response.data,
      originalRequest: request,
    );
  }

  @override
  Future<MultipartFile> createNativeMultipartObject(
    MultipartFileWrapper multipartFileWrapper,
  ) async {
    final type = multipartFileWrapper.type;

    if (type.isBytes) {
      return MultipartFile.fromBytes(
        multipartFileWrapper.valueBytes!,
        filename: multipartFileWrapper.filename,
        contentType: multipartFileWrapper.contentType,
      );
    } else if (type.isString) {
      return MultipartFile.fromString(
        multipartFileWrapper.valueString!,
        filename: multipartFileWrapper.filename,
        contentType: multipartFileWrapper.contentType,
      );
    } else {
      return MultipartFile.fromFile(
        multipartFileWrapper.valuePath!,
        filename: multipartFileWrapper.filename,
        contentType: multipartFileWrapper.contentType,
      );
    }
  }

  @override
  void finallyBlock() {
    // _dioClient.close();
  }

  Options getOptions(ProjectileRequest request) => Options(
        method: request.methodStr,
        headers: request.headers.asMap,
        contentType: request.contentType.value,
        responseType: _fromResponseType(request),
      );

  Future<FormData> _createFromMap(ProjectileRequest request) async {
    final multipart = await createNativeMultipartObject(request.multipart!);

    return FormData.fromMap(
      <String, dynamic>{}
        ..addAll(request.data)
        ..addAll({request.multipart!.field: multipart}),
    );
  }

  ResponseType _fromResponseType(ProjectileRequest request) {
    if (request.responseType.isJson) return ResponseType.json;
    if (request.responseType.isBytes) return ResponseType.bytes;

    return ResponseType.plain;
  }
}