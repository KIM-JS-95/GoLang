
import 'package:flutter/material.dart';
import 'package:schdulesapp/ajax/schedule_repository.dart';

import '../models/flight_data.dart';
import '../widgets/fading_item_list/fading_item_list.dart';
import '../widgets/fading_item_list/fading_item_list_controller.dart';
import '../widgets/flights_list_item_widget.dart';

class MyFlightsListPage extends StatelessWidget {
  final FadingItemListController fadingItemListController;
  const MyFlightsListPage({
    super.key,
    required this.fadingItemListController,
  });

  @override
  Widget build(BuildContext context) {
    print("메인페이지");
    return FutureBuilder<List<FlightData>>(
      future: ScheduleRepository.generateMyFlights(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터 로딩 중인 경우에 보여줄 UI
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // 에러 발생 시에 보여줄 UI
          return Text('Error: ${snapshot.error}');
        } else {
          // 데이터 로딩이 완료된 경우에 보여줄 UI
          List<FlightData> list = snapshot.data!;
          return FadingItemList(
            fadingItemListController: fadingItemListController,
            listItems: List.generate(
              5, (index) => FlightsListItemWidget(flightData: list[index]),
            ),
          );
        }
      },
    );
  }

}