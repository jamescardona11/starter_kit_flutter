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

  final _moreThanTwoSlashesRegex = RegExp('/{2,}');

  ProjectileRequest({
    required this.target,
    required this.method,
    this.contentType = ContentType.json,
    this.headers = const {},
    this.urlParams = const {},
    this.query = const {},
    this.data = const {},
  });

  Uri getUri([String baseUrl = '']) {
    final tempUrl =
        (baseUrl + target).trim().replaceAll(_moreThanTwoSlashesRegex, '/');

    return Uri.https(
      _addDynamicAddressParams(tempUrl),
      '',
      query,
    );
  }

  String getString([String baseUrl = '']) {
    return getUri(baseUrl).toString();
  }

  String _addDynamicAddressParams(String tempUrl) =>
      urlParams.entries.fold(tempUrl, (
        String previousUrl,
        MapEntry<String, String> currentParam,
      ) {
        final String key = currentParam.key;
        final String value = currentParam.value;
        return previousUrl.replaceAll('{$key}', value);
      });
}
