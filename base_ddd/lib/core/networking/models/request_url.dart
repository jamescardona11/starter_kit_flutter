import 'dart:convert';

import 'models.dart';

class RequestUrl {
  final String _baseUrl;
  final String _requestUrl;
  final Map<String, String> _urlParams;
  final Map<String, String> _query;

  final _moreThanTwoSlashesRegex = RegExp('\/{2,}');

  RequestUrl(
    this._baseUrl,
    this._requestUrl,
    this._urlParams,
    this._query,
  );

  factory RequestUrl.fromRequest(
    String baseUrl,
    ProjectileRequest request,
  ) =>
      RequestUrl(
        baseUrl,
        request.target,
        request.urlParams,
        request.query,
      );

  Uri getUri() {
    final tempUrl = (_baseUrl + _requestUrl)
        .trim()
        .replaceAll(_moreThanTwoSlashesRegex, '/');

    return Uri.https(
      _addDynamicAddressParams(tempUrl),
      '',
      _query,
    );
  }

  String getString() {
    return getUri().toString();
  }

  String _addDynamicAddressParams(String tempUrl) =>
      _urlParams.entries.fold(tempUrl, (
        String previousUrl,
        MapEntry<String, String> currentParam,
      ) {
        final String key = currentParam.key;
        final String value = currentParam.value;
        return previousUrl.replaceAll('{$key}', value);
      });
}
