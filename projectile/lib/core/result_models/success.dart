import 'package:projectile/core/core.dart';

class SuccessResult extends ProjectileResult {
  final int? statusCode;
  final dynamic data;
  final Headers headers;

  final ProjectileRequest originalRequest;

  // final PResponseType type;
  // final Object? originalData;

  SuccessResult({
    required this.headers,
    required this.data,
    required this.originalRequest,
    this.statusCode,
    // this.type = PResponseType.unknown,
    // this.originalData,
  });

  factory SuccessResult.def({
    required dynamic data,
    required Map<String, dynamic> headers,
    required ProjectileRequest originalRequest,
    int? statusCode,
    // this.originalData,
  }) =>
      SuccessResult(
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

  bool get isSuccessRequest =>
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
      'SuccessResult(\nstatusCode: $statusCode, data: $data, headers: ${headers.toString()}\n)';

  @override
  bool operator ==(covariant SuccessResult other) {
    if (identical(this, other)) return true;

    return other.statusCode == statusCode &&
        other.data == data &&
        other.headers == headers &&
        other.originalRequest == originalRequest;
  }

  @override
  int get hashCode {
    return statusCode.hashCode ^
        data.hashCode ^
        headers.hashCode ^
        originalRequest.hashCode;
  }
}
