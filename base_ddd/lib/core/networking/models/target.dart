import 'content_type.dart';
import 'method.dart';
import '../projectile_builder.dart';

class Target {
  final String _target;

  Target(String target) : _target = target;

  ProjectileBuilder way(Method method,
      [ContentType contentType = ContentType.json]) {
    return ProjectileBuilder.fromTarget(method, _target, contentType);
  }
}
