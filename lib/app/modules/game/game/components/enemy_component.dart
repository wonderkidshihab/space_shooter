import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:space_shooter/app/modules/game/game/components/bullet_component.dart';
import 'package:space_shooter/app/modules/game/game/components/explotion_component.dart';
import 'package:space_shooter/app/modules/game/game/components/player_component.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

class EnemyComponent extends SpriteComponent
    with HasGameRef<SpaceShooter>, CollisionCallbacks {
  late Vector2 initalPosition;
  EnemyComponent({required this.initalPosition});
  // This ColorEffect will be added to the component when the enemy has 2 lives
  ColorEffect mediumColorEffect = ColorEffect(
      Colors.yellow,
      const Offset(0.0, 0.7),
      EffectController(duration: 1.0, repeatCount: 200, reverseDuration: 1.0));
  // This ColorEffect will be added to the component when the enemy has 3 life
  ColorEffect hardColorEffect = ColorEffect(Colors.red, const Offset(0.0, 0.7),
      EffectController(duration: 1.0, repeatCount: 200, reverseDuration: 1.0));
  int lifeCount = Random().nextInt(3) + 1;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2.all(100);
    Image enemy = gameRef.images.fromCache('enemy.png');
    var tmp = Sprite(enemy, srcSize: size);
    sprite = tmp;

    add(RectangleHitbox(
      size: size,
      anchor: Anchor.center,
    ));
    if (lifeCount == 2) {
      add(mediumColorEffect);
    } else if (lifeCount == 3) {
      add(hardColorEffect);
    }
    position = initalPosition;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BulletComponent) {
      lifeCount--;
      if (lifeCount == 0) {
        gameRef.score++;
        if (gameRef.score % 5 == 0) {
          gameRef.increaseEnemySpawningRate();
        }
        gameRef.remove(this);
      } else if (lifeCount == 2) {
        remove(hardColorEffect);
        add(mediumColorEffect);
      } else if (lifeCount == 1) {
        remove(mediumColorEffect);
      }
      gameRef.explosionSound.start(
        volume: gameRef.soundOn ? 0.3 : 0.0,
      );
      gameRef.add(ExplotionComponent(other.position));
      gameRef.remove(other);
    } else if (other is PlayerComponent) {
      gameRef.playerLifeCount--;
      gameRef.remove(this);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 50 * dt;
    if (position.y > gameRef.size.y) {
      gameRef.playerLifeCount--;
      gameRef.remove(this);
    }
  }
}
