import '../misc_models/misc_models.dart';
import 'helper_types.dart';
import 'method.dart';
import 'multipart_file.dart';

class ProjectileRequest {
  final String target;
  final bool ignoreBaseUrl;
  final Method method;
  final ContentType contentType;
  final PResponseType responseType;
  final Headers headers;
  final bool isMultipart;
  final MultipartFileWrapper? multipart;
  final Map<String, String> urlParams;
  final Map<String, String> query;
  final Map<String, String> data;

  BaseConfig? _config;

  final _moreThanTwoSlashesRegex = RegExp('/{2,}');

  ProjectileRequest({
    required this.target,
    required this.method,
    this.isMultipart = false,
    this.ignoreBaseUrl = false,
    this.multipart,
    this.contentType = ContentType.json,
    this.responseType = PResponseType.json,
    this.headers = const Headers.empty(),
    this.urlParams = const {},
    this.query = const {},
    this.data = const {},
  });

  set setConfig(BaseConfig config) => _config = config;

  void addDefaultHeaders() {
    headers
      ..addContentType(contentType.value)
      ..addBaseConfig(_config ?? const BaseConfig());
  }

  String get methodStr => isMultipart ? Method.POST.value : method.value;

  Uri getUri([String baseUrl = '']) {
    final bUrl = ignoreBaseUrl ? '' : baseUrl;

    final tempUrl =
        (bUrl + target).trim().replaceAll(_moreThanTwoSlashesRegex, '/');

    return Uri.https(
      _addDynamicAddressParams(tempUrl),
      '',
      query,
    );
  }

  String getUrl([String baseUrl = '']) {
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
