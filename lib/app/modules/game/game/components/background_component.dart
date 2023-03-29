import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

class BackgroundComponent extends SpriteComponent
    with HasGameRef<SpaceShooter> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = gameRef.size;
    Image background = gameRef.images.fromCache('background.png');
    sprite = Sprite(background);
  }
}
