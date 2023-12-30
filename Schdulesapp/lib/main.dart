import 'package:flutter/material.dart';
import 'package:schdulesapp/utils/hard_coded_data.dart';

import 'main_pages/login_page.dart';

void main() async {
  HardCodedData.generateHardCodedData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flight Booking UI Concept',
    home: LoginPage(),
  );
}