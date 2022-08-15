import 'package:base_ddd/core/networking/request/request.dart';

abstract class IProjectileResponse {
  final int statusCode;
  final Map? body;
  final Map<String, String> headers;

  final ProjectileRequest? originalRequest;
  final Object? originalData;

  IProjectileResponse({
    required this.statusCode,
    required this.headers,
    required this.body,
    this.originalRequest,
    this.originalData,
  });
}

class BaseResponse extends IProjectileResponse {
  BaseResponse({
    required super.statusCode,
    required super.headers,
    required super.body,
    super.originalData,
    super.originalRequest,
  });

  IProjectileResponse convert() => statusCode < 300 ? _success() : _error();

  SuccessResponse _success() => SuccessResponse(
        statusCode: statusCode,
        headers: headers,
        body: body,
        originalData: originalData,
        originalRequest: originalRequest,
      );

  SuccessResponse _error() => SuccessResponse(
        statusCode: statusCode,
        headers: headers,
        body: body,
        originalData: originalData,
        originalRequest: originalRequest,
      );
}

class SuccessResponse extends IProjectileResponse {
  SuccessResponse({
    required super.statusCode,
    required super.headers,
    required super.body,
    super.originalData,
    super.originalRequest,
  });
}

class ErrorResponse extends IProjectileResponse {
  ErrorResponse({
    required super.statusCode,
    required super.headers,
    required super.body,
    super.originalData,
    super.originalRequest,
  });
}
