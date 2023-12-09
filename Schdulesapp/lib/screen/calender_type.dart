import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../component/today_banner.dart';
import '../const/colors.dart';
import '../model/schedule_model.dart';
import 'package:schdulesapp/component/ScheduleCard.dart';
import 'package:schdulesapp/ajax/schedule_repository.dart';

class CalenderType extends StatefulWidget {
  const CalenderType({Key? key}) : super(key: key);

  @override
  State<CalenderType> createState() => _CalenderType();
}

class _CalenderType extends State<CalenderType> {
  final Future<int> schedulessize = ScheduleRepository.getSchedulesize();
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('날짜로 일정 찾기'), backgroundColor: JEJU_AIR),
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              locale: 'ko_kr',
              onDaySelected: (selectedDate, focusedDate) {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TodayBanner(
                              selectedDate: selectedDate, count: schedulessize),
                          Expanded(
                            child: FutureBuilder(
                              future: ScheduleRepository.getSchedule(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return makeList(snapshot);

                                  /// 리스트 노출
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              selectedDayPredicate: (DateTime date) {
                return date.isAtSameMomentAs(selectedDate);
              },
              firstDay: DateTime(1800, 1, 1),
              lastDay: DateTime(3000, 1, 1),
              focusedDay: DateTime.now(),
              headerStyle: customHeaderStyle,
              calendarStyle: customCalendarStyle,
            ),
          ],
        ),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<ScheduleModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      itemBuilder: (context, index) {
        var schedule = snapshot.data![index];
        return ScheduleCard(schedule: schedule);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
  final HeaderStyle customHeaderStyle = const HeaderStyle(
    titleCentered: true,
    formatButtonVisible: false,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
    ),
  );
  final CalendarStyle customCalendarStyle = CalendarStyle(
    isTodayHighlighted: false,
    defaultDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      color: LIGHT_GREY_COLOR,
    ),
    weekendDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      color: LIGHT_GREY_COLOR,
    ),
    selectedDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(
        color: PRIMARY_COLOR,
        width: 1.0,
      ),
    ),
    defaultTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      color: DARK_GREY_COLOR,
    ),
    weekendTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      color: DARK_GREY_COLOR,
    ),
    selectedTextStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
    ),
  );
}
