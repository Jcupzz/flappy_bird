import 'package:flame/game/widget_builder.dart';
import 'package:flappy_bird/Game.dart';
import 'package:flappy_bird/game_state.dart';
import 'package:flappy_bird/main.dart';
import 'package:flutter/material.dart';

enum FavoriteMethod { autoJump, manualJump }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FavoriteMethod _method = FavoriteMethod.manualJump;
  Widget pauseMenuBuilder(BuildContext buildContext, MyGame game) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        color: const Color(0xFFFF0000),
        child: const Center(
          child: Text('Paused'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MyGame().widget,
          Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.05,
              child: GestureDetector(
                onTap: () {
                  gameState = GameState.pause;
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: Text(
                            "Settings",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                          children: [

                            ElevatedButton(onPressed: (){


                              
                            }, child: Text("Auto-Jump")),





                            // RadioListTile(
                            //     title: Text(
                            //       "Auto-Jump",
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 18),
                            //     ),
                            //     value: FavoriteMethod.autoJump,
                            //     groupValue: _method,
                            //     onChanged: (value) {
                            //       _method = value;
                            //       setState(() {
                            //         isAutoJump = true;
                            //       });

                            //       Navigator.pop(context);
                            //     }),
                            // RadioListTile(
                            //     title: Text(
                            //       "Manual-Jump",
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 18),
                            //     ),
                            //     value: FavoriteMethod.manualJump,
                            //     groupValue: _method,
                            //     onChanged: (value) {
                            //       _method = value;
                            //       setState(() {
                            //         isAutoJump = false;
                            //       });

                            //       Navigator.pop(context);
                            //     }),
                          ],
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        );
                      });
                },
                child: Image.asset(
                  "assets/images/settings.png",
                  width: 50,
                  height: 50,
                ),
              )),
        ],
      ),
    );
  }
}
