// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../misc_models/misc_models.dart';
import 'helper_types.dart';
import 'method.dart';
import 'multipart_file.dart';

/// {@template helper_types}
/// {@endtemplate}
class ProjectileRequest {
  final String target;
  final bool ignoreBaseUrl;

  final Method method;
  final ContentType contentType;
  final PResponseType responseType;
  final bool isMultipart;
  final Map<String, dynamic> urlParams;
  final Map<String, dynamic> queries;
  final Map<String, dynamic> data;
  final MultipartFileWrapper? multipart;

  Map<String, dynamic>? headers;

  // final _moreThanTwoSlashesRegex = RegExp('/{2,}');

  ProjectileRequest({
    required this.target,
    required this.method,
    this.isMultipart = false,
    this.ignoreBaseUrl = false,
    this.multipart,
    this.contentType = ContentType.json,
    this.responseType = PResponseType.json,
    this.headers = const {},
    this.urlParams = const {},
    this.queries = const {},
    this.data = const {},
  });

  void addDefaultHeaders(BaseConfig config) {
    headers ??= {'content-type': contentType}..addAll(config.baseHeaders ?? {});
  }

  String get methodStr => isMultipart ? Method.POST.value : method.value;

  Uri getUri([String baseUrl = '']) {
    final bUrl = ignoreBaseUrl ? '' : baseUrl;

    final tempUrl = (bUrl + target).trim();

    final uri = Uri.parse(_addDynamicAddressParams(tempUrl));
    if (queries.isNotEmpty) {
      uri.replace(
          queryParameters:
              queries.map((key, value) => MapEntry(key, value.toString())));
    }

    return uri;
  }

  String getUrl([String baseUrl = '']) {
    return getUri(baseUrl).toString();
  }

  String _addDynamicAddressParams(String tempUrl) =>
      urlParams.entries.fold(tempUrl, (
        String previousUrl,
        MapEntry<String, dynamic> currentParam,
      ) {
        final String key = currentParam.key;
        final String value = currentParam.value.toString();
        return previousUrl.replaceAll('{$key}', value);
      });

  @override
  String toString() =>
      'ProjectileRequest(\ntarget: $target, ignoreBaseUrl: $ignoreBaseUrl, method: ${method.value},\n ContentType: ${contentType.value}, responseType: ${responseType.toString()}, headers: ${headers.toString()},\nurlParams: $urlParams, queries: $queries, data: $data,\nisMultipart: $isMultipart, multipart: ${multipart?.toString()}';

  ProjectileRequest copyWith({
    String? target,
    bool? ignoreBaseUrl,
    Method? method,
    ContentType? contentType,
    PResponseType? responseType,
    Map<String, dynamic>? headers,
    bool? isMultipart,
    Map<String, dynamic>? urlParams,
    Map<String, dynamic>? queries,
    Map<String, dynamic>? data,
    MultipartFileWrapper? multipart,
  }) {
    return ProjectileRequest(
      target: target ?? this.target,
      ignoreBaseUrl: ignoreBaseUrl ?? this.ignoreBaseUrl,
      method: method ?? this.method,
      contentType: contentType ?? this.contentType,
      responseType: responseType ?? this.responseType,
      headers: headers ?? this.headers ?? const {},
      isMultipart: isMultipart ?? this.isMultipart,
      urlParams: urlParams ?? this.urlParams,
      queries: queries ?? this.queries,
      data: data ?? this.data,
      multipart: multipart ?? this.multipart,
    );
  }
}
