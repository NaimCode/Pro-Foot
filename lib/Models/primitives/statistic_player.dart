// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:api_football/Models/primitives/team_v1.dart';

import 'league_v2.dart';

class StatisticPlayer {
  Team_v1? team_v1;
  League_v2? league_v2;
  int? appearences;
  int? shootTotal;
  int? shootOn;
  int? goal;
  int? assist;
  int? passe;
  int? tacle;
  int? dribleAttempts;
  int? dribleReussi;
  int? yellow;
  int? red;
  StatisticPlayer({
    this.team_v1,
    this.league_v2,
    this.appearences,
    this.shootTotal,
    this.shootOn,
    this.goal,
    this.assist,
    this.passe,
    this.tacle,
    this.dribleAttempts,
    this.dribleReussi,
    this.yellow,
    this.red,
  });

  StatisticPlayer copyWith({
    Team_v1? team_v1,
    League_v2? league_v2,
    int? appearences,
    int? shootTotal,
    int? shootOn,
    int? goal,
    int? assist,
    int? passe,
    int? tacle,
    int? dribleAttempts,
    int? dribleReussi,
    int? yellow,
    int? red,
  }) {
    return StatisticPlayer(
      team_v1: team_v1 ?? this.team_v1,
      league_v2: league_v2 ?? this.league_v2,
      appearences: appearences ?? this.appearences,
      shootTotal: shootTotal ?? this.shootTotal,
      shootOn: shootOn ?? this.shootOn,
      goal: goal ?? this.goal,
      assist: assist ?? this.assist,
      passe: passe ?? this.passe,
      tacle: tacle ?? this.tacle,
      dribleAttempts: dribleAttempts ?? this.dribleAttempts,
      dribleReussi: dribleReussi ?? this.dribleReussi,
      yellow: yellow ?? this.yellow,
      red: red ?? this.red,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'team_v1': team_v1?.toMap(),
      'league_v2': league_v2?.toMap(),
      'appearences': appearences,
      'shootTotal': shootTotal,
      'shootOn': shootOn,
      'goal': goal,
      'assist': assist,
      'passe': passe,
      'tacle': tacle,
      'dribleAttempts': dribleAttempts,
      'dribleReussi': dribleReussi,
      'yellow': yellow,
      'red': red,
    };
  }

  factory StatisticPlayer.fromMap(Map<String, dynamic> map) {
    return StatisticPlayer(
      team_v1: map['team_v1'] != null ? Team_v1.fromMap(map['team_v1']) : null,
      league_v2:
          map['league_v2'] != null ? League_v2.fromMap(map['league_v2']) : null,
      appearences: map['appearences']?.toInt(),
      shootTotal: map['shootTotal']?.toInt(),
      shootOn: map['shootOn']?.toInt(),
      goal: map['goal']?.toInt(),
      assist: map['assist']?.toInt(),
      passe: map['passe']?.toInt(),
      tacle: map['tacle']?.toInt(),
      dribleAttempts: map['dribleAttempts']?.toInt(),
      dribleReussi: map['dribleReussi']?.toInt(),
      yellow: map['yellow']?.toInt(),
      red: map['red']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticPlayer.fromJson(String source) =>
      StatisticPlayer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StatisticPlayer(team_v1: $team_v1, league_v2: $league_v2, appearences: $appearences, shootTotal: $shootTotal, shootOn: $shootOn, goal: $goal, assist: $assist, passe: $passe, tacle: $tacle, dribleAttempts: $dribleAttempts, dribleReussi: $dribleReussi, yellow: $yellow, red: $red)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatisticPlayer &&
        other.team_v1 == team_v1 &&
        other.league_v2 == league_v2 &&
        other.appearences == appearences &&
        other.shootTotal == shootTotal &&
        other.shootOn == shootOn &&
        other.goal == goal &&
        other.assist == assist &&
        other.passe == passe &&
        other.tacle == tacle &&
        other.dribleAttempts == dribleAttempts &&
        other.dribleReussi == dribleReussi &&
        other.yellow == yellow &&
        other.red == red;
  }

  @override
  int get hashCode {
    return team_v1.hashCode ^
        league_v2.hashCode ^
        appearences.hashCode ^
        shootTotal.hashCode ^
        shootOn.hashCode ^
        goal.hashCode ^
        assist.hashCode ^
        passe.hashCode ^
        tacle.hashCode ^
        dribleAttempts.hashCode ^
        dribleReussi.hashCode ^
        yellow.hashCode ^
        red.hashCode;
  }
}
