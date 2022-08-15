import 'content_type.dart';
import 'method.dart';

class ProjectileRequest {
  final String url;
  final Method method;
  final ContentType contentType;
  final Map<String, String> headers;
  final Map<String, String> params;
  final Map<String, String> query;
  final Map<String, String> data;

  ProjectileRequest({
    required this.url,
    required this.method,
    this.contentType = ContentType.json,
    this.headers = const {},
    this.params = const {},
    this.query = const {},
    this.data = const {},
  });

  Uri get uri => Uri(path: url);
}
