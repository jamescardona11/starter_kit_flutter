import 'client/i_projectile_client.dart';
import 'interceptors/interceptor_contract.dart';
import 'request_models/request_models.dart';
import 'response_models/response_models.dart';
import 'result_models/result.dart';

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

    final result = _client!.sendRequest(_request!, _interceptors);
    _request = null;

    return result;
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
