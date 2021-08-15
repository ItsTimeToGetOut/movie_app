import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SplashScreen(
          photoSize: 150,
          seconds: 1,
          backgroundColor: Colors.black,
          image: Image.asset('assets/splash_movie.png'),
          loaderColor: Colors.deepPurpleAccent,
          // photoSize: 200,
          navigateAfterSeconds: MyHomePage(),
        ),
      ),
    );
  }
}
