import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/colors.dart';

class Time extends StatefulWidget {
  final String? stdL;
  final String? stdB;
  final String? cntFrom;
  final String? cntTo;

  const Time({
    required this.stdL,
    required this.stdB,
    this.cntFrom,
    this.cntTo,
    Key? key,
  }) : super(key: key);

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  @override
  Widget build(BuildContext context) {
    const primaryTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontSize: 16.0,
    );

    const secondaryTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 10.0,
    );

    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flight_takeoff,
                color: Colors.white,
                size: 20.0,
              ),
              Text(
                'Boarding Pass',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              Icon(
                Icons.flight_land,
                color: Colors.white,
                size: 20.0,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Departure: ${widget.stdL}',
                      style: primaryTextStyle,
                    ),
                    Text(
                      '${widget.cntFrom}',
                      style: secondaryTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Arrival: ${widget.stdB}',
                      style: primaryTextStyle,
                    ),
                    Text(
                      '${widget.cntTo}',
                      style: secondaryTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
