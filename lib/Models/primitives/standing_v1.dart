// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:api_football/Models/primitives/team_v1.dart';

class Standing_v1 {
  int? rank;
  Team_v1? team_v1;
  int? points;
  int? goalsDiff;
  String? group;
  String? form;
  String? description;
  int? wins;
  int? loses;
  int? draws;
  int? goalFor;
  int? goalAgainst;
  Standing_v1({
    this.rank,
    this.team_v1,
    this.points,
    this.goalsDiff,
    this.group,
    this.form,
    this.description,
    this.wins,
    this.loses,
    this.draws,
    this.goalFor,
    this.goalAgainst,
  });

  Standing_v1 copyWith({
    int? rank,
    Team_v1? team_v1,
    int? points,
    int? goalsDiff,
    String? group,
    String? form,
    String? description,
    int? wins,
    int? loses,
    int? draws,
    int? goalFor,
    int? goalAgainst,
  }) {
    return Standing_v1(
      rank: rank ?? this.rank,
      team_v1: team_v1 ?? this.team_v1,
      points: points ?? this.points,
      goalsDiff: goalsDiff ?? this.goalsDiff,
      group: group ?? this.group,
      form: form ?? this.form,
      description: description ?? this.description,
      wins: wins ?? this.wins,
      loses: loses ?? this.loses,
      draws: draws ?? this.draws,
      goalFor: goalFor ?? this.goalFor,
      goalAgainst: goalAgainst ?? this.goalAgainst,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rank': rank,
      'team_v1': team_v1?.toMap(),
      'points': points,
      'goalsDiff': goalsDiff,
      'group': group,
      'form': form,
      'description': description,
      'wins': wins,
      'loses': loses,
      'draws': draws,
      'goalFor': goalFor,
      'goalAgainst': goalAgainst,
    };
  }

  factory Standing_v1.fromMap(Map<String, dynamic> map) {
    return Standing_v1(
      rank: map['rank']?.toInt(),
      team_v1: map['team_v1'] != null ? Team_v1.fromMap(map['team_v1']) : null,
      points: map['points']?.toInt(),
      goalsDiff: map['goalsDiff']?.toInt(),
      group: map['group'],
      form: map['form'],
      description: map['description'],
      wins: map['wins']?.toInt(),
      loses: map['loses']?.toInt(),
      draws: map['draws']?.toInt(),
      goalFor: map['goalFor']?.toInt(),
      goalAgainst: map['goalAgainst']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Standing_v1.fromJson(String source) =>
      Standing_v1.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Standing_v1(rank: $rank, team_v1: $team_v1, points: $points, goalsDiff: $goalsDiff, group: $group, form: $form, description: $description, wins: $wins, loses: $loses, draws: $draws, goalFor: $goalFor, goalAgainst: $goalAgainst)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Standing_v1 &&
        other.rank == rank &&
        other.team_v1 == team_v1 &&
        other.points == points &&
        other.goalsDiff == goalsDiff &&
        other.group == group &&
        other.form == form &&
        other.description == description &&
        other.wins == wins &&
        other.loses == loses &&
        other.draws == draws &&
        other.goalFor == goalFor &&
        other.goalAgainst == goalAgainst;
  }

  @override
  int get hashCode {
    return rank.hashCode ^
        team_v1.hashCode ^
        points.hashCode ^
        goalsDiff.hashCode ^
        group.hashCode ^
        form.hashCode ^
        description.hashCode ^
        wins.hashCode ^
        loses.hashCode ^
        draws.hashCode ^
        goalFor.hashCode ^
        goalAgainst.hashCode;
  }
}
