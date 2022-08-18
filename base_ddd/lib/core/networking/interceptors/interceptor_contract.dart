import '../request_models/request_models.dart' show ProjectileRequest;

abstract class InterceptorContract {
  Future<ProjectileRequest> onRequest(ProjectileRequest data);

  Future<ProjectileRequest> onResponse(ProjectileRequest data);

  Future<ProjectileRequest> onError(ProjectileRequest data);
}

mixin RunInterceptor {
  Future<void> runRequestInterceptors(
      List<InterceptorContract> interceptors) async {}

  Future<void> runResponseInterceptors(
      List<InterceptorContract> interceptors) async {}

  Future<void> runErrorInterceptors(
      List<InterceptorContract> interceptors) async {}
}
