import 'package:base_ddd/core/networking/response_models/response.dart';

import '../request_models/request_models.dart' show ProjectileRequest;
import '../response_models/errors_response.dart';
import 'interceptors.dart';

abstract class InterceptorContract {
  Future<ProjectileRequest> onRequest(ProjectileRequest data);

  Future<ProjectileResponse> onResponse(ProjectileResponse data);

  Future<ProjectileError> onError(ProjectileError data);
}

mixin RunInterceptor {
  Future<ProjectileRequest> runRequestInterceptors(
    Iterable<InterceptorContract> interceptors,
    ProjectileRequest initialRequestData,
  ) {
    /// run before `request` interceptors
    final queue = FutureQueue<ProjectileRequest>()
      ..addAll(interceptors.map((e) => e.onRequest));

    return queue.run(initialRequestData);
  }

  Future<ProjectileResponse> runResponseInterceptors(
    Iterable<InterceptorContract> interceptors,
    ProjectileResponse initialRequestData,
  ) {
    /// run before `response` interceptors
    final queue = FutureQueue<ProjectileResponse>()
      ..addAll(interceptors.map((e) => e.onResponse));

    return queue.run(initialRequestData);
  }

  Future<ProjectileError> runErrorInterceptors(
    Iterable<InterceptorContract> interceptors,
    ProjectileError initialRequestData,
  ) {
    /// run after `error` interceptors
    final queue = FutureQueue<ProjectileError>()
      ..addAll(interceptors.map((e) => e.onError));

    return queue.run(initialRequestData);
  }
}
