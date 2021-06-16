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
  bool showvalue = true;
  bool startGame = false;

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
          startGame
              ? MyGame().widget
              : Container(
                  color: Colors.green,
                ),
          Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.05,
              child: GestureDetector(
                onTap: () {
                  gameState = GameState.gameover;
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return SimpleDialog(
                            title: Text(
                              "Settings",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                            children: [
                              RadioListTile(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  subtitle: Text(
                                      "When Auto-Jump feature is turned on the bird jumps continuously  on tilted up"),
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
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  subtitle: Text(
                                      "When Manual-Jump is turned on the bird jumps when tilted up and descends when tilted down. You have to tilt phone up and down to get the motion going. Manual-Jump is enabled by default."),
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
                                child: CheckboxListTile(
                                  value: showvalue,
                                  title: Text("Background music"),
                                  onChanged: (value) {
                                    setState(() {
                                      showvalue = value;
                                    });
                                    if (showvalue) {
                                      Flame.bgm.resume();
                                    } else {
                                      Flame.bgm.stop();
                                    }
                                  },
                                ),
                              ),
                            ],
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          );
                        });
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
                    "Hee-yah!",
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
              Text(
                "Please hold you phone straight before starting the game",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    startGame = true;
                  });
                  Flame.bgm.play("game.mp3");
                  Navigator.pop(context);
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
