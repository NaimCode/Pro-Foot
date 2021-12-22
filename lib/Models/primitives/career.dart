import 'dart:convert';

import 'package:api_football/Models/primitives/team_v1.dart';

class Career {
  Team_v1? team;
  String? start;

  String? end;
  Career({
    this.team,
    this.start,
    this.end,
  });

  Career copyWith({
    Team_v1? team,
    String? start,
    String? end,
  }) {
    return Career(
      team: team ?? this.team,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'team': team?.toMap(),
      'start': start,
      'end': end,
    };
  }

  factory Career.fromMap(Map<String, dynamic> map) {
    return Career(
      team: map['team'] != null ? Team_v1.fromMap(map['team']) : null,
      start: map['start'],
      end: map['end'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Career.fromJson(String source) => Career.fromMap(json.decode(source));

  @override
  String toString() => 'Career(team: $team, start: $start, end: $end)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Career &&
        other.team == team &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => team.hashCode ^ start.hashCode ^ end.hashCode;
}
