import 'dart:async';
import 'dart:io';

import '../request_models/request_models.dart';
import 'response.dart';

/// inspired on DIOError class

class ResponseError {
  ResponseError({
    required this.request,
    this.error,
    this.stackTrace,
  }) : type = ProjectileErrorType.fromError(error) {
    response = type.isResponse ? (error as ResponseSuccess) : null;
  }

  /// Response info, it may be `null` if the request can't reach to
  /// the http server, for example, occurring a dns error, network is not available.
  ResponseSuccess? response;

  /// Request info.
  final ProjectileRequest request;

  /// The original error/exception object; It's usually not null when `type`
  final dynamic error;
  final StackTrace? stackTrace;

  final ProjectileErrorType type;

  String get message => (error?.toString() ?? '');

  @override
  String toString() {
    var msg = 'ProjectileError [$type]: $message';
    if (error is Error) {
      msg += '\n${(error as Error).stackTrace}';
    }
    if (stackTrace != null) {
      msg += '\nSource stack:\n$stackTrace';
    }
    return msg;
  }
}

enum ProjectileErrorType {
  connectTimeout,
  socketError,

  /// When the server response, but with a incorrect status, such as 404, 503...
  response,

  // unexpected error
  other;

  bool get isResponse => this == response;

  static ProjectileErrorType fromError(Object error) {
    if (error is TimeoutException) {
      return connectTimeout;
    } else if (error is SocketException) {
      return socketError;
    } else if (error is Exception) {
      return other;
    }

    return response;
  }
}
