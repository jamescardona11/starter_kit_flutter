import 'client/i_projectile_client.dart';
import 'request/request.dart';
import 'response/projectile_error.dart';
import 'response/projectile_response.dart';
import 'result/result.dart';

class Projectile {
  final IProjectileClient? client;
  ProjectileRequest? _request;

  Projectile([this.client]);

  Projectile request(ProjectileRequest request) {
    _request = request;
    return this;
  }

  Future<Result<IProjectileError, IProjectileResponse>> fire() {
    _validRequestBeforeSending();

    final result = client!.sendRequest(_request!);
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
