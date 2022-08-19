import '../request_models/request.dart';

class ResponseSuccess {
  final int? statusCode;
  final Map? body;
  final Map<String, dynamic> headers;

  final ProjectileRequest? originalRequest;
  final Object? originalData;

  ResponseSuccess({
    required this.headers,
    required this.body,
    this.statusCode = -1,
    this.originalRequest,
    this.originalData,
  });

  bool get isSuccess =>
      statusCode != null && statusCode! != -1 && statusCode! < 300;
}
