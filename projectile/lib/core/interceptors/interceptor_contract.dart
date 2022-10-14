import 'package:projectile/core/result_models/result_models.dart';

import '../request_models/request_models.dart' show ProjectileRequest;
import 'interceptors.dart';

abstract class ProjectileInterceptor {
  Future<ProjectileRequest> onRequest(ProjectileRequest data);

  Future<SuccessResult> onResponse(SuccessResult data);

  Future<FailureResult> onError(FailureResult data);
}

mixin RunInterceptor {
  Future<ProjectileRequest> runRequestInterceptors(
    Iterable<ProjectileInterceptor> interceptors,
    ProjectileRequest initialRequestData,
  ) {
    /// run before `request` interceptors
    final queue = FutureQueue<ProjectileRequest>()
      ..addAll(interceptors.map((e) => e.onRequest));

    return queue.run(initialRequestData);
  }

  Future<SuccessResult> runResponseInterceptors(
    Iterable<ProjectileInterceptor> interceptors,
    SuccessResult initialRequestData,
  ) {
    /// run on `response` interceptors
    final queue = FutureQueue<SuccessResult>()
      ..addAll(interceptors.map((e) => e.onResponse));

    return queue.run(initialRequestData);
  }

  Future<FailureResult> runErrorInterceptors(
    Iterable<ProjectileInterceptor> interceptors,
    FailureResult initialRequestData,
  ) {
    /// run on `error` interceptors
    final queue = FutureQueue<FailureResult>()
      ..addAll(interceptors.map((e) => e.onError));

    return queue.run(initialRequestData);
  }
}
