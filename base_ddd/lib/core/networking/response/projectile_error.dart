import '../request/request.dart';

abstract class IProjectileError {
  final String? cause;
  final StackTrace? stackTrace;
  final ProjectileRequest? request;

  const IProjectileError({
    this.cause,
    this.stackTrace,
    this.request,
  });
}

class NoInternetConnectionError extends IProjectileError {
  const NoInternetConnectionError({
    required String cause,
    required StackTrace stackTrace,
    required ProjectileRequest request,
  }) : super(cause: cause, stackTrace: stackTrace, request: request);
}

class TimeoutError extends IProjectileError {
  const TimeoutError({
    required String cause,
    required StackTrace stackTrace,
    required ProjectileRequest request,
  }) : super(cause: cause, stackTrace: stackTrace, request: request);
}

class UnknownError extends IProjectileError {
  const UnknownError({
    required String cause,
    required StackTrace stackTrace,
    required ProjectileRequest request,
  }) : super(cause: cause, stackTrace: stackTrace, request: request);
}


// class FailureRequest extends IProjectileError {
//   final ErrorResponse base;

//   const FailureRequest(
//     this.base,
//   );
// }