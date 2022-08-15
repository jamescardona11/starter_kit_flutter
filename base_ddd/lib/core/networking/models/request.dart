import 'content_type.dart';
import 'method.dart';

class ProjectileRequest {
  final String target;
  final Method method;
  final ContentType contentType;
  final Map<String, String> headers;
  final Map<String, String> urlParams;
  final Map<String, String> query;
  final Map<String, String> data;

  ProjectileRequest({
    required this.target,
    required this.method,
    this.contentType = ContentType.json,
    this.headers = const {},
    this.urlParams = const {},
    this.query = const {},
    this.data = const {},
  });
}
