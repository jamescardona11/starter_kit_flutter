import 'dart:async';

import '../client/i_projectile_client.dart';
import '../core/interceptors/interceptor_contract.dart';
import '../core/request_models/request_models.dart';
import '../core/response_models/response_models.dart';
import '../core/result_models/result.dart';

//Result<IProjectileError, IProjectileResponse>
class Projectile {
  final IProjectileClient? _client;
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

  Future<Result<ResponseError, ResponseSuccess>> fire() {
    _validRequestBeforeSending();

    final completer = Completer<Result<ResponseError, ResponseSuccess>>();

    _client!.sendRequest(
      _request!,
      completer,
      _interceptors,
    );

    _request = null;

    return completer.future;
  }

  void _validRequestBeforeSending() {
    if (_request == null) {
      throw Exception('Make sure that _request is not null');
    }

    if (_client == null) {
      throw Exception(
          'Make sure that _client implementation of IProjectileClient is not null, check the client folder to see example for dio/http');
    }
  }
}
