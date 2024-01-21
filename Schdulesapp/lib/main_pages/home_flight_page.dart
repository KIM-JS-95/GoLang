
import 'package:flutter/material.dart';
import 'package:schdulesapp/ajax/schedule_repository.dart';

import '../models/User.dart';
import '../models/flight_data.dart';
import '../sub_pages/today_flight.dart';

class HomeFlightPage extends StatefulWidget {
  final User user;
  const HomeFlightPage({
    super.key,
    required this.user,
  });

  @override
  State<StatefulWidget> createState() => _HomeFlightPage();

}

class _HomeFlightPage extends State<HomeFlightPage>{
  DateTime selectedDate = DateTime.utc(
    // ➋ 선택된 날짜를 관리할 변수
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  /// 좌우 슬라이드로 당일 일전 표시하기
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlightData>>(
      future: ScheduleRepository.getScheduleByDate(selectedDate, widget.user.auth),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터 로딩 중인 경우에 보여줄 UI
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // 에러 발생 시에 보여줄 UI
          return Text('Error: ${snapshot.error}');
        } else {
          return snapshot.hasData
              ? Column(
            children: snapshot.data!.map((e) => TodayFlight(flightData: e!)).toList(),
          )
              : const Text('No flight data available');
        }
      },
    );
  }
}