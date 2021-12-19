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
}

enum EndPoint { ligue, equipe }
