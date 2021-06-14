import 'dart:ui';

import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/components/component.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MyGame extends BaseGame with TapDetector {
  Bird _bird;
  Floor _floor;
  PipeSet _pipeSet;
  Titles _titles;
  Score _score;
  // Settings _settings;
  double x, y, z;
  double numy, numz;
  bool isRunOnce = false;
  bool isAbove = false;

  Future<void> onLoad() async {
    print('game loaded');
  }

  MyGame() {
    _bird = Bird();
    _floor = Floor();
    _titles = Titles();
    _pipeSet = PipeSet();
    _score = Score();
    // _settings = Settings();
    this
      ..add(
          SpriteComponent.fromSprite(size.width, size.height, Sprite("bg.png")))
      ..add(_pipeSet)
      ..add(_bird)
      ..add(_floor)
      ..add(_titles)
      ..add(_score);
    // ..add(_settings);
    if (isAutoJump) {
      accelerometerEvents.listen((event) {
        print("x: " + event.x.toString());
        print("y: " + event.y.toString());
        print("z: " + event.z.toString());

        x = event.x;
        y = event.y;
        z = event.z;

        numy = double.parse(y.toStringAsFixed(2));
        numz = double.parse(z.toStringAsFixed(2));
        if (numy < 8.50 && numz > 4.00) {
          onTilt();
        } else {}
      });
    } else {
      accelerometerEvents.listen((event) {
        print("x: " + event.x.toString());
        print("y: " + event.y.toString());
        print("z: " + event.z.toString());

        x = event.x;
        y = event.y;
        z = event.z;

        numy = double.parse(y.toStringAsFixed(2));
        numz = double.parse(z.toStringAsFixed(2));
        if (numy < 8.50 && numz > 4.00) {
          if (!isRunOnce) {
            onTilt();
            isRunOnce = true;
          }
        } else {
          isRunOnce = false;
        }
      });
    }
  }

  void initPositions() {
    MyGame();
  }

  @override
  void update(double t) {
    super.update(t);

    if (gameState == GameState.play) {
      if (checkIf2CompoCollision(_bird.toRect(), _floor.toRect())) {
        setGameover();
      }
      if (_bird.y < -1) {
        setGameover();
      }
      if (checkIf2CompoCollision(_bird.toRect(), _pipeSet.getPipeDownRect())) {
        setGameover();
      }

      if (checkIf2CompoCollision(_bird.toRect(), _pipeSet.getPipeUpRect())) {
        setGameover();
      }

      checkIfBirdPassedPipe();
    }
  }

  void setGameover() {
    // Flame.audio.play("hit.wav");
    Flame.audio.play("die.mp3");
    gameState = GameState.gameover;
    _score.resetScore();
  }

  @override
  void onTap() {
    //_bird.onTap();
    switch (gameState) {
      case GameState.pause:
        // gameState = GameState.play;
        break;
      case GameState.play:
        break;
      case GameState.gameover:
        _score.resetScore();
        gameState = GameState.pause;
        // initPositions();
        break;
    }
  }

  bool checkIf2CompoCollision(Rect item1, Rect item2) {
    var intersectedRect = item1.intersect(item2);
    return intersectedRect.width > 2 && intersectedRect.height > 2;
  }

  void checkIfBirdPassedPipe() {
    if (_pipeSet.hadscored) return;

    if (_pipeSet.getPipeDownRect().right < _bird.toRect().left) {
      Flame.audio.play("point.mp3");
      _score.addScore();

      _pipeSet.scoreUpdated();
    }
  }

  void onTilt() {
    _bird.onTap();
    switch (gameState) {
      case GameState.pause:
        gameState = GameState.play;
        break;
      case GameState.play:
        break;
      case GameState.gameover:
        // gameState = GameState.pause;

        // _score.resetScore();
        break;
    }
  }
}
