import 'package:flutter/material.dart';
import 'package:schdulesapp/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
// 날짜 초기화
  await initializeDateFormatting();

  //runApp(const MyApp());
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}