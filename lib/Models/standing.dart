// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:api_football/Models/primitives/league_v2.dart';
import 'package:api_football/Models/primitives/standing_v1.dart';

class Standing {
  League_v2? league_v2;
  List<Standing_v1>? standing_v1s;
  Standing({
    this.league_v2,
    this.standing_v1s,
  });

  Standing copyWith({
    League_v2? league_v2,
    List<Standing_v1>? standing_v1s,
  }) {
    return Standing(
      league_v2: league_v2 ?? this.league_v2,
      standing_v1s: standing_v1s ?? this.standing_v1s,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'league_v2': league_v2?.toMap(),
      'standing_v1s': standing_v1s?.map((x) => x.toMap()).toList(),
    };
  }

  factory Standing.fromMap(Map<String, dynamic> map) {
    return Standing(
      league_v2:
          map['league_v2'] != null ? League_v2.fromMap(map['league_v2']) : null,
      standing_v1s: map['standing_v1s'] != null
          ? List<Standing_v1>.from(
              map['standing_v1s']?.map((x) => Standing_v1.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Standing.fromJson(String source) =>
      Standing.fromMap(json.decode(source));

  @override
  String toString() =>
      'Standing(league_v2: $league_v2, standing_v1s: $standing_v1s)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Standing &&
        other.league_v2 == league_v2 &&
        listEquals(other.standing_v1s, standing_v1s);
  }

  @override
  int get hashCode => league_v2.hashCode ^ standing_v1s.hashCode;
}
