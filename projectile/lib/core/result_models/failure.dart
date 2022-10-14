// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:projectile/core/result_models/result.dart';

import '../request_models/request_models.dart';

/// inspired on DIOError class

class FailureResult extends ProjectileResult {
  FailureResult({
    required this.request,
    this.error,
    this.stackTrace,
  }) : type = ProjectileErrorType.fromError(error);

  /// Request info.
  final ProjectileRequest request;

  /// The original error/exception object; It's usually not null when `type`
  final dynamic error;
  final StackTrace? stackTrace;

  final ProjectileErrorType type;

  String get message => (error?.toString() ?? '');

  @override
  String toString() {
    var msg = 'FailureResult [$type]: $message';
    if (error is Error) {
      msg += '\n${(error as Error).stackTrace}';
    }
    if (stackTrace != null) {
      msg += '\nSource stack:\n$stackTrace';
    }
    return msg;
  }

  @override
  bool operator ==(covariant FailureResult other) {
    if (identical(this, other)) return true;

    return other.request == request &&
        other.error == error &&
        other.stackTrace == stackTrace &&
        other.type == type;
  }

  @override
  int get hashCode {
    return request.hashCode ^
        error.hashCode ^
        stackTrace.hashCode ^
        type.hashCode;
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
