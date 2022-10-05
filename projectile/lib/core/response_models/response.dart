import '../misc_models/headers.dart';
import '../request_models/request.dart';

class ResponseSuccess {
  final int? statusCode;
  final dynamic data;
  final Headers headers;

  final ProjectileRequest originalRequest;

  // final PResponseType type;
  // final Object? originalData;

  ResponseSuccess({
    required this.headers,
    required this.data,
    required this.originalRequest,
    this.statusCode,
    // this.type = PResponseType.unknown,
    // this.originalData,
  });

  factory ResponseSuccess.def({
    required dynamic data,
    required Map<String, dynamic> headers,
    required ProjectileRequest originalRequest,
    int? statusCode,
    // this.originalData,
  }) =>
      ResponseSuccess(
        headers: Headers.fromMap(headers),
        data: data,
        originalRequest: originalRequest,
      );

  Map<String, dynamic>? get dataJson =>
      isJson ? data as Map<String, dynamic> : null;

  List<int>? get dataBytes => isBytes ? data as List<int> : null;

  String? get dataString => isPlain ? data as String : null;

  bool get isJson => originalRequest.responseType.isJson;

  bool get isPlain => originalRequest.responseType.isPlain;

  bool get isBytes => originalRequest.responseType.isBytes;

  bool get isSuccess =>
      statusCode != null &&
      ![
        400, // Bad Request
        401, // Unauthorized
        402, // Payment Required
        403, // Forbidden
        404, // Not Found
        405, // Method Not Allowed,
        413, // Request Entity Too Large
        414, // Request URI Too Long,
        415, // Unsupported Media Type
      ].contains(statusCode);

  @override
  String toString() =>
      'ResponseSuccess(\nstatusCode: $statusCode, data: $data, headers: ${headers.toString()}\n)';
}
