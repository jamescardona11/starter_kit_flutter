import 'package:base_ddd/core/networking/client/i_projectile_client.dart';

class ConfigShot {
  final IProjectileClient? http;
  final IProjectileClient? dio;

  ConfigShot({
    this.http,
    this.dio,
  });
}

enum ShotType {
  dio,
  http,
}
