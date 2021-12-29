// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:api_football/Models/primitives/number_statistic.dart';

class Fixture_v1 {
  NumberStatistic? played;
  NumberStatistic? loses;
  NumberStatistic? wins;
  NumberStatistic? draws;
  Fixture_v1({
    this.played,
    this.loses,
    this.wins,
    this.draws,
  });

  Fixture_v1 copyWith({
    NumberStatistic? played,
    NumberStatistic? loses,
    NumberStatistic? wins,
    NumberStatistic? draws,
  }) {
    return Fixture_v1(
      played: played ?? this.played,
      loses: loses ?? this.loses,
      wins: wins ?? this.wins,
      draws: draws ?? this.draws,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'played': played?.toMap(),
      'loses': loses?.toMap(),
      'wins': wins?.toMap(),
      'draws': draws?.toMap(),
    };
  }

  factory Fixture_v1.fromMap(Map<String, dynamic> map) {
    return Fixture_v1(
      played:
          map['played'] != null ? NumberStatistic.fromMap(map['played']) : null,
      loses:
          map['loses'] != null ? NumberStatistic.fromMap(map['loses']) : null,
      wins: map['wins'] != null ? NumberStatistic.fromMap(map['wins']) : null,
      draws:
          map['draws'] != null ? NumberStatistic.fromMap(map['draws']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fixture_v1.fromJson(String source) =>
      Fixture_v1.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Fixture_v1(played: $played, loses: $loses, wins: $wins, draws: $draws)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Fixture_v1 &&
        other.played == played &&
        other.loses == loses &&
        other.wins == wins &&
        other.draws == draws;
  }

  @override
  int get hashCode {
    return played.hashCode ^ loses.hashCode ^ wins.hashCode ^ draws.hashCode;
  }
}
