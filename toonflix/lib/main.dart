import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toonflix/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {

  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  AnimatedSplashScreen(
        duration: 3000,
          splash: Image.asset('assets/splash_image.png'),
        nextScreen: HomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}