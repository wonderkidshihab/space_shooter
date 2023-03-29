import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:space_shooter/app/modules/game/game/components/background_component.dart';
import 'package:space_shooter/app/modules/game/game/components/enemy_component.dart';
import 'package:space_shooter/app/modules/game/game/components/player_component.dart';

class SpaceShooter extends FlameGame
    with HasDraggableComponents, HasTappableComponents, HasCollisionDetection {
  PlayerComponent player = PlayerComponent();
  BackgroundComponent background = BackgroundComponent();

  final Random _random = Random();
  double _spawnTimer = 0.0;
  final double _spawnInterval = 2.0;

  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();
    await images.loadAll(<String>[
      'background.png',
      'player.png',
      'bullet.png',
      'enemy.png',
      'explotion.png',
    ]);

    add(background);
    add(player);
    add(ScreenHitbox());
    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _spawner(dt);
  }

  reset() {
    player.reset();
  }

  void _spawner(dt) {
    _spawnTimer += dt;
    if (_spawnTimer >= _spawnInterval) {
      // Creates a random x-coordinate for a new enemy, but makes sure it is
      // within the bounds of the screen, the enemy is 100x100 pixels, so we
      // subtract 100 from the width of the screen
      final x =
          (_random.nextDouble() * size.x).clamp(0, size.x - 100.0) as double;
      const y = -100.0;
      final enemy = EnemyComponent(initalPosition: Vector2(x, y));
      add(enemy);
      _spawnTimer = 0.0;
    }
  }
}
