import 'package:api_football/Models/fixture.dart';
import 'package:dio/dio.dart';

class API {
  String serverUrl = "http://localhost:8080";

  getLigues(String query) async {
    return Dio()
        .get(serverUrl + "/fr/ligues", queryParameters: {"search": query});
  }

  Future<Response> getLiguesQuery(String query) async {
    return Dio().get(serverUrl + "/fr/ligues" + query);
  }

  getTeams(String query) async {
    return Dio()
        .get(serverUrl + "/fr/equipes", queryParameters: {"search": query});
  }

 Future<Response> getTeamStatistic(String query) async {
    return Dio().get(serverUrl + "/fr/equipes/statistiques" + query);
  }

  getCoachs(String query) async {
    return Dio()
        .get(serverUrl + "/fr/coachs", queryParameters: {"search": query});
  }

  Future<Response> getFixture(int last) async {
    return Dio()
        .get(serverUrl + "/fr/fixtures", queryParameters: {"last": last});
  }

  Future<Response> getFixtureTeam(int last, int id) async {
    return Dio().get(serverUrl + "/fr/fixtures",
        queryParameters: {"last": last, "team": id});
  }

  Future<Response> getFixtureParam(String query) async {
    return Dio().get(serverUrl + "/fr/fixtures" + query);
  }

  Future<Response> getMatchDetail(Fixture fixture) async {
    return Dio().get(serverUrl + "/fr/fixtures/statistique",
        queryParameters: {"venue": fixture.venueID, "id": fixture.id});
  }
}

enum EndPoint { ligue, equipe }
