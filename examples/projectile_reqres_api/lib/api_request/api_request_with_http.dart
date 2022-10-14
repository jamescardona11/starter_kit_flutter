import 'package:projectile/projectile.dart';
import 'package:projectile_reqres_api/api_request/reqres_urls.dart';
import 'package:projectile_reqres_api/model/user_model.dart';

class ApiRequestWithHttp {
  Future<bool> login(String email, password) async {
    final response = await Projectile(config: BaseConfig(enableLog: true))
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

  Future<UserModel?> getUserInfo(int id) async {
    final response = await Projectile(config: BaseConfig(enableLog: true))
        .request(RequestBuilder.target(ReqresUrls.singleUserUrl)
            .mode(Method.GET)
            .urlParams({'id': id}).build())
        .fire();

    return response.fold((error) {
      return null;
    }, (success) {
      print('user');
      print(success);
      final user = UserModel.fromJson(success.data);
      print(user);

      return user;
    });
  }
}
