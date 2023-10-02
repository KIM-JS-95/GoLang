import 'package:flutter/material.dart';

import 'package:toonflix/widgets/webtoon_widget.dart';
import '../models/webtoon_model.dart';
import '../servides/Api_service.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold( /// Flutter document: Implements the basic material design visual layout structure.
      backgroundColor: Color.fromRGBO(30, 200, 0, 1),

      // 상단 타이틀
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),

      body: FutureBuilder( /// async 내장되어 있음: Future 획득을 대기
        future: webtoons,
        builder: (context, snapshot) { /// snapshot: FutureBuilder가 받은 future의 상태
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(height: 0),
                Expanded(child: makeList(snapshot)) /// 획득한 데이터의 크기를 화면에 모두 담을 수 있도록 요소를 expanded
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

    );
  }

  /// 메인 페이지 리스트 생성 : 획득한 리스트 정보를 출력
  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      /// scrollDirection: Axis.horizontal,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
