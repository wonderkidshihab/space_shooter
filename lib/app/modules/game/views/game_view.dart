import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:space_shooter/app/modules/game/game/space_shooter.dart';

import '../controllers/game_controller.dart';

class GameView extends GetView<GameController> {
  GameView({Key? key}) : super(key: key);
  final myGame = SpaceShooter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GameWidget(
          game: myGame,
          overlayBuilderMap: {
            'game': (context, game) {
              return Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Game Over',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GFButton(
                        onPressed: () {
                          myGame.overlays.remove('game');
                          myGame.resumeEngine();
                        },
                        text: 'PLAY',
                        type: GFButtonType.solid,
                        shape: GFButtonShape.pills,
                        color: Colors.white,
                        size: GFSize.LARGE,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              );
            },
            'pause': (context, game) {
              return Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Game Paused',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GFButton(
                        onPressed: () {
                          myGame.overlays.remove('pause');
                          myGame.resumeEngine();
                        },
                        text: 'RESUME',
                        type: GFButtonType.solid,
                        shape: GFButtonShape.pills,
                        color: Colors.white,
                        size: GFSize.LARGE,
                        textColor: Colors.black,
                      ),
                      const SizedBox(height: 20),
                      GFButton(
                        onPressed: () {
                          myGame.overlays.remove('pause');
                          myGame.resumeEngine();
                          myGame.reset();
                        },
                        text: 'RESTART',
                        type: GFButtonType.solid,
                        shape: GFButtonShape.pills,
                        color: Colors.white,
                        size: GFSize.LARGE,
                        textColor: Colors.black,
                      ),
                      const SizedBox(height: 20),
                      GFButton(
                        onPressed: () {
                          myGame.overlays.remove('pause');
                          myGame.resumeEngine();
                          myGame.reset();
                          Get.back();
                        },
                        text: 'EXIT',
                        type: GFButtonType.solid,
                        shape: GFButtonShape.pills,
                        color: Colors.white,
                        size: GFSize.LARGE,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              );
            },
          },
        ),
      ),
    );
  }
}
