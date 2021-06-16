import 'package:flappy_bird/Home.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 4000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (builder) => Home()));
    });

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                "assets/images/flappy_bird_yellow.png",
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
              )),
              Shimmer.fromColors(
                baseColor: Colors.black,
                highlightColor: Colors.white,
                period: Duration(milliseconds: 1000),
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Flappy Bird",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 60,
                        fontFamily: "LobsterTwo",
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
