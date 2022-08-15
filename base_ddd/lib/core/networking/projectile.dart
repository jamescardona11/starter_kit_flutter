import 'package:base_ddd/core/networking/projectile_shot.dart';
import 'package:base_ddd/core/networking/request_builder.dart';

import 'models/models.dart';

class Projectile {
  final BaseConfig? _config;
  final ConfigShot? _configShot;
  ProjectileRequest? _request;

  Projectile([this._config, this._configShot]);

  Projectile request(ProjectileRequest request) {
    _request = request;
    return this;
  }

  void fire(ShotType shot) {
    _request = null;
  }
}

class DeliveryRequest {}

void c() {
  final projectile = Projectile();

  projectile
      .request(
        RequestBuilder.target('_target')
            .mode(Method.GET)
            .defaultHeaders()
            .query({}).urlParams({}).build(),
      )
      .fire(ShotType.http);
}
