import 'package:flutter/material.dart';
import 'calender_type.dart';
import '../const/colors.dart';
import 'list_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //XFile? _pickedFile;
  //CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('테스트'), backgroundColor: JEJU_AIR),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 세로 방향으로 중앙 정렬
            crossAxisAlignment: CrossAxisAlignment.stretch, // 가로 방향으로 중앙 정렬
            children: [
              Padding( /// 달력 일정으로 확인
                  padding: EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalenderType(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFF5000), // 버튼 배경 색상
                      onPrimary: Colors.white, // 텍스트 색상
                      padding: EdgeInsets.all(16.0), // 내부 여백
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // 버튼 테두리 모양
                      ),
                    ),
                    child: Text("Check My Schedules"),
                  )),
              Padding( /// 전체 일정 List
                  padding: EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListType(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFF5000), // 버튼 배경 색상
                      onPrimary: Colors.white, // 텍스트 색상
                      padding: EdgeInsets.all(16.0), // 내부 여백
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // 버튼 테두리 모양
                      ),
                    ),
                    child: Text("전체 일정"),
                  ))
            ],
          ),
        ));
  }
}
