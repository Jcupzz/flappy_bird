import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/game_state.dart';
import 'package:flappy_bird/main.dart';
import 'package:flappy_bird/options.dart';

import 'package:sensors_plus/sensors_plus.dart';

final double BIRD_W = 52;
final double BIRD_H = 36.7;
final double GRAVITY = 1200;

class Bird extends AnimationComponent {
  Bird()
      : super.sequenced(BIRD_W, BIRD_H, 'bird.png', 3,
            textureWidth: 17, textureHeight: 12);

  double speedY = 0.0;

  @override
  void update(double t) {
    super.update(t);
    this.anchor = Anchor.center;

    switch (gameState) {
      case GameState.pause:
        this.y = size.height * 0.4;
        this.x = size.width / 2;
        break;
      case GameState.play:
        speedY += (GRAVITY + GAME_SPEED) * t;
        this.anchor = Anchor.center;
        this.y += (speedY * t) / 2;
        this.x = size.width / 2;
        break;
      case GameState.gameover:
        break;
    }

    // print(timepassed);
  }

  void onTap() {
    switch (gameState) {
      case GameState.pause:
        this.speedY = -500;
        // Flame.audio.play("bubble_pop.mp3", volume: 0.5);
        break;
      case GameState.play:
        this.speedY = -500;
        Flame.audio.play("bubble_pop.mp3", volume: 0.5);
        break;
      case GameState.gameover:
        break;
    }
  }
}
