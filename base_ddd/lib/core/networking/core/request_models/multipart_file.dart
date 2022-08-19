import 'package:http_parser/http_parser.dart' show MediaType;

/// `MultipartFileWrapper` is a wrapper for Multipart class from dio or http
/// https://github.com/flutterchina/dio/blob/develop/dio/lib/src/multipart_file.dart
/// https://github.com/dart-lang/http/blob/master/pkgs/http/lib/src/multipart_file.dart
///
/// This wrapper don't override any original behavior
///
class MultipartFileWrapper {
  MultipartFileWrapper({
    required this.field,
    required this.contentType,
    this.length = -1,
    this.filename,
    this.filePath = '',
  });

  /// key of json data
  final String field;
  final String? filename;
  final String? filePath;
  final MediaType? contentType;
  final int? length;

  factory MultipartFileWrapper.fromBytes({
    required List<int> value,
    required String field,
    String? filename,
    MediaType? contentType,
  }) =>
      MultipartFileWrapper(
        length: value.length,
        filename: filename,
        contentType: contentType,
        field: field,
      );

  factory MultipartFileWrapper.fromString({
    required String value,
    required String field,
    String? filename,
    MediaType? contentType,
    final Map<String, List<String>>? headers,
  }) =>
      MultipartFileWrapper(
        field: field,
        filename: filename,
        contentType: contentType,
      );

  factory MultipartFileWrapper.fromFile({
    required String filePath,
    required String field,
    String? filename,
    MediaType? contentType,
  }) =>
      MultipartFileWrapper(
        field: field,
        filename: filename,
        contentType: contentType,
        filePath: filePath,
      );
}
