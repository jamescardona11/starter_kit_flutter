import 'package:projectile/projectile.dart';
import 'package:projectile_reqres_api/api_request/reqres_urls.dart';

class ApiRequestWithHttp {
  Future<String?> login(String email, password) async {
    try {
      final response = await Projectile(config: BaseConfig(enableLog: true))
          .request(
            ProjectileRequest(
              target: ReqresUrls.loginUrl,
              method: Method.POST,
              data: {"email": email, "password": password},
            ),
          )
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
