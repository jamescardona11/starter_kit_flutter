import 'package:projectile/core/core.dart';
import 'package:projectile/projectile.dart';
import 'package:projectile_reqres_api/api_request/reqres_urls.dart';

import '../model/user_model.dart';

class ApiRequestWithDio {
  Future<Iterable<UserModel>> getAllUsers({int page = 1}) async {
    final result = await Projectile(client: DioClient())
        .request(
          RequestBuilder.target(ReqresUrls.listUsersUrl)
              .mode(Method.GET)
              .build(),
        )
        .fire();

    return result.fold(
        (error) => [],
        (success) => (success.dataJson['data'] as List<dynamic>)
            .map((e) => UserModel.fromJson(e)));
  }
}
