import 'package:flutter/material.dart';
import 'package:schdulesapp/ajax/schedule_repository.dart';

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
  late List<FlightData> flightData;

  @override
  void initState() {
    super.initState();
    print("전체페이지");
    flightData = []; // Initialize flightData as an empty list
    _loadFlightData();
  }

  Future<void> _loadFlightData() async {
    try {
      final data = await ScheduleRepository.generateMyFlights();
      setState(() {
        flightData = data;
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
          itemCount: flightData.length,
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
              onPressed: () {},
              child: FlightsListItemWidget(
                flightData: flightData[index],
              ),
            ),
          ),
        ),
      ),
    ],
  );

}
