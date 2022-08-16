import '../request/request.dart';
// import '../response/projectile_error.dart';
import '../response/response.dart';
import '../result/result.dart';

abstract class IProjectileClient {
  IProjectileClient();

  // Future<R> sendRequest(ProjectileRequest request);
  Future<Result<IProjectileError, IProjectileResponse>> sendRequest(
      ProjectileRequest request);
}
