import 'models/models.dart';

class Projectile {
  DeliveryRequest request(ProjectileRequest request) {
    return DeliveryRequest();
  }

  Target target(String target) {
    return Target(target);
  }

  // late ProjectileRequest _request;

}

class DeliveryRequest {}

void c() {
  Projectile()
      .target('projectileproject/src/master/projectile/src')
      .way(Method.GET)
      .headers({}).fire();

  Projectile().request(ProjectileRequest(
    url: 'projectileproject/src/master/projectile/src',
    method: Method.GET,
  ));
}
