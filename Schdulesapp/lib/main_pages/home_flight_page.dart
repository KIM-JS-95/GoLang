
import 'package:flutter/material.dart';
import 'package:schdulesapp/ajax/schedule_repository.dart';

import '../models/flight_data.dart';
import '../sub_pages/today_flight.dart';
import '../widgets/fading_item_list/fading_item_list_controller.dart';

class HomeFlightPage extends StatefulWidget {
  const HomeFlightPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _HomeFlightPage();

}

class _HomeFlightPage extends State<HomeFlightPage>{
  late final FadingItemListController fadingItemListController;
  DateTime selectedDate = DateTime.utc(
    // ➋ 선택된 날짜를 관리할 변수
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    print("메인페이지");
    return FutureBuilder<FlightData>(
      future: ScheduleRepository.getTodaySchdule(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터 로딩 중인 경우에 보여줄 UI
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // 에러 발생 시에 보여줄 UI
          return Text('Error: ${snapshot.error}');
        } else {
          /*
          * 출력부분을 전체로 today_flight.dart 페이지 빌려주기
          * */
          return TodayFlight(flightData: snapshot.data!);
        }
      },
    );
  }
}