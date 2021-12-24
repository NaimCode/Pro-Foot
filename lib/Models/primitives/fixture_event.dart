import 'dart:convert';

import 'package:api_football/Models/primitives/player.dart';
import 'package:api_football/Models/primitives/team_v1.dart';

class FixtureEvent {
  int? elapse;
  Team_v1? team;
  Player? player;
  Player? assist;
  String? type;
  String? detail;
  String? comments;
  FixtureEvent({
    this.elapse,
    this.team,
    this.player,
    this.assist,
    this.type,
    this.detail,
    this.comments,
  });

  FixtureEvent copyWith({
    int? elapse,
    Team_v1? team,
    Player? player,
    Player? assist,
    String? type,
    String? detail,
    String? comments,
  }) {
    return FixtureEvent(
      elapse: elapse ?? this.elapse,
      team: team ?? this.team,
      player: player ?? this.player,
      assist: assist ?? this.assist,
      type: type ?? this.type,
      detail: detail ?? this.detail,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'elapse': elapse,
      'team': team?.toMap(),
      'player': player?.toMap(),
      'assist': assist?.toMap(),
      'type': type,
      'detail': detail,
      'comments': comments,
    };
  }

  factory FixtureEvent.fromMap(Map<String, dynamic> map) {
    return FixtureEvent(
      elapse: map['elapse']?.toInt(),
      team: map['team'] != null ? Team_v1.fromMap(map['team']) : null,
      player: map['player'] != null ? Player.fromMap(map['player']) : null,
      assist: map['assist'] != null ? Player.fromMap(map['assist']) : null,
      type: map['type'],
      detail: map['detail'],
      comments: map['comments'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FixtureEvent.fromJson(String source) =>
      FixtureEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FixtureEvent(elapse: $elapse, team: $team, player: $player, assist: $assist, type: $type, detail: $detail, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FixtureEvent &&
        other.elapse == elapse &&
        other.team == team &&
        other.player == player &&
        other.assist == assist &&
        other.type == type &&
        other.detail == detail &&
        other.comments == comments;
  }

  @override
  int get hashCode {
    return elapse.hashCode ^
        team.hashCode ^
        player.hashCode ^
        assist.hashCode ^
        type.hashCode ^
        detail.hashCode ^
        comments.hashCode;
  }
}
