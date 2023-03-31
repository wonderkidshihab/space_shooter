import 'package:flame/components.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

class ScoreComponent extends TextBoxComponent with HasGameRef<SpaceShooter> {
  ScoreComponent() {
    anchor = Anchor.topLeft;
    position = Vector2(70, 10);
  }

  @override
  void update(double dt) {
    super.update(dt);
    text = 'Score: ${gameRef.score}';
  }
}
