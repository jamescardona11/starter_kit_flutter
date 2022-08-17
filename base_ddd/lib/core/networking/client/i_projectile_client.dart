import '../request_models/request_models.dart';
import '../response_models/response_models.dart';
import '../result_models/result_models.dart';

abstract class IProjectileClient {
  IProjectileClient();

  Future<Result<IProjectileError, IProjectileResponse>> sendRequest(
      ProjectileRequest request);
}
