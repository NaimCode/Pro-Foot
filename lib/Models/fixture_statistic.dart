// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:api_football/Models/primitives/fixture_event.dart';
import 'package:api_football/Models/primitives/fixture_lineup.dart';
import 'package:api_football/Models/primitives/fixture_statistic_v1.dart';

import 'primitives/venue.dart';

class FixtureStatistic {
  List<FixtureStatistic_v1>? fixtureStatistic_v1s;
  List<FixtureLineup>? fixtureLineups;
  List<FixtureEvent>? fixtureEvents;
  Venue? venue;
  FixtureStatistic({
    this.fixtureStatistic_v1s,
    this.fixtureLineups,
    this.fixtureEvents,
    this.venue,
  });

  FixtureStatistic copyWith({
    List<FixtureStatistic_v1>? fixtureStatistic_v1s,
    List<FixtureLineup>? fixtureLineups,
    List<FixtureEvent>? fixtureEvents,
    Venue? venue,
  }) {
    return FixtureStatistic(
      fixtureStatistic_v1s: fixtureStatistic_v1s ?? this.fixtureStatistic_v1s,
      fixtureLineups: fixtureLineups ?? this.fixtureLineups,
      fixtureEvents: fixtureEvents ?? this.fixtureEvents,
      venue: venue ?? this.venue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fixtureStatistic_v1s':
          fixtureStatistic_v1s?.map((x) => x.toMap()).toList(),
      'fixtureLineups': fixtureLineups?.map((x) => x.toMap()).toList(),
      'fixtureEvents': fixtureEvents?.map((x) => x.toMap()).toList(),
      'venue': venue?.toMap(),
    };
  }

  factory FixtureStatistic.fromMap(Map<String, dynamic> map) {
    return FixtureStatistic(
      fixtureStatistic_v1s: map['fixtureStatistic_v1s'] != null
          ? List<FixtureStatistic_v1>.from(map['fixtureStatistic_v1s']
              ?.map((x) => FixtureStatistic_v1.fromMap(x)))
          : null,
      fixtureLineups: map['fixtureLineups'] != null
          ? List<FixtureLineup>.from(
              map['fixtureLineups']?.map((x) => FixtureLineup.fromMap(x)))
          : null,
      fixtureEvents: map['fixtureEvents'] != null
          ? List<FixtureEvent>.from(
              map['fixtureEvents']?.map((x) => FixtureEvent.fromMap(x)))
          : null,
      venue: map['venue'] != null ? Venue.fromMap(map['venue']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FixtureStatistic.fromJson(String source) =>
      FixtureStatistic.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FixtureStatistic(fixtureStatistic_v1s: $fixtureStatistic_v1s, fixtureLineups: $fixtureLineups, fixtureEvents: $fixtureEvents, venue: $venue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FixtureStatistic &&
        listEquals(other.fixtureStatistic_v1s, fixtureStatistic_v1s) &&
        listEquals(other.fixtureLineups, fixtureLineups) &&
        listEquals(other.fixtureEvents, fixtureEvents) &&
        other.venue == venue;
  }

  @override
  int get hashCode {
    return fixtureStatistic_v1s.hashCode ^
        fixtureLineups.hashCode ^
        fixtureEvents.hashCode ^
        venue.hashCode;
  }
}
