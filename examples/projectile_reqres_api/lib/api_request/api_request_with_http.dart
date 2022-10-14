import 'package:projectile/projectile.dart';
import 'package:projectile_reqres_api/api_request/reqres_urls.dart';

class ApiRequestWithHttp {
  Future<String?> login(String email, password) async {
    try {
      final response = await Projectile()
          .request(
            ProjectileRequest(
              target: ReqresUrls.loginUrl,
              method: Method.POST,
              data: {"email": email, "password": password},
            ),
          )
          .addCustomInterceptor(ProjectileLogs())
          .fire();

      response.fold(
        (error) {
          print(error);
        },
        (success) {
          print('success');
        },
      );
    } catch (e, s) {
      print(e);
    }
  }
}

class ProjectileLogs extends ProjectileInterceptor {
  @override
  Future<FailureResult> onError(FailureResult data) async {
    print('ERROR: $data');

    return data;
  }

  @override
  Future<ProjectileRequest> onRequest(ProjectileRequest data) async {
    print('REQUEST: $data');
    return data;
  }

  @override
  Future<SuccessResult> onResponse(SuccessResult data) async {
    print('RESPONSE: $data');
    return data;
  }
}
