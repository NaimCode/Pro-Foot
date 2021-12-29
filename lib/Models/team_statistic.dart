// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:api_football/Models/primitives/fixture_v1.dart';
import 'package:api_football/Models/primitives/goal.dart';
import 'package:api_football/Models/primitives/league_v2.dart';
import 'package:api_football/Models/primitives/lineup.dart';
import 'package:api_football/Models/primitives/team_v1.dart';
import 'package:flutter/material.dart';

class TeamStatistic {
  String? form;
  League_v2? league_v2;
  Team_v1? team_v1;
  Goal? goal;
  Fixture_v1? fixture_v1;
  List<Lineup>? lineup;
  static Color colorFrom(String s) {
    switch (s) {
      case "W":
        return Colors.blue.withOpacity(0.5);
      case "L":
        return Colors.red.withOpacity(0.5);
      case "D":
        return Colors.yellow.withOpacity(0.5);

      default:
        return Colors.blue.withOpacity(0.5);
    }
  }

  static String stringForm(String s) {
    switch (s) {
      case "W":
        return "V";
      case "L":
        return "D";
      case "D":
        return "N";
      default:
        return "V";
    }
  }

  TeamStatistic({
    this.form,
    this.league_v2,
    this.team_v1,
    this.goal,
    this.fixture_v1,
    this.lineup,
  });

  TeamStatistic copyWith({
    String? form,
    League_v2? league_v2,
    Team_v1? team_v1,
    Goal? goal,
    Fixture_v1? fixture_v1,
    List<Lineup>? lineup,
  }) {
    return TeamStatistic(
      form: form ?? this.form,
      league_v2: league_v2 ?? this.league_v2,
      team_v1: team_v1 ?? this.team_v1,
      goal: goal ?? this.goal,
      fixture_v1: fixture_v1 ?? this.fixture_v1,
      lineup: lineup ?? this.lineup,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'form': form,
      'league_v2': league_v2?.toMap(),
      'team_v1': team_v1?.toMap(),
      'goal': goal?.toMap(),
      'fixture_v1': fixture_v1?.toMap(),
      'lineup': lineup?.map((x) => x.toMap()).toList(),
    };
  }

  factory TeamStatistic.fromMap(Map<String, dynamic> map) {
    return TeamStatistic(
      form: map['form'],
      league_v2:
          map['league_v2'] != null ? League_v2.fromMap(map['league_v2']) : null,
      team_v1: map['team_v1'] != null ? Team_v1.fromMap(map['team_v1']) : null,
      goal: map['goal'] != null ? Goal.fromMap(map['goal']) : null,
      fixture_v1: map['fixture_v1'] != null
          ? Fixture_v1.fromMap(map['fixture_v1'])
          : null,
      lineup: map['lineup'] != null
          ? List<Lineup>.from(map['lineup']?.map((x) => Lineup.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamStatistic.fromJson(String source) =>
      TeamStatistic.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TeamStatistic(form: $form, league_v2: $league_v2, team_v1: $team_v1, goal: $goal, fixture_v1: $fixture_v1, lineups: $lineup)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamStatistic &&
        other.form == form &&
        other.league_v2 == league_v2 &&
        other.team_v1 == team_v1 &&
        other.goal == goal &&
        other.fixture_v1 == fixture_v1 &&
        listEquals(other.lineup, lineup);
  }

  @override
  int get hashCode {
    return form.hashCode ^
        league_v2.hashCode ^
        team_v1.hashCode ^
        goal.hashCode ^
        fixture_v1.hashCode ^
        lineup.hashCode;
  }
}
