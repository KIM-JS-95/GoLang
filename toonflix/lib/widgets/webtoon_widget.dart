import 'package:flutter/material.dart';
import '../screens/detail_screen.dart';

/// 홈 화면의 웹툰 이미지 정보를 출력
class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });


  /// BuildContext:
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// Navigator: StatelessWidget에서 상속받은 function 이며 route MaterialPageRoute를 추가하여 애니메이션 효과를 추가
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen( ///DetailScreen.dart 로 전달
              title: title,
              thumb: thumb,
              id: id,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Hero( /// 화면전환시 애니메이션을 제공
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // 이미지 둥글둥글하게
                boxShadow: [
                  // 이미지 후면 그림자 위치
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
              ),
              // 403 이미지 에러로 인한 헤더 추가
              child: Image.network( /// thumb url 호출로 이미지 획득  403에러 발생 방지를 위해 헤더 추가
                headers: const {
                  /// 별도의 'User-Agent' 값을 추가하지 않으면 default= `Dart/<version> (dart:io)`
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
                },
                thumb,
              ),
            ),
          ),

          const SizedBox(height: 20),
          // Text(
          //   title,
          //   style: const TextStyle(fontSize: 22),
          // ),
        ],
      ),
    );
  }
}
