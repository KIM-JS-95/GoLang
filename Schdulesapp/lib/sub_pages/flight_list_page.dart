/*
 title: FlightListPage.class
 contents: 한달간의 모든 일정을 리스트로 노출
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schdulesapp/ajax/schedule_repository.dart';
import 'package:schdulesapp/sub_pages/today_flight.dart';

import '../models/User.dart';
import '../models/UserProvider.dart';
import '../models/flight_data.dart';
import '../utils/r.dart';
import '../widgets/flights_list_item_widget.dart';

class FlightListPage extends StatefulWidget {


  const FlightListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FlightListPage> createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  late List<FlightData> flightDatas;

  @override
  void initState() {
    super.initState();
    flightDatas = []; // Initialize flightData as an empty list
    _loadFlightData();
  }

  Future<void> _loadFlightData() async {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    try {
      final data = await ScheduleRepository.getAllSchedules(userProvider.user.auth);
      setState(() {
        flightDatas = data;
      });
    } catch (error) {
      // Handle error
      print('Error loading flight data: $error');
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: flightDatas.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: R.tertiaryColor.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: R.tertiaryColor),
                    ),
                  ),
                  onPressed: () {
                    TodayFlight(flightData: flightDatas[index]);
                    }, /// 리스트 클릭시 뷰 페이지로 이동
                  child: FlightsListItemWidget(
                      flightData: flightDatas[index]),
                ),
              ),
            ),
          ),
        ],
      );
}