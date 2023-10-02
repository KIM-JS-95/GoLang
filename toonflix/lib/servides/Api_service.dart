import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';
import '../models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    // 모든 작업은 url을 통한 json 작업 이후 이루어지기 때문에 async(동기) 선언
    List<WebtoonModel> webtoonInstances = []; // 리스트 선언
    final url = Uri.parse('$baseUrl/$today'); // String to url

    final response = await http.get(url); // 비동기 url 통신
    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        // 반복문
        final instance =
            WebtoonModel.fromJson(webtoon); // json 배열을 반복문으로 object 요소에 저장
        webtoonInstances.add(instance); // 리스트에 instance 변수 저장
      }

      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    // 모든 작업은 url을 통한 json 작업 이후 이루어지기 때문에 async(동기) 선언
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
