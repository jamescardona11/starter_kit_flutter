import 'package:projectile/projectile.dart';
import 'package:projectile_reqres_api/api_request/reqres_urls.dart';

class ApiRequestWithHttp {
  Future<bool> login(String email, password) async {
    final response = await Projectile(config: BaseConfig(enableLog: false))
        .request(
          ProjectileRequest(
            target: ReqresUrls.loginUrl,
            method: Method.POST,
            data: {
              "email": email,
              "password": password,
            },
          ),
        )
        .fire();

    return response.fold(
      (_) => false,
      (s) => true,
    );
  }
}
