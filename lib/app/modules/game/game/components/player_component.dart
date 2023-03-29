import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/src/services/raw_keyboard.dart';
import 'package:space_shooter/app/modules/game/game/components/bullet_component.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

class PlayerComponent extends SpriteComponent
    with
        HasGameRef<SpaceShooter>,
        DragCallbacks,
        CollisionCallbacks,
        KeyboardHandler {
  double bulletInterval = 0.1;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(50, 50);
    Image player = gameRef.images.fromCache('player.png');
    sprite = Sprite(player);
    add(
      RectangleHitbox(
        size: size,
        anchor: Anchor.center,
      ),
    );
    position = gameRef.size / 2;
  }

  @override
  void onDragUpdate(event) {
    // update the position of the player based on the drag event
    // bound to the screen
    position = Vector2(
      event.canvasPosition.x.clamp(0, gameRef.size.x - size.x),
      event.canvasPosition.y.clamp(0, gameRef.size.y - size.y),
    );
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event.isKeyPressed(LogicalKeyboardKey.space)) {
      gameRef.add(
          BulletComponent(initalPosition: position, direction: Vector2(0, -1)));
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    // if (Platform.isAndroid || Platform.isIOS) {
    bulletInterval -= dt;
    if (bulletInterval <= 0) {
      bulletInterval = 0.1;
      gameRef.add(
          BulletComponent(initalPosition: position, direction: Vector2(0, -1)));
    }
    // }
    super.update(dt);
  }

  void reset() {
    position = gameRef.size / 2;
  }
}
