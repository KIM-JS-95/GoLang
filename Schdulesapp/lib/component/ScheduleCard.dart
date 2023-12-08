import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../model/schedule_model.dart';
import 'time.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleModel schedule;

  const ScheduleCard({
    required this.schedule,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  Time(
                    stdL: schedule?.stdL ?? "null",
                    stdB: schedule?.stdB ?? "null",
                    cntFrom: schedule?.cntFrom?? "null",
                    cntTo: schedule?.cntTo?? "null",
                  ),
                  //SizedBox(width: 16.0),
                  //_Content(content: schedule?.cntFrom ?? 'null')
            ],
          ),
        ),
      ),
    );
  }
}

