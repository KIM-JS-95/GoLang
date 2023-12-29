import 'package:flutter/material.dart';
import 'package:schdulesapp/ajax/schedule_repository.dart';

import '../models/flight_data.dart';
import '../sub_pages/route_selection_page.dart';
import '../widgets/custom_option_selector.dart';
import '../widgets/days_calendar_widget.dart';
import 'r.dart';

class HardCodedData {
  static late final List<TextFieldData> _loginPageFieldsData;
  static late final List<TextFieldData> _routePageFieldsData;
  static late final List<CustomOptionSelectorData> _checkoutPagePaymentOptions;
  static late final List<CustomOptionSelectorData> _routePageRouteOptions;

  static List<TextFieldData> get loginPageFieldsData => _loginPageFieldsData;
  static List<TextFieldData> get routePageFieldsData => _routePageFieldsData;

  static List<CustomOptionSelectorData> get routePageRouteOptions =>
      _routePageRouteOptions;
  static List<CustomOptionSelectorData> get checkoutPagePaymentOptions =>
      _checkoutPagePaymentOptions;

  static generateHardCodedData() {
    _generateRoutePageRouteOptions();
    _generateLoginPageFieldsData();
    _generateRoutePageFieldsData();
  }

  static _generateRoutePageRouteOptions() => _routePageRouteOptions = [
    CustomOptionSelectorData(
      text: "One way",
      id: "0",
      leftBorder: false,
      topBorder: false,
    ),
    CustomOptionSelectorData(
      text: "Roundtrip",
      id: "1",
      topBorder: false,
    ),
    CustomOptionSelectorData(
      text: "Multiple",
      id: "2",
      topBorder: false,
      rightBorder: false,
    )
  ];

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
