import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
// 날짜 초기화
  await initializeDateFormatting();

  runApp(
      MaterialApp(
    home: HomeScreen(),
  ));
}


