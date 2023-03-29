import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:space_shooter/app/modules/game/game/components/bullet_component.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

class PlayerComponent extends SpriteComponent
    with
        HasGameRef<SpaceShooter>,
        DragCallbacks,
        TapCallbacks,
        CollisionCallbacks {
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
  void onTapDown(event) {
    // create a bullet and add it to the game when the player is tapped
    // the bullet will be added at the center of the player
    gameRef.add(
      BulletComponent(
        initalPosition: position,
        direction: Vector2(0, -1),
      ),
    );
  }

  void reset() {
    position = gameRef.size / 2;
  }
}
