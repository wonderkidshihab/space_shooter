import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

class GamePauseButton extends PositionComponent
    with HasGameRef<SpaceShooter>, TapCallbacks {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(50, 50);
    position = Vector2(0, 0);
    add(SpriteComponent.fromImage(
      gameRef.images.fromCache('pause.png'),
      size: size,
    ));
  }

  @override
  void onTapDown(event) {
    super.onTapDown(event);
    gameRef.pauseEngine();
    gameRef.overlays.add('pause');
  }
}
