import 'dart:async';
import 'package:dio/dio.dart' hide Headers;

import '../core/misc_models/headers.dart';
import '../core/request_models/request_models.dart';
import '../core/response_models/response_models.dart';
import 'i_projectile_client.dart';

class DioClient extends IProjectileClient {
  final Dio _dioClient;

  DioClient(this._dioClient);

  @override
  Future<ResponseSuccess> createRequest(ProjectileRequest request) async {
    final url = request.getString();

    final response = await _dioClient.request(
      url,
      options: Options(
        method: request.method.value,
        headers: (request.headers
              ..addAll({'content-type': request.contentType.value}))
            .asMap,
        contentType: request.contentType.value,
      ),
      data: request.data,
    );

    return ResponseSuccess(
      statusCode: response.statusCode,
      headers: Headers.fromMap(response.headers.map),
      body: response.data,
      originalData: response.data,
      originalRequest: request,
    );
  }

  @override
  void finallyBlock() {
    // _dioClient.close();
  }
}
