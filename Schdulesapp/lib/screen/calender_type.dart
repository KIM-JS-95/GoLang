import 'package:flutter/material.dart';
import 'package:schdulesapp/component/ScheduleCard.dart';
import 'package:schdulesapp/repository/schedule_repository.dart';
import 'package:table_calendar/table_calendar.dart';

import '../component/today_banner.dart';
import '../const/colors.dart';
import '../model/schedule_model.dart';

class CalenderType extends StatefulWidget {
  const CalenderType({Key? key}) : super(key: key);

  @override
  State<CalenderType> createState() => _CalenderType();
}

class _CalenderType extends State<CalenderType> {
  final Future<List<ScheduleModel>> sList=SchesuleRepository.getSchedule();
  final Future<int> schedulessize = SchesuleRepository.getSchedulesize();

  DateTime selectedDate = DateTime.utc(
    // ➋ 선택된 날짜를 관리할 변수
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('테스트'), backgroundColor: JEJU_AIR),
      body: SafeArea(
        child: Column(
          children: [
            Table(), /// 달력[테이블에서 특정 날짜를 클릭하면 해당 날의 값을 가져옴]
            /// 일정표 팝업
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TodayBanner(selectedDate: selectedDate, count: schedulessize),
                          Expanded(
                            child: FutureBuilder(
                              future: sList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return makeList(snapshot);
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
              child: Text('Show Table'),
            )

          ],
        ),
      ),
    );
  }


  /// 메인 페이지 리스트 생성 : 획득한 리스트 정보를 출력
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

  Container Table() {
    return Container(  // Set the desired width
      child: TableCalendar(
        locale: 'ko_kr',
        onDaySelected: onDaySelected,
        selectedDayPredicate: (DateTime date) {
          return date.isAtSameMomentAs(selectedDate);
        },
        firstDay: DateTime(1800, 1, 1),
        lastDay: DateTime(3000, 1, 1),
        focusedDay: DateTime.now(),
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        ),
        calendarStyle: CalendarStyle(
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
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
