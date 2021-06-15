import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_bird/game_state.dart';
import 'package:flappy_bird/main.dart';
import 'package:flappy_bird/options.dart';

class Floor extends Component {
  Sprite _floorSprite = Sprite('floor.png');
  double xSize;
  double ySize;
  double xPos = 0;

  @override
  void render(Canvas c) {
    xSize = size.width * 2;
    ySize = xSize / 168 * 56;

    _floorSprite.renderPosition(c, Position(xPos, size.height - ySize * 0.25),
        size: Position(xSize, ySize));
  }

  @override
  void update(double t) {
    if (gameState == GameState.play) {
      xPos -= t * (30 + GAME_SPEED);
      if (xPos.abs() >= size.width) xPos = 0;
    }
  }

  Rect toRect() {
    return Rect.fromLTWH(0, size.height - ySize * 0.25, xSize, ySize);
  }
}
