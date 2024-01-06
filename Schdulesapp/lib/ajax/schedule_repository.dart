import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/flight_data.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  static Future<List> getJsonSchedule() async {
    String jsonString = await rootBundle.loadString('assets/json/test.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList;
  }

  /// get> 날짜로 수정하기
  static Future<ScheduleModel> getScheduleOne(int index) async {
    //String jsonString = await rootBundle.loadString('assets/json/test.json');
    //List<dynamic> jsonList = json.decode(jsonString);

    List<dynamic> jsonList = await getJsonSchedule();
    List<ScheduleModel> scheduleList =
        jsonList.map((json) => ScheduleModel.fromJson(json)).toList();
    return scheduleList[index];
  }

  /// 메인페이지 금일 일정 가져오기
  static Future<FlightData> getTodaySchdule() async {
    // String jsonString = await rootBundle.loadString('assets/json/test.json');
    // List<dynamic> jsonList = json.decode(jsonString);

    List<dynamic> jsonList = await getJsonSchedule();
    ScheduleModel s =
        jsonList.map((json) => ScheduleModel.fromJson(json)).toList()[1];
    return FlightData(
        departureShort: s.cntFrom.toString(),
        departure: "김포공항",
        date: s.date.toString(),
        destinationShort: s.cntTo.toString(),
        destination: "Almedy",
        flightNumber: s.pairing.toString(),
        stdl: s.stdL.toString(),
        stdb: s.stdB.toString(),
        stal: s.staL.toString(),
        stab: s.staB.toString(),
        activity: s.activity.toString(),
        id: s.id,
        ci: s.ci.toString(),
        co: s.co.toString());
  }

  /// 일정 리스트
  static Future<List<FlightData>> generateMyFlights() async {
    // String jsonString = await rootBundle.loadString('assets/json/test.json');
    // List<dynamic> jsonList = json.decode(jsonString);

    List<dynamic> jsonList = await getJsonSchedule();
    int cnt = jsonList.length;
    List<ScheduleModel> s_list =
        jsonList.map((json) => ScheduleModel.fromJson(json)).toList();
    return generateFlightsData(cnt, s_list);
  }

  /// 일정 객체 오버라이드 ScheduleModel.dart -> FlightData.dart
  static List<FlightData> generateFlightsData(
      int cnt, List<ScheduleModel> s_list) {
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

  /// 날짜 선택시 보여지는 일정
  static Future<FlightData> availableFlight(int index) async {
    ScheduleModel s = await getScheduleOne(index);
    return FlightData(
        id: s.id,
        departureShort: s.cntFrom.toString(),
        departure: "김포공항",
        date: s.date.toString(),
        destinationShort: s.cntTo.toString(),
        destination: "Almedy",
        flightNumber: s.pairing.toString(),
        stal: s.staL.toString(),
        stab: s.staB.toString(),
        stdl: s.stdL.toString(),
        stdb: s.stdB.toString(),
        activity: s.activity.toString(),
        ci: s.ci.toString(),
        co: s.co.toString());
  }

/*
  static Future<List<ScheduleModel>> getSchedules() async {
    String jsonString = await rootBundle.loadString('assets/json/test.json');
    List<dynamic> jsonList = json.decode(jsonString);
    List<ScheduleModel> scheduleList = jsonList.map((json) => ScheduleModel.fromJson(json)).toList();
    return scheduleList;
  }

  static Future<int> getSchedulesize() async {
    String jsonString = await rootBundle.loadString('assets/json/test.json');
    List<dynamic> jsonList = json.decode(jsonString);
    int size = jsonList.length;
    return size;
  }
*/
}
