import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:api_football/Models/coach.dart';
import 'package:api_football/Models/primitives/player.dart';

class FixtureLineup {
  Coach? coach;
  String? formation;
  List<Player>? startIX;
  List<Player>? substitutes;
  FixtureLineup({
    this.coach,
    this.formation,
    this.startIX,
    this.substitutes,
  });

  FixtureLineup copyWith({
    Coach? coach,
    String? formation,
    List<Player>? startIX,
    List<Player>? substitutes,
  }) {
    return FixtureLineup(
      coach: coach ?? this.coach,
      formation: formation ?? this.formation,
      startIX: startIX ?? this.startIX,
      substitutes: substitutes ?? this.substitutes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coach': coach?.toMap(),
      'formation': formation,
      'startIX': startIX?.map((x) => x.toMap()).toList(),
      'substitutes': substitutes?.map((x) => x.toMap()).toList(),
    };
  }

  factory FixtureLineup.fromMap(Map<String, dynamic> map) {
    return FixtureLineup(
      coach: map['coach'] != null ? Coach.fromMap(map['coach']) : null,
      formation: map['formation'],
      startIX: map['startIX'] != null
          ? List<Player>.from(map['startIX']?.map((x) => Player.fromMap(x)))
          : null,
      substitutes: map['substitutes'] != null
          ? List<Player>.from(map['substitutes']?.map((x) => Player.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FixtureLineup.fromJson(String source) =>
      FixtureLineup.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FixtureLineup(coach: $coach, formation: $formation, startIX: $startIX, substitutes: $substitutes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FixtureLineup &&
        other.coach == coach &&
        other.formation == formation &&
        listEquals(other.startIX, startIX) &&
        listEquals(other.substitutes, substitutes);
  }

  @override
  int get hashCode {
    return coach.hashCode ^
        formation.hashCode ^
        startIX.hashCode ^
        substitutes.hashCode;
  }
}
