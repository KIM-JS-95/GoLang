import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/flight_data.dart';
import '../models/schedule_model.dart';
import '../utils/r.dart';
import 'package:http/http.dart' as http;

class ScheduleRepository {

  static Future<List> getJsonSchedule() async {
    String jsonString = await rootBundle.loadString('assets/json/test.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList;
  }


  /// 메인페이지 금일 일정 가져오기
  static Future<FlightData> getTodaySchdule() async {
    final uri = Uri.parse('$R.back_addr/getschedule');
    /// 안드로이드 로컬 호스트는 127.0.0.1 이 아님
    final request = http.MultipartRequest('POST', uri);
    final response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print('Image uploaded successfully. Server response: $responseBody');
    } else {
      // Upload failed
      print('Failed to upload image');
    }

    List<dynamic> jsonList = await getJsonSchedule();
    ScheduleModel s = jsonList.map((json) => ScheduleModel.fromJson(json)).toList()[1];
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


  /// get> 날짜로 수정하기
  static Future<ScheduleModel> getScheduleOne(DateTime selectedDay) async {
    //String jsonString = await rootBundle.loadString('assets/json/test.json');
    //List<dynamic> jsonList = json.decode(jsonString);

    List<dynamic> jsonList = await getJsonSchedule();
    List<ScheduleModel> scheduleList = jsonList.map((json) => ScheduleModel.fromJson(json)).toList();

    return scheduleList[index];
  }

  /// 날짜 선택시 보여지는 일정
  static Future<FlightData> availableFlight(DateTime selectedDay) async {
    ScheduleModel s = await getScheduleOne(selectedDay);
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

}
