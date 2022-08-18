import 'client/i_projectile_client.dart';
import 'interceptors/interceptor_contract.dart';
import 'request_models/request_models.dart';

//Result<IProjectileError, IProjectileResponse>
class Projectile<T> {
  final IProjectileClient? client;
  final List<InterceptorContract> _interceptors = [];
  ProjectileRequest? _request;

  Projectile([this.client]);

  Projectile request(ProjectileRequest request) {
    _request = request;
    return this;
  }

  Projectile addCustomInterceptors(List<InterceptorContract> interceptors) {
    _interceptors.addAll(interceptors);
    return this;
  }

  Projectile addCustomInterceptor(InterceptorContract interceptor) {
    _interceptors.add(interceptor);
    return this;
  }

  Future<T> fire() {
    _validRequestBeforeSending();

    final result = client!.sendRequest(_request!, _interceptors);
    _request = null;

    return result;
  }

  void _validRequestBeforeSending() {
    if (_request == null) {
      throw Exception('Make sure that _request is not null');
    }

    if (client == null) {
      throw Exception(
          'Make sure that _shot map contains the implementation of IProjectileClient, check the client folder to see example for dio, http');
    }
  }
}
