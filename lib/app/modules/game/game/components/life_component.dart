import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

class PlayerLifeComponent extends PositionComponent
    with HasGameRef<SpaceShooter> {
  late SpriteComponent life;
  late TextBoxComponent lifeText;

  @override
  FutureOr<void> onLoad() async {
    life = SpriteComponent.fromImage(
      gameRef.images.fromCache('player.png'),
      size: Vector2(30, 30),
    );

    position = Vector2(gameRef.size.x - size.x - 100, 10);
    life.position = Vector2(0, 10);
    lifeText = TextBoxComponent();
    lifeText.position = Vector2(30, 0);
    lifeText.text = 'x3';
    lifeText.textRenderer = TextPaint(
      style: const TextStyle(
        color: Color(0xffffffff),
        fontSize: 30,
      ),
    );
    add(life);
    add(lifeText);
    return super.onLoad();
  }

  @override
  void update(double t) {
    super.update(t);
    lifeText.text = 'x${gameRef.playerLifeCount}';
  }
}
