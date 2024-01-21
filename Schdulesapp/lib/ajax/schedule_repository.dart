import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/UserProvider.dart';
import '../models/flight_data.dart';
import '../models/schedule_model.dart';
import '../utils/r.dart';
import 'package:http/http.dart' as http;

class ScheduleRepository {

  /// 일정 리스트
  static Future<List<FlightData>> getAllSchedules(String auth) async {
    final response = await http.post(
      Uri.parse('$R.back_addr/show-schedule'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': auth
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<ScheduleModel> s_list = jsonList.map((json) => ScheduleModel.fromJson(json)).toList();
      return generateFlightsData(jsonList.length, s_list);
    }

    return generateFlightsData(0, []);
  }


  /// get> 날짜로 수정하기
  static Future<List<FlightData>> getScheduleByDate(DateTime selectedDay, String Authorization) async {
    final response = await http.post(
      Uri.parse('$R.back_addr/getschedule'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Authorization
      },
      body: jsonEncode({'dateTime': selectedDay.toIso8601String()}),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<ScheduleModel> s_list = jsonList.map((json) => ScheduleModel.fromJson(json)).toList();
      return generateFlightsData(jsonList.length, s_list);
    }

    return generateFlightsData(0, []);
  }

  /// 일정 객체 오버라이드 ScheduleModel.dart -> FlightData.dart
  static List<FlightData> generateFlightsData(int cnt, List<ScheduleModel> s_list) {
    return List.generate(
      cnt,
          (index) => FlightData(
        departureShort: s_list[index].cntFrom.toString(),
        departure: "김포공항",
        date: s_list[index].date.toString(),
        destinationShort: s_list[index].cntTo.toString(),
        destination: "Almedy",
        flightNumber: s_list[index].pairing.toString(),
        stal: s_list[index].staL.toString(),
        stab: s_list[index].staB.toString(),
        stdl: s_list[index].stdL.toString(),
        stdb: s_list[index].stdB.toString(),
        activity: s_list[index].activity.toString(),
        id: s_list[index].id,
        ci: s_list[index].ci.toString(),
        co: s_list[index].co.toString(),
      ),
    );
  }

}
