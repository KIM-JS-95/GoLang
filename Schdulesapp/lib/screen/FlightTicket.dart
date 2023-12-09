import 'package:flutter/material.dart';

import '../const/colors.dart';

class FlightTicket extends StatelessWidget {
  final int? id;

  const FlightTicket({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var json = {
      "id": 1,
      "date": "01Nov23",
      "pairing": null,
      "dc": null,
      "ci": null,
      "co": null,
      "activity": "VAC",
      "cntFrom": "GMP",
      "stdL": "0000",
      "stdB": "0000",
      "cntTo": "GMP",
      "staL": "2359",
      "staB": "2359",
      "achotel": null,
      "blk": null,
    };
    return Scaffold(
        body: SafeArea(
            top: true,
            bottom: false,
            child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blue, // 티켓 배경색
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    const Text('상세 일정',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    const SizedBox(height: 20.0),
                    Container(
                      color: JEJU_AIR, // Set the background color
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const SizedBox(height: 8.0),
                                buildDepartureInfo(Icons.flight_takeoff,
                                    'Departure', '${json["stdL"]}'),
                                const SizedBox(height: 4.0),
                                buildDepartureInfo(Icons.location_on, 'City',
                                    '${json["cntFrom"]}')
                              ],
                            ),
                          ),
                          const SizedBox(width: 16.0),

                          /// 출발 정보와 도착 정보 간의 간격 조절
                          Expanded(
                            /// 오른쪽
                            child: Column(
                              children: [
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.flight_land,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      'Arrival: ${json["staL"]}',

                                      /// 도착시간
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      'City: ${json["cntTo"]}',

                                      /// 도착지
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            )
        )
    );
  }
}

Widget buildDepartureInfo(IconData? iconName, String label, String value) {
  return Row(
    children: [
      Icon(
        iconName,
        color: Colors.white,
        size: 20.0,
      ),
      const SizedBox(width: 4.0),
      Text(
        '$label: $value',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    ],
  );
}
