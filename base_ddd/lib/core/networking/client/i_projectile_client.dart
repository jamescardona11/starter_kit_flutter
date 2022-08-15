import '../request/request.dart';

abstract class IProjectileClient<R> {
  IProjectileClient();

  Future<R> sendRequest(ProjectileRequest request);

  // R transformProjectileRequest(ProjectileRequest request);
}
