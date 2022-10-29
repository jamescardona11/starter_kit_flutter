import 'package:flutter/foundation.dart';
import 'package:projectile/core/request_models/request.dart';
import 'package:projectile/core/result_models/result_models.dart';

import 'interceptors.dart';

/// {@template basic_logger_interceptor}
/// {@endtemplate}
class BasicProjectileLogs extends ProjectileInterceptor {
  BasicProjectileLogs(this.log);

  final String log;

  @override
  Future<FailureResult> onError(FailureResult data) async {
    debugPrint('$log Error =>\n $data');

    return data;
  }

  @override
  Future<ProjectileRequest> onRequest(ProjectileRequest data) async {
    debugPrint('$log Request=>\n $data');
    return data;
  }

  @override
  Future<SuccessResult> onResponse(SuccessResult data) async {
    debugPrint('$log Response=>\n $data');
    return data;
  }
}
