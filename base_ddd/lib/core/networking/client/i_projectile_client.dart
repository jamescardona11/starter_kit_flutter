import 'dart:async';

import '../interceptors/interceptors.dart';
import '../request_models/request_models.dart';
import '../response_models/response_models.dart';
import '../result_models/result_models.dart';

abstract class IClient<T> {
  final completer = Completer<T>();
  List<ProjectileInterceptor> listInterceptors = const [];

  Future<T> sendRequest(
    ProjectileRequest request,
  );

  void finallyBlock();
}

abstract class IProjectileClient
    extends IClient<Result<ResponseError, ResponseSuccess>>
    with RunInterceptor {
  /// override this to implement request
  /// don't catch exception if you want if catch by default by `runRequest`
  Future<ResponseSuccess> createRequest(ProjectileRequest request);

  @override
  Future<Result<ResponseError, ResponseSuccess>> sendRequest(
    ProjectileRequest request, [
    List<ProjectileInterceptor> interceptors = const [],
  ]) =>
      _sendRequest(request, interceptors);

  /// Run request and everything relate to response and catch errors
  Future<Result<ResponseError, ResponseSuccess>> _sendRequest(
    ProjectileRequest request, [
    List<ProjectileInterceptor> interceptors = const [],
  ]) async {
    listInterceptors = interceptors;
    final requestData = await _beforeRequest(request);

    try {
      _runFromCreate(requestData);
    } catch (error, stackTrace) {
      _responseError(ResponseError(
        request: request,
        error: error,
        stackTrace: stackTrace,
      ));
    } finally {
      finallyBlock();
    }

    return completer.future;
  }

  /// Run `createRequest` and get response
  Future<void> _runFromCreate(
    ProjectileRequest requestData,
  ) async {
    final responseRequest = await createRequest(requestData);

    if (responseRequest.isSuccess) {
      _responseSuccess(responseRequest);
    } else {
      _responseError(
          ResponseError(request: requestData, error: responseRequest));
    }
  }

  /// Before start the request in `createRequest`
  Future<ProjectileRequest> _beforeRequest(ProjectileRequest request) =>
      runRequestInterceptors(listInterceptors, request);

  /// Request success
  Future<void> _responseSuccess(ResponseSuccess responseData) async {
    final response =
        await runResponseInterceptors(listInterceptors, responseData);
    completer.complete(Success(response));
  }

  /// Request error
  Future<void> _responseError(ResponseError error) async {
    final errorData = await runErrorInterceptors(listInterceptors, error);
    completer.complete(Failure(errorData));
  }
}
