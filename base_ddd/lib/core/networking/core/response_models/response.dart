import 'package:base_ddd/core/networking/core/request_models/request_models.dart';

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
    this.statusCode = -1,
    // this.type = PResponseType.unknown,
    // this.originalData,
  });

  factory ResponseSuccess.def({
    required dynamic data,
    required Map<String, dynamic> headers,
    required ProjectileRequest originalRequest,
    int? statusCode = -1,
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

  bool get isSuccess =>
      statusCode != null && statusCode! != -1 && statusCode! < 300;

  bool get isJson => originalRequest.responseType.isJson;

  bool get isPlain => originalRequest.responseType.isPlain;

  bool get isBytes => originalRequest.responseType.isBytes;
}
