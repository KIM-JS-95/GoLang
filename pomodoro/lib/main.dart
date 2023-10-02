import 'package:flutter/material.dart';
import 'package:pomodoro/screeens/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            backgroundColor: const Color(0xFFE7626C),
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Color(0xFF232B55),
            ),
          ),
          cardColor: const Color(0xFFF4EDDB),
          cardTheme: CardTheme(
            color: const Color(0xFFFFB2B2),
          )),
      home: const HomeScreen(),
    );
  }
}
