import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

class ExplotionComponent extends SpriteAnimationComponent
    with HasGameRef<SpaceShooter> {
  late Vector2 initialPosition;
  ExplotionComponent(this.initialPosition);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(100, 100);
    position = initialPosition - size / 2;
    Image explotion = gameRef.images.fromCache('explotion.png');
    animation = SpriteAnimation.fromFrameData(
      explotion,
      SpriteAnimationData.sequenced(
        amount: 16,
        amountPerRow: 4,
        textureSize: Vector2(64, 64),
        stepTime: 0.75,
      ),
    );
    animation!.loop = false;
    animation!.stepTime = 0.1;
    animation!.onComplete = () {
      gameRef.remove(this);
    };
  }
}
