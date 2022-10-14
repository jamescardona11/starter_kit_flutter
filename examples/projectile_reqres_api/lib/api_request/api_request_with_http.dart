import 'package:projectile/core/projectile.dart';
import 'package:projectile/core/request_models/request_models.dart';
import 'package:projectile_reqres_api/api_request/reqres_urls.dart';

class ApiRequestWithDio {
  Future<String?> login() async {
    try {
      final response = await Projectile()
          .request(
            ProjectileRequest(
              target: ReqresUrls.loginUrl,
            ),
          )
          .fire();

      response.fold((e) {}, (s) {});
    } catch (e, s) {}
  }
}
