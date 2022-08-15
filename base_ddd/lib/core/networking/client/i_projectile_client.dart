import 'package:base_ddd/core/networking/result/result.dart';

import '../request/request.dart';
import '../response/response.dart';

abstract class IProjectileClient<R extends Object?> {
  final IProjectileConfig config;

  IProjectileClient(this.config);

  Future<Result<IProjectileError, IProjectileResponse>> sendRequest(
      ProjectileRequest request);

  R transformProjectileRequest(ProjectileRequest request);
}
