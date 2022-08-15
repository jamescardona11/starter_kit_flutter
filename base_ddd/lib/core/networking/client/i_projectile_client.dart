import '../models/models.dart';

abstract class IProjectileClient<R extends Object?> {
  final IProjectileConfig config;

  IProjectileClient(this.config);

  Future<void> sendRequest(ProjectileRequest request);

  R transformProjectileRequest(ProjectileRequest request);

  // String transformToUrl(String requestUrl);

  // Uri transformToUri(String requestUrl);

  // addDynamicAddressParams(String requestUrl);
}
