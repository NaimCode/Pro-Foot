import 'package:dio/dio.dart';

class API {
  String serverUrl = "http://localhost:8080";

  Future<Response> getLigues(String query) async {
    print(query);
    return Dio().get(serverUrl, queryParameters: {"search": query});
  }
}

enum EndPoint { ligue, equipe }
