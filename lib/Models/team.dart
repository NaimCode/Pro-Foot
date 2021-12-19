// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'primitives/team_v2.dart';
import 'primitives/venue.dart';

class Team {
  Team_v2? team_v2;
  Venue? venue;
  Team({
    this.venue,
    this.team_v2,
  });

  Team copyWith({Venue? venue, Team_v2? team_v2}) {
    return Team(
      venue: venue ?? this.venue,
      team_v2: team_v2 ?? this.team_v2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'venue': venue?.toMap(),
      'team_v2': team_v2?.toMap(),
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      venue: map['venue'] != null ? Venue.fromMap(map['venue']) : null,
      team_v2: map['team_v2'] != null ? Team_v2.fromMap(map['team_v2']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) => Team.fromMap(json.decode(source));

  @override
  String toString() => 'Team(venue: $venue)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Team && other.venue == venue;
  }

  @override
  int get hashCode => venue.hashCode;
}
