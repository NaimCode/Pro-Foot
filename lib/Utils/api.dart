import 'package:dio/dio.dart';

class API {
  String serverUrl = "http://localhost:8080";

  getLigues(String query) async {
    return Dio()
        .get(serverUrl + "/fr/ligues", queryParameters: {"search": query});
  }

  getTeams(String query) async {
    return Dio()
        .get(serverUrl + "/fr/equipes", queryParameters: {"search": query});
  }

  Future<Response> getFixture(int last) async {
    return Dio()
        .get(serverUrl + "/fr/fixtures", queryParameters: {"last": last});
  }
}

enum EndPoint { ligue, equipe }
