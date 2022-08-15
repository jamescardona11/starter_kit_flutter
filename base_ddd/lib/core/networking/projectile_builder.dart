import 'models/models.dart';

class ProjectileBuilder {
  final Method _method;
  final ContentType _contentType;
  final String _target;

  Map<String, String> _mHeaders = {};
  Map<String, String> _mQuery = {};
  Map<String, String> _mData = {};

  // ResponseListener mListener;

  // int mNetworkTimeout;
  // Object mTag;
  // RetryPolicy mRetryPolicy;
  // int mRetryCount;

  ProjectileBuilder.fromTarget(
    this._method,
    this._target,
    this._contentType,
  );

  ProjectileBuilder headers(Map<String, String> headers) {
    _mHeaders = headers;
    return this;
  }

  ProjectileBuilder defaultHeaders() {
    Map<String, String> headers = {};

    _mHeaders = headers;
    return this;
  }

  ProjectileBuilder query(Map<String, String> query) {
    _mQuery = query;
    return this;
  }

  ProjectileBuilder data(Map<String, String> data) {
    _mData = data;
    return this;
  }

  Future<void> fire() async {}
}
