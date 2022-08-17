import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';

import '../request_models/request_models.dart';
import '../response_models/response_models.dart';
import '../result_models/result_models.dart';
import 'i_projectile_client.dart';

class DioClient extends IProjectileClient {
  final Dio _dioClient;

  DioClient(this._dioClient);

  @override
  Future<Result<IProjectileError, IProjectileResponse>> sendRequest(
      ProjectileRequest request) async {
    try {
      final url = request.getString();

      final response = await _dioClient.request(
        url,
        options: Options(
          method: request.method.value,
          headers: request.headers
            ..addAll({'content-type': request.contentType.value}),
          contentType: request.contentType.value,
        ),
        data: request.data,
      );

      final base = BaseResponse(
        statusCode: response.statusCode,
        headers: response.headers.map,
        body: response.data,
        originalData: response.data,
        originalRequest: request,
      );

      return Success(base.convert());
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
    } finally {}
  }
}
