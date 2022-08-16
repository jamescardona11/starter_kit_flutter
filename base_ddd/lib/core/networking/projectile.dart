import 'client/i_projectile_client.dart';
import 'request/request.dart';
import 'projectile_shot.dart';
import 'response/projectile_error.dart';
import 'response/projectile_response.dart';
import 'result/result.dart';

class Projectile {
  final Map<ShotType, IProjectileClient> _shot;
  ProjectileRequest? _request;

  Projectile([this._shot = const {}]);

  Projectile request(ProjectileRequest request) {
    _request = request;
    return this;
  }

  Future<Result<IProjectileError, IProjectileResponse>> fire(
      [ShotType shot = ShotType.def]) {
    _validRequestBeforeSending(shot);

    final result = _shot[shot]!.sendRequest(_request!);
    _request = null;

    return result;
  }

  void _validRequestBeforeSending(ShotType shot) {
    if (_request == null) {
      throw Exception(
          'Make sure that result [isSuccess] before accessing [success]');
    }

    if (!_shot.containsKey(shot)) {
      throw Exception(
          'Make sure that result [isSuccess] before accessing [success]');
    }
  }
}
