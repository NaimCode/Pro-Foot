// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'primitives/league_v2.dart';
import 'primitives/team_v1.dart';

class Fixture {
  int? id;
  String? referee;
  int? timestamp;
  int? halfTime;
  int? fullTime;
  String? date;
  int? venueID;
  String? status;
  int? elapse;
  League_v2? league_v2;
  Team_v1? homeTeam;
  Team_v1? awayTeam;
  int? homeGoal;
  int? awayGoal;
  Fixture({
    this.id,
    this.referee,
    this.date,
    this.timestamp,
    this.halfTime,
    this.fullTime,
    this.venueID,
    this.status,
    this.elapse,
    this.league_v2,
    this.homeTeam,
    this.awayTeam,
    this.homeGoal,
    this.awayGoal,
  });

  Fixture copyWith({
    int? id,
    String? referee,
    int? timestamp,
    int? halfTime,
    int? fullTime,
    int? venueID,
    String? status,
    int? elapse,
    League_v2? league_v2,
    Team_v1? homeTeam,
    Team_v1? awayTeam,
    int? homeGoal,
    int? awayGoal,
  }) {
    return Fixture(
      id: id ?? this.id,
      referee: referee ?? this.referee,
      timestamp: timestamp ?? this.timestamp,
      halfTime: halfTime ?? this.halfTime,
      fullTime: fullTime ?? this.fullTime,
      venueID: venueID ?? this.venueID,
      status: status ?? this.status,
      elapse: elapse ?? this.elapse,
      league_v2: league_v2 ?? this.league_v2,
      homeTeam: homeTeam ?? this.homeTeam,
      awayTeam: awayTeam ?? this.awayTeam,
      homeGoal: homeGoal ?? this.homeGoal,
      awayGoal: awayGoal ?? this.awayGoal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'referee': referee,
      'timestamp': timestamp,
      'halfTime': halfTime,
      'fullTime': fullTime,
      'venueID': venueID,
      'status': status,
      'elapse': elapse,
      'league_v2': league_v2?.toMap(),
      'homeTeam': homeTeam?.toMap(),
      'awayTeam': awayTeam?.toMap(),
      'homeGoal': homeGoal,
      'awayGoal': awayGoal,
    };
  }

  factory Fixture.fromMap(Map<String, dynamic> map) {
    return Fixture(
      id: map['id']?.toInt(),
      referee: map['referee'],
      timestamp: map['timestamp']?.toInt(),
      halfTime: map['halfTime']?.toInt(),
      fullTime: map['fullTime']?.toInt(),
      venueID: map['venueID']?.toInt(),
      status: map['status'],
      date: map['date'],
      elapse: map['elapse']?.toInt(),
      league_v2:
          map['league_v2'] != null ? League_v2.fromMap(map['league_v2']) : null,
      homeTeam:
          map['homeTeam'] != null ? Team_v1.fromMap(map['homeTeam']) : null,
      awayTeam:
          map['awayTeam'] != null ? Team_v1.fromMap(map['awayTeam']) : null,
      homeGoal: map['homeGoal']?.toInt(),
      awayGoal: map['awayGoal']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Fixture.fromJson(String source) =>
      Fixture.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Fixture(id: $id, referee: $referee, timestamp: $timestamp, halfTime: $halfTime, fullTime: $fullTime, venueID: $venueID, status: $status, elapse: $elapse, league_v2: $league_v2, homeTeam: $homeTeam, awayTeam: $awayTeam, homeGoal: $homeGoal, awayGoal: $awayGoal)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Fixture &&
        other.id == id &&
        other.referee == referee &&
        other.timestamp == timestamp &&
        other.halfTime == halfTime &&
        other.fullTime == fullTime &&
        other.venueID == venueID &&
        other.status == status &&
        other.elapse == elapse &&
        other.league_v2 == league_v2 &&
        other.homeTeam == homeTeam &&
        other.awayTeam == awayTeam &&
        other.homeGoal == homeGoal &&
        other.awayGoal == awayGoal;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        referee.hashCode ^
        timestamp.hashCode ^
        halfTime.hashCode ^
        fullTime.hashCode ^
        venueID.hashCode ^
        status.hashCode ^
        elapse.hashCode ^
        league_v2.hashCode ^
        homeTeam.hashCode ^
        awayTeam.hashCode ^
        homeGoal.hashCode ^
        awayGoal.hashCode;
  }
}
