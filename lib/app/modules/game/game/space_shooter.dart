import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:space_shooter/app/modules/game/game/components/background_component.dart';
import 'package:space_shooter/app/modules/game/game/components/bullet_component.dart';
import 'package:space_shooter/app/modules/game/game/components/enemy_component.dart';
import 'package:space_shooter/app/modules/game/game/components/explotion_component.dart';
import 'package:space_shooter/app/modules/game/game/components/life_component.dart';
import 'package:space_shooter/app/modules/game/game/components/player_component.dart';
import 'package:space_shooter/app/modules/game/game/components/score_component.dart';

class SpaceShooter extends FlameGame
    with
        HasDraggableComponents,
        HasTappableComponents,
        HasCollisionDetection,
        HasKeyboardHandlerComponents {
  int playerLifeCount = 5;
  int score = 0;

  PlayerComponent player = PlayerComponent();
  BackgroundComponent background = BackgroundComponent();

  // This part of the code is used to spawn enemies at random intervals
  final Random _random = Random();
  double _spawnTimer = 0.0;
  double _spawnInterval = 2.0;

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
    add(ScoreComponent());
    add(PlayerLifeComponent());
    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (playerLifeCount <= 0) {
      reset();
    }
    _spawner(dt);
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

  /// Increases the enemy spawning rate by decreasing the spawn interval by 10%.
  void increaseEnemySpawningRate() {
    _spawnInterval = (_spawnInterval * 0.9).clamp(0.4, 2.0);
  }

  reset() {
    pauseEngine();
    overlays.add('game');
    player.reset();
    playerLifeCount = 5;
    score = 0;
    _spawnTimer = 0.0;
    _spawnInterval = 2.0;
    removeWhere((component) => component is EnemyComponent);
    removeWhere((component) => component is ExplotionComponent);
    removeWhere((component) => component is BulletComponent);
  }
}
