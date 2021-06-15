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
    Future.delayed(Duration.zero, () => showAlert(context));
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
                            RadioListTile(
                                title: Text(
                                  "Auto-Jump",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                value: FavoriteMethod.autoJump,
                                groupValue: _method,
                                onChanged: (value) {
                                  _method = value;
                                  setState(() {
                                    isAutoJump = true;
                                  });

                                  Navigator.pop(context);
                                }),
                            RadioListTile(
                                title: Text(
                                  "Manual-Jump",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                value: FavoriteMethod.manualJump,
                                groupValue: _method,
                                onChanged: (value) {
                                  _method = value;
                                  setState(() {
                                    isAutoJump = false;
                                  });

                                  Navigator.pop(context);
                                }),
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

  showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: EdgeInsets.all(20),
            backgroundColor: Colors.black,
            children: [
              Row(
                children: [
                  Text(
                    "Hola!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    "assets/images/flappy_bird_yellow.png",
                    width: 60,
                    height: 60,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          "Tilt phone up to jump and down to descend",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Image.asset("assets/images/tilt_up_down.png"))
                ],
              ),
              Divider(
                color: Colors.white,
                height: 30,
              ),
              Text(
                "Special feature",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Auto Jump and Manual Jump.In Auto jump mode the bird jumps continuosly on tilt up.In Manual Jump mode the bird jumps only once when tilted up. By default it is manual jump. Try it in the settings menu",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/images/start_button_1.png"))
            ],
          );
        });
  }
}
