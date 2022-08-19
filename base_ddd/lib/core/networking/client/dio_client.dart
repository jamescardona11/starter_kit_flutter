import 'dart:async';
import 'package:base_ddd/core/networking/core/request_models/multipart_file.dart';
import 'package:dio/dio.dart' hide Headers;

import '../core/misc_models/headers.dart';
import '../core/request_models/request_models.dart';
import '../core/response_models/response_models.dart';
import 'i_projectile_client.dart';

class DioClient extends IProjectileClient {
  final Dio _dioClient;

  DioClient(
    this._dioClient, [
    super.config,
  ]);

  @override
  Future<ResponseSuccess> createRequest(ProjectileRequest request) async {
    final url = request.getUrl();

    final data = request.isMultipart ? _createFromMap(request) : request.data;

    final response = await _dioClient.request(
      url,
      options: Options(
        method: request.methodStr,
        headers: request.headers.asMap,
        contentType: request.contentType.value,
      ),
      data: data,
    );

    return ResponseSuccess(
      statusCode: response.statusCode,
      headers: Headers.fromMap(response.headers.map),
      body: response.data,
      originalData: response.data,
      originalRequest: request,
    );
  }

  Future<FormData> _createFromMap(ProjectileRequest request) async {
    final multipart = await createNativeMultipartObject(request.multipart!);

    return FormData.fromMap(
      <String, dynamic>{}
        ..addAll(request.data)
        ..addAll({request.multipart!.field: multipart}),
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
}
