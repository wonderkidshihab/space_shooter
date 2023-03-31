import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

class VolumeComponent extends PositionComponent
    with HasGameRef<SpaceShooter>, TapCallbacks {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(100, 100);
    position = Vector2(gameRef.size.x - size.x, 0);
    add(SpriteComponent.fromImage(
      gameRef.images.fromCache('volume.png'),
      size: size,
    ));
  }

  @override
  void onTapDown(event) {
    super.onTapDown(event);
    gameRef.toggleVolume();
  }
}
