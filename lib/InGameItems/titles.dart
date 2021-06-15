import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/game_state.dart';
import 'package:flappy_bird/main.dart';

class Titles extends Component {
  Sprite _getReady =
      Sprite.fromImage(spriteSheet, x: 295, y: 59, width: 92, height: 25);
  Sprite _gameOver =
      Sprite.fromImage(spriteSheet, x: 395, y: 59, width: 96, height: 25);

  double xSize = 0;
  double ySize = 0;

  @override
  void render(Canvas c) {
    switch (gameState) {
      case GameState.pause:
        xSize = size.width * 0.6;
        ySize = xSize / 92 * 25;
        _getReady.renderPosition(
            c, Position(size.width * 0.2, size.height * 0.2),
            size: Position(xSize, ySize));
        break;
      case GameState.play:
        break;
      case GameState.gameover:
        xSize = size.width * 0.6;
        ySize = xSize / 96 * 25;
        _gameOver.renderPosition(
            c, Position(size.width * 0.2, size.height * 0.2),
            size: Position(xSize, ySize));
        break;
    }
  }

  @override
  void update(double t) {}
}
