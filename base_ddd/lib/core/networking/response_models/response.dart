import '../request_models/request.dart';

abstract class IProjectileResponse {
  final int? statusCode;
  final Map? body;
  final Map<String, dynamic> headers;

  final ProjectileRequest? originalRequest;
  final Object? originalData;

  IProjectileResponse({
    required this.headers,
    required this.body,
    this.statusCode = -1,
    this.originalRequest,
    this.originalData,
  });
}

class BaseResponse extends IProjectileResponse {
  BaseResponse({
    required super.headers,
    required super.body,
    super.statusCode,
    super.originalData,
    super.originalRequest,
  });

  IProjectileResponse convert() => _validStatusCode ? _success() : _error();

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

  bool get _validStatusCode =>
      statusCode != null && statusCode! != -1 && statusCode! < 300;
}

class SuccessResponse extends IProjectileResponse {
  SuccessResponse({
    required super.headers,
    required super.body,
    super.statusCode,
    super.originalData,
    super.originalRequest,
  });
}

class ErrorResponse extends IProjectileResponse {
  ErrorResponse({
    required super.headers,
    required super.body,
    super.statusCode,
    super.originalData,
    super.originalRequest,
  });
}
