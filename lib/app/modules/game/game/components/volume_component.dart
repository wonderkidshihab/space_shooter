import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/painting.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

class VolumeComponent extends CircleComponent
    with HasGameRef<SpaceShooter>, TapCallbacks {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(50, 50);
    position = Vector2(gameRef.size.x - size.x, 0);
    paint = Paint()..color = const Color.fromARGB(255, 255, 255, 255);
    add(SpriteComponent.fromImage(
      gameRef.images.fromCache('volume.png'),
      size: size * 0.8,
    ));
  }

  @override
  void onTapDown(event) {
    super.onTapDown(event);
    gameRef.toggleVolume();
  }
}
