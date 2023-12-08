import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schdulesapp/model/schedule_model.dart';

void main() {
  testWidgets('Fetch schedule from JSON', (WidgetTester tester) async {
    String jsonString = await rootBundle.loadString('assets/json/test.json');
    List<dynamic> jsonList = json.decode(jsonString);
    List<ScheduleModel> scheduleList = jsonList
        .map((json) => ScheduleModel.fromJson(json))
        .toList();
    for (ScheduleModel schedule in scheduleList) {
      print('Name: ${schedule.date}');
    }

  });

}
