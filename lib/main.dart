import 'package:flame/flame.dart';
import 'package:flappy_bird/Home.dart';
import 'package:flutter/material.dart';

Size size;
var spriteSheet;
bool isAutoJump = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  size = await Flame.util.initialDimensions();
  spriteSheet = await Flame.images.load("sprites.png");

  runApp(MaterialApp(home: Home()));
}
