import 'dart:async';

import 'package:projectile/client/http_client.dart';

import 'core.dart';

//Result<IProjectileError, IProjectileResponse>
class Projectile {
  IProjectileClient? _client;
  final List<ProjectileInterceptor> _interceptors = [];
  ProjectileRequest? _request;

  Projectile([this._client]);

  Projectile request(ProjectileRequest request) {
    _request = request;
    return this;
  }

  Projectile addCustomInterceptors(
    Iterable<ProjectileInterceptor> interceptors,
  ) {
    _interceptors.addAll(interceptors);
    return this;
  }

  Projectile addCustomInterceptor(ProjectileInterceptor interceptor) {
    return addCustomInterceptors([interceptor]);
  }

  Future<ProjectileResult> fire() {
    _validRequestBeforeSending();

    final completer = Completer<ProjectileResult>();

    _client ??= HttpClient();

    _client!.sendRequest(
      _request!,
      completer,
      _interceptors,
    );

    _request = null;

    return completer.future;
  }

  void _validRequestBeforeSending() {
    if (_client == null) {
      throw Exception(
          'Make sure that _client implementation of IProjectileClient is not null, check the client folder to see example for dio/http');
    }

    if (_request == null) {
      throw Exception('Make sure that _request is not null');
    }

    if (_request!.isMultipart && _request!.multipart == null) {
      throw Exception(
          'Make sure that multipart in_request with multipart flag = true, is not null');
    }
  }
}
