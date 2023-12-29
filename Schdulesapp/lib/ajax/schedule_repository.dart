import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import '../models/flight_data.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  static Future<List<ScheduleModel>> getSchedules() async {
    String jsonString = await rootBundle.loadString('assets/json/test.json');
    List<dynamic> jsonList = json.decode(jsonString);
    List<ScheduleModel> scheduleList =
        jsonList.map((json) => ScheduleModel.fromJson(json)).toList();
    return scheduleList;
  }

  /// get 날짜로 수정하기
  static Future<ScheduleModel> getScheduleOne(int index) async {
    String jsonString = await rootBundle.loadString('assets/json/test.json');
    List<dynamic> jsonList = json.decode(jsonString);
    List<ScheduleModel> scheduleList =
        jsonList.map((json) => ScheduleModel.fromJson(json)).toList();
    return scheduleList[index];
  }

  static Future<int> getSchedulesize() async {
    String jsonString = await rootBundle.loadString('assets/json/test.json');
    List<dynamic> jsonList = json.decode(jsonString);
    int size = jsonList.length;
    return size;
  }


  // 일정 리스트
  static Future<List<FlightData>> generateMyFlights() async {
    int cnt = await getSchedulesize();
    List<ScheduleModel> s_list = await getSchedules();
    return generateFlightsData(cnt, s_list);
  }



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
          duration: "1h 35m",
          time: s_list[index].staB.toString(),
          time2: s_list[index].stdB.toString(),
          activity: s_list[index].activity.toString(),
          id: s_list[index].id),
    );
  }

  // 날짜 선택시 보여지는 일정
  static Future<FlightData> availableFlight(int index) async {
    return await generateAvailableFlights(index);
  }

  static Future<FlightData> generateAvailableFlights(int index) async {
    ScheduleModel s = await getScheduleOne(index);
    return FlightData(
        id:s.id,
        departureShort: s.cntFrom.toString(),
        departure: "김포공항",
        date: s.date.toString(),
        destinationShort: s.cntTo.toString(),
        destination: "Almedy",
        flightNumber: s.pairing.toString(),
        duration: "1h 35m",
        time: s.staB.toString(),
        time2: s.stdB.toString(),
        activity: s.activity.toString()
    );
  }
}
