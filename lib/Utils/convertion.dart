import 'dart:convert';

import 'package:api_football/Models/coach.dart';
import 'package:api_football/Models/country.dart';
import 'package:api_football/Models/league.dart';
import 'package:api_football/Models/primitives/league_v1.dart';
import 'package:api_football/Models/primitives/season.dart';
import 'package:api_football/Models/primitives/team_v1.dart';
import 'package:api_football/Models/primitives/team_v2.dart';
import 'package:api_football/Models/primitives/venue.dart';
import 'package:api_football/Models/team.dart';
import 'package:flutter/services.dart';

class Convertion {
  static Future<String> stringToJson(String source) {
    return rootBundle.loadString(source);
  }

  static List<Country> fromLocalJsonToListCountry(String jsonString) {
    Iterable iterable = json.decode(jsonString);
    return iterable
        .map((e) => Country(name: e['name'], flag: e['flag'], code: e['code']))
        .toList();
  }

  static List<League> fromLocalJsonToListLeague(String jsonString) {
    Iterable iterable = json.decode(jsonString);
    return iterable
        .map((e) => League(
            league_v1: League_v1.fromMap(e['league_v1']),
            country: Country.fromMap(e['country']),
            seasons: e['seasons']
                .map((s) => Season.fromMap(s))
                .toList()
                .cast<Season>()))
        .toList()
        .cast<League>();
  }

  static List<Team> fromLocalJsonToListTeam(String jsonString) {
    Iterable iterable = json.decode(jsonString);
    return iterable
        .map((e) => Team(
              team_v2: Team_v2.fromMap(e['team_v2']),
              venue: Venue.fromMap(e['venue']),
            ))
        .toList()
        .cast<Team>();
  }

  static List<Coach> fromLocalJsonToListCoach(String jsonString) {
    Iterable iterable = json.decode(jsonString);
    return iterable.map((e) => Coach.fromMap(e)).toList().cast<Coach>();
  }
}
