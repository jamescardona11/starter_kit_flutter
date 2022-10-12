import 'package:projectile/core/projectile.dart';
import 'package:projectile/core/request_models/request_models.dart';

class ApiRequestWithDio {
  final String _url = 'https://api.chucknorris.io/jokes/random';

  Future<String?> login() async {
    try {
      await Projectile()
          .request(
            ProjectileRequest(
              target: _url,
              method: Method.GET,
            ),
          )
          .fire();
    } catch (e, s) {}
  }
}
