import 'dart:async';

import '../interceptors/interceptors.dart';
import '../request_models/request_models.dart';
import '../response_models/response_models.dart';
import '../result_models/result_models.dart';

abstract class IClient<T> {
  final completer = Completer<T>();
  List<InterceptorContract> listInterceptors = const [];

  Future<T> runRequest(
    ProjectileRequest request,
  );

  void finallyBlock();
}

abstract class IRequestState {
  Future<ProjectileRequest> onRequest(ProjectileRequest request);

  Future<void> onResponse(ProjectileResponse response);

  Future<void> onError(ProjectileError projectileError);
}

abstract class IProjectileClient
    extends IClient<Result<ProjectileError, ProjectileResponse>>
    with RunInterceptor
    implements IRequestState {
  /// override this to implement request
  /// don't catch exception if you want if catch by default by `runRequest`
  Future<ProjectileResponse> createRequest(ProjectileRequest request);

  @override
  Future<Result<ProjectileError, ProjectileResponse>> runRequest(
    ProjectileRequest request, [
    List<InterceptorContract> interceptors = const [],
  ]) async {
    listInterceptors = interceptors;

    final requestData = await onRequest(request);

    try {
      _responseFromCreate(requestData);
    } catch (error, stackTrace) {
      _onCatchError(
        requestData,
        error,
        stackTrace,
      );
    } finally {
      finallyBlock();
    }

    return completer.future;
  }

  @override
  Future<ProjectileRequest> onRequest(ProjectileRequest request) =>
      runRequestInterceptors(listInterceptors, request);

  @override
  Future<void> onResponse(ProjectileResponse responseData) async {
    final response =
        await runResponseInterceptors(listInterceptors, responseData);
    completer.complete(Success(response));
  }

  @override
  Future<void> onError(ProjectileError error) async {
    final errorData = await runErrorInterceptors(listInterceptors, error);
    completer.complete(Failure(errorData));
  }

  Future<void> _responseFromCreate(
    ProjectileRequest requestData,
  ) async {
    final responseRequest = await createRequest(requestData);

    if (responseRequest.isSuccess) {
      onResponse(responseRequest);
    } else {
      _onResponseError(requestData, responseRequest);
    }
  }

  Future<void> _onResponseError(
    ProjectileRequest request,
    ProjectileResponse responseRequest,
  ) async {
    onError(
      ProjectileError(
        request: request,
        error: responseRequest,
      ),
    );
  }

  Future<void> _onCatchError(
    ProjectileRequest request,
    Object error,
    StackTrace stackTrace,
  ) async {
    onError(
      ProjectileError(
        request: request,
        error: error,
        stackTrace: stackTrace,
      ),
    );
  }
}
