import 'package:flutter/material.dart';
import '../models/TextFieldData.dart';
import 'r.dart';

class HardCodedData {
  static late final List<TextFieldData> _loginPageFieldsData;
  static late final List<TextFieldData> _routePageFieldsData;


  static List<TextFieldData> get loginPageFieldsData => _loginPageFieldsData;
  static List<TextFieldData> get routePageFieldsData => _routePageFieldsData;

  static generateHardCodedData() {
    _generateLoginPageFieldsData();
    _generateRoutePageFieldsData();
  }


  static Future<void> _generateLoginPageFieldsData() async {
    _loginPageFieldsData = [
      TextFieldData(
        Icon(
          Icons.email,
          color: R.secondaryColor,
        ),
        "이메일",
        TextEditingController(),
        "hello@world.io",
      ),
      TextFieldData(
        Icon(
          Icons.password,
          color: R.secondaryColor,
        ),
        "비밀번호",
        TextEditingController(),
        "random123",
      ),
    ];
  }

  static _generateRoutePageFieldsData() => _routePageFieldsData = [
        TextFieldData(
          Icon(
            Icons.flight_takeoff,
            color: R.secondaryColor,
          ),
          "FROM",
          TextEditingController(),
          "Dabaca",
        ),
        TextFieldData(
          Icon(
            Icons.flight_land,
            color: R.secondaryColor,
          ),
          "TO",
          TextEditingController(),
          "Almedy",
        ),
        TextFieldData(
          Icon(
            Icons.calendar_month,
            color: R.secondaryColor,
          ),
          "DATE",
          TextEditingController(),
          "May 19",
        ),
        TextFieldData(
          Icon(
            Icons.people,
            color: R.secondaryColor,
          ),
          "TRAVELER",
          TextEditingController(),
          "2",
        ),
        TextFieldData(
          Icon(
            Icons.flight_class,
            color: R.secondaryColor,
          ),
          "CLASS",
          TextEditingController(),
          "Economy",
        ),
      ];
}
