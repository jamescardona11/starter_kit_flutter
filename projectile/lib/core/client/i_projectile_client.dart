import 'dart:async';

import '../interceptors/interceptors.dart';
import '../misc_models/config.dart';
import '../request_models/request_models.dart';
import '../result_models/result_models.dart';

abstract class IClient<T> {
  late final Completer<T> completer;
  late final List<ProjectileInterceptor> listInterceptors;

  Future<T> sendRequest(
    ProjectileRequest request,
    Completer<T> completer,
  );

  Future<dynamic> createNativeMultipartObject(
      MultipartFileWrapper multipartFileWrapper);

  void finallyBlock();
}

abstract class IProjectileClient extends IClient<ProjectileResult>
    with RunInterceptor {
  IProjectileClient([this.config = const BaseConfig()]);

  BaseConfig config;

  /// override this to implement request
  /// don't catch exception if you want if catch by default by `runRequest`
  Future<SuccessResult> createRequest(ProjectileRequest request);

  @override
  Future<ProjectileResult> sendRequest(
    ProjectileRequest request,
    Completer<ProjectileResult> completer, [
    List<ProjectileInterceptor> interceptors = const [],
  ]) {
    this.completer = completer;
    listInterceptors = interceptors;

    if (config.enableLog) {
      listInterceptors.add(BasicProjectileLogs(config.logsTag));
    }

    request.addDefaultHeaders(config);

    return _sendRequest(request);
  }

  /// Run request and everything relate to response and catch errors
  Future<ProjectileResult> _sendRequest(
    ProjectileRequest request,
  ) async {
    try {
      final requestData = await _beforeRequest(request);
      _runFromCreate(requestData);
    } catch (error, stackTrace) {
      _responseError(FailureResult(
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
          FailureResult(request: requestData, error: responseRequest));
    }
  }

  /// Before start the request in `createRequest`
  Future<ProjectileRequest> _beforeRequest(ProjectileRequest request) =>
      runRequestInterceptors(listInterceptors, request);

  /// Request success
  Future<void> _responseSuccess(SuccessResult responseData) async {
    final response =
        await runResponseInterceptors(listInterceptors, responseData);
    completer.complete(response);
  }

  /// Request error
  Future<void> _responseError(FailureResult error) async {
    final errorData = await runErrorInterceptors(listInterceptors, error);
    completer.complete(errorData);
  }
}
