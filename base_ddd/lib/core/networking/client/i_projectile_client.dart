import '../models/request.dart';

abstract class IProjectileClient<R extends Object?> {
  Future<void> sendRequest(ProjectileRequest request);

  R transformProjectileRequest(ProjectileRequest request);
}
