// import 'dart:ui';

// import 'package:flame/components/component.dart';
// import 'package:flame/components/mixins/tapable.dart';
// import 'package:flame/position.dart';
// import 'package:flame/sprite.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Settings extends PositionComponent with Tapable {
//   Sprite settings_img = Sprite("settings.png");
//   double settings_x = 60;
//   double settings_y = 60;

//   @override
//   bool onTapDown(_) {
//     print("TAPPED");
//     return true;
//   }

//   @override
//   void render(Canvas c) {
//     settings_img.renderPosition(c, Position(50, 100),
//         size: Position(settings_x, settings_y));
//   }
// }
