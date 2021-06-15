import 'package:flame/bgm.dart';
import 'package:flame/flame.dart';
import 'package:flame/flame_audio.dart';
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

class _HomeState extends State<Home> with WidgetsBindingObserver {
  FavoriteMethod _method = FavoriteMethod.manualJump;
  bool showvalue = false;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => showAlert(context));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        Flame.bgm.resume();
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        Flame.bgm.stop();
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        Flame.bgm.stop();

        break;
      case AppLifecycleState.detached:
        print("app in detached");
        Flame.bgm.stop();

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () => showAlert(context));
    return Scaffold(
      body: Stack(
        children: [
          MyGame().widget,
          Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.05,
              child: GestureDetector(
                onTap: () {
                  gameState = GameState.gameover;
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
                            Container(
                              width: double.infinity,
                              height: 80,
                              child: Checkbox(
                                tristate: true,
                                value: showvalue,
                                onChanged: (bool value) {
                                  setState(() {
                                    showvalue = value;
                                  });
                                },
                              ),
                            ),
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
        barrierDismissible: false,
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
                "Auto Jump and Manual Jump.Try it in the settings menu",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Flame.bgm.play("game.mp3");
                },
                child: Container(
                    child: Image.asset(
                  "assets/images/start_button_1.png",
                )),
              )
            ],
          );
        });
  }
}
