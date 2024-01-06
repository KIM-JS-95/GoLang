/*
* title: AvailableFlightsPage.class
* contents: 달력 선택시 해당 날짜의 일정 노출
*
* */
import 'package:flutter/material.dart';
import 'package:schdulesapp/ajax/schedule_repository.dart';

import '../models/flight_data.dart';
import '../utils/hard_coded_data.dart';
import '../utils/r.dart';
import '../widgets/days_calendar_widget.dart';
import '../widgets/fading_item_list/fading_item_list.dart';
import '../widgets/fading_item_list/fading_item_list_controller.dart';
import '../widgets/flights_list_item_widget.dart';

class AvailableFlightsPage extends StatefulWidget {
  const AvailableFlightsPage({
    super.key,
  });

  @override
  State<AvailableFlightsPage> createState() => _AvailableFlightsPageState();
}

class _AvailableFlightsPageState extends State<AvailableFlightsPage> {
  late final FadingItemListController _fadingItemListController;
  late ValueNotifier<int> _selectedFlight;
  DateTime selectedDate = DateTime.utc(
    // ➋ 선택된 날짜를 관리할 변수
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();
    print("달력페이지");
    _fadingItemListController = FadingItemListController();
    _selectedFlight = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _selectedFlight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      DaysCalendarWidget(onDayPressed: (DateTime selectedDay) { /// 달력 위젯
        setState(() {this.selectedDate = selectedDay;});
        _fadingItemListController.showItems();
      }),
      const SizedBox(
        height: 10.0,
      ),
      Expanded(
        child: FadingItemList(
          fadingItemListController: _fadingItemListController,
          listItems: List.generate(
            5,
                (index) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder<Widget>(
                future: buildFlightCard(index,selectedDate),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return snapshot.data ?? SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    ],
  );


  Future<Widget> buildFlightCard(int itemIndex, DateTime selectedDay) async {
    FlightData flightData = await ScheduleRepository.availableFlight(itemIndex);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: R.tertiaryColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: R.tertiaryColor),
        ),
      ),
      onPressed: () {
        _selectedFlight.value = flightData.id;
      },
      child: FlightsListItemWidget(
        flightData: flightData,
      ),
    );
  }

}
