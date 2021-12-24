// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:api_football/Models/primitives/statistic.dart';
import 'package:api_football/Models/primitives/team_v1.dart';

class FixtureStatistic_v1 {
  Team_v1? team;
  List<Statistic>? statistics;
  FixtureStatistic_v1({
    this.team,
    this.statistics,
  });

  FixtureStatistic_v1 copyWith({
    Team_v1? team,
    List<Statistic>? statistics,
  }) {
    return FixtureStatistic_v1(
      team: team ?? this.team,
      statistics: statistics ?? this.statistics,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'team': team?.toMap(),
      'statistics': statistics?.map((x) => x.toMap()).toList(),
    };
  }

  factory FixtureStatistic_v1.fromMap(Map<String, dynamic> map) {
    return FixtureStatistic_v1(
      team: map['team'] != null ? Team_v1.fromMap(map['team']) : null,
      statistics: map['statistics'] != null
          ? List<Statistic>.from(
              map['statistics']?.map((x) => Statistic.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FixtureStatistic_v1.fromJson(String source) =>
      FixtureStatistic_v1.fromMap(json.decode(source));

  @override
  String toString() =>
      'FixtureStatistic_v1(team: $team, statistics: $statistics)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FixtureStatistic_v1 &&
        other.team == team &&
        listEquals(other.statistics, statistics);
  }

  @override
  int get hashCode => team.hashCode ^ statistics.hashCode;
}
