import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:schdulesapp/model/schedule_model.dart';

class SchesuleRepository {
  static Future<List<ScheduleModel>> getSchedule() async {
    /*
    final resp = await Dio().get(
      YOUTUBE_API_BASE_URL, // 요청을 보낼 URL
      queryParameters: {
        // 요청에 포함할 쿼리 변수들
        'channelId': CF_CHANNEL_ID,
        'maxResults': 50,
        'key': API_KEY,
        'part': 'snippet',
        'order': 'date',
      },
    );
     */
    String jsonString = await rootBundle.loadString('assets/json/test.json');
    List<dynamic> jsonList = json.decode(jsonString);
    List<ScheduleModel> scheduleList = jsonList
        .map((json) => ScheduleModel.fromJson(json))
        .toList();
    return scheduleList;
  }
  static Future<int> getSchedulesize() async {

    String jsonString = await rootBundle.loadString('assets/json/test.json');
    List<dynamic> jsonList = json.decode(jsonString);
    int size = jsonList.length;
    return size;
  }
}