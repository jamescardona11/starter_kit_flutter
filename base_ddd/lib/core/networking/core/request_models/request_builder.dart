import 'package:base_ddd/core/networking/core/request_models/multipart_file.dart';

import '../misc_models/headers.dart';
import 'content_type.dart';
import 'method.dart';
import 'request.dart';

class RequestBuilder {
  late final String _target;
  late final Method _method;
  late ContentType _contentType;
  late bool _ignoreBaseUrl;

  final Headers _mHeaders = const Headers.empty();
  final Map<String, String> _mParams = const {};
  final Map<String, String> _mQuery = const {};
  final Map<String, String> _mData = const {};

  MultipartFileWrapper? _multipart;

  // ResponseListener mListener;

  RequestBuilder.target(this._target, [this._ignoreBaseUrl = false]);

  RequestBuilder mode(
    Method method, [
    ContentType contentType = ContentType.json,
  ]) {
    _method = method;
    contentType = contentType;
    return this;
  }

  RequestBuilder multipart(MultipartFileWrapper multipart) {
    _multipart = multipart;
    return this;
  }

  RequestBuilder headers(Map<String, String> headers) {
    _mHeaders.addAll(headers);
    return this;
  }

  RequestBuilder defaultHeaders() {
    Map<String, String> headers = {
      'accept': 'application/json',
    };

    _mHeaders.addAll(headers);
    return this;
  }

  RequestBuilder urlParams(Map<String, String> params) {
    _mParams.addAll(params);
    return this;
  }

  RequestBuilder query(Map<String, String> query) {
    _mQuery.addAll(query);
    return this;
  }

  RequestBuilder data(Map<String, String> data) {
    _mData.addAll(data);
    return this;
  }

  ProjectileRequest build() {
    return ProjectileRequest(
      target: _target,
      method: _method,
      contentType: _contentType,
      ignoreBaseUrl: _ignoreBaseUrl,
      isMultipart: _multipart != null,
      multipart: _multipart,
      query: _mQuery,
      headers: _mHeaders,
      urlParams: _mParams,
      data: _mData,
    );
  }
}
