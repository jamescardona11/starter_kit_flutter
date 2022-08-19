import '../request_models/request_models.dart' show ProjectileRequest;
import '../response_models/errors_response.dart';
import '../response_models/response.dart';
import 'interceptors.dart';

abstract class ProjectileInterceptor {
  Future<ProjectileRequest> onRequest(ProjectileRequest data);

  Future<ResponseSuccess> onResponse(ResponseSuccess data);

  Future<ResponseError> onError(ResponseError data);
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

  Future<ResponseSuccess> runResponseInterceptors(
    Iterable<ProjectileInterceptor> interceptors,
    ResponseSuccess initialRequestData,
  ) {
    /// run on `response` interceptors
    final queue = FutureQueue<ResponseSuccess>()
      ..addAll(interceptors.map((e) => e.onResponse));

    return queue.run(initialRequestData);
  }

  Future<ResponseError> runErrorInterceptors(
    Iterable<ProjectileInterceptor> interceptors,
    ResponseError initialRequestData,
  ) {
    /// run on `error` interceptors
    final queue = FutureQueue<ResponseError>()
      ..addAll(interceptors.map((e) => e.onError));

    return queue.run(initialRequestData);
  }
}
