// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:api_football/Models/primitives/league_v2.dart';
import 'package:api_football/Models/primitives/standing_group.dart';
import 'package:api_football/Models/primitives/standing_v1.dart';

class Standing {
  League_v2? league_v2;
  List<StandingGroup> standings_groups;
  Standing({
    this.league_v2,
    required this.standings_groups,
  });

  Standing copyWith({
    League_v2? league_v2,
    List<StandingGroup>? standings_groups,
  }) {
    return Standing(
      league_v2: league_v2 ?? this.league_v2,
      standings_groups: standings_groups ?? this.standings_groups,
    );
  }

  factory Standing.fromMap(Map<String, dynamic> map) {
    return Standing(
      league_v2:
          map['league_v2'] != null ? League_v2.fromMap(map['league_v2']) : null,
      standings_groups: List<StandingGroup>.from(
          map['standings_groups']?.map((x) => StandingGroup.fromMap(x))),
    );
  }

  factory Standing.fromJson(String source) =>
      Standing.fromMap(json.decode(source));

  @override
  String toString() =>
      'Standing(league_v2: $league_v2, standings_groups: $standings_groups)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Standing &&
        other.league_v2 == league_v2 &&
        listEquals(other.standings_groups, standings_groups);
  }

  @override
  int get hashCode => league_v2.hashCode ^ standings_groups.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'league_v2': league_v2?.toMap(),
      'standings_groups': standings_groups.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
