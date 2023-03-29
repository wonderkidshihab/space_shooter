import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

class BulletComponent extends SpriteComponent with HasGameRef<SpaceShooter> {
  late Vector2 initalPosition;
  late Vector2 direction;

  BulletComponent({required this.initalPosition, required this.direction});
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(30, 10);
    Image bullet = gameRef.images.fromCache('bullet.png');
    sprite = Sprite(bullet);
    add(
      RectangleHitbox(
        size: size,
        anchor: Anchor.center,
      ),
    );
    position = initalPosition;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= 500 * dt;
    if (position.y < (0 - size.y)) {
      gameRef.remove(this);
    }
  }
}
