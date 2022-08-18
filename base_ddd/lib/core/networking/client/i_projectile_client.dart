import 'dart:async';
import 'dart:io';

import '../interceptors/interceptors.dart';
import '../request_models/request_models.dart';
import '../response_models/response_models.dart';
import '../result_models/result_models.dart';

abstract class IClient<T> {
  final completer = Completer<T>();

  Future<T> sendRequest(
    ProjectileRequest request,
  );

  void finallyBlock();
}

abstract class IProjectileClient
    extends IClient<Result<IProjectileError, IProjectileResponse>>
    with RunInterceptor {
  IProjectileClient();

  @override
  Future<Result<IProjectileError, IProjectileResponse>> sendRequest(
    ProjectileRequest request, [
    List<InterceptorContract> interceptors = const [],
  ]) async {
    // run before request interceptors

    final response = await _catchRequest(request);

    // run interceptor for error or response
    response.fold((e) {}, (s) {});

    // return final response
    return response;
  }

  Future<Result<IProjectileError, IProjectileResponse>> runRequest(
      ProjectileRequest request);

  Future<Result<IProjectileError, IProjectileResponse>> _catchRequest(
      ProjectileRequest request) {
    try {
      completer.complete(runRequest(request));
    } on TimeoutException catch (error, stackTrace) {
      completer.complete(
        Failure(
          TimeoutError(
            cause: error.message ?? 'timeout',
            stackTrace: stackTrace,
            request: request,
          ),
        ),
      );
    } on SocketException catch (error, stackTrace) {
      completer.complete(
        Failure(
          NoInternetConnectionError(
            cause: error.message,
            stackTrace: stackTrace,
            request: request,
          ),
        ),
      );
    } on Exception catch (error, stackTrace) {
      completer.complete(
        Failure(
          UnknownError(
            cause: error.toString(),
            stackTrace: stackTrace,
            request: request,
          ),
        ),
      );
    } finally {
      finallyBlock();
    }

    return completer.future;
  }
}
