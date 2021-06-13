import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Image.asset(
        "assets/images/flappy_bird_yellow.png",
      ),
    );
  }
}
