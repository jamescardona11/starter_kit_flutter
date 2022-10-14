import 'package:projectile/core/projectile.dart';
import 'package:projectile/core/request_models/request_models.dart';
import 'package:projectile_reqres_api/api_request/reqres_urls.dart';

class ApiRequestWithHttp {
  Future<String?> login(String email, password) async {
    try {
      final response = await Projectile()
          .request(
            ProjectileRequest(
              target: ReqresUrls.loginUrl,
            ),
          )
          .fire();

      response.fold(
        (error) {
          print('Error');
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
