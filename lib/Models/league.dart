// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'country.dart';
import 'primitives/league_v1.dart';
import 'primitives/season.dart';

class League {
  League_v1? league_v1;
  Country? country;
  List<Season>? seasons;
  League({
    this.league_v1,
    this.country,
    this.seasons,
  });

  League copyWith({
    League_v1? league_v1,
    Country? country,
    List<Season>? seasons,
  }) {
    return League(
      country: country ?? this.country,
      seasons: seasons ?? this.seasons,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country?.toMap(),
      'league_v1': league_v1?.toMap(),
      'seasons': seasons?.map((x) => x.toMap()).toList(),
    };
  }

  factory League.fromMap(Map<String, dynamic> map) {
    return League(
      country: map['country'] != null ? Country.fromMap(map['country']) : null,
      league_v1:
          map['league_v1'] != null ? League_v1.fromMap(map['league_v1']) : null,
      seasons: map['seasons'] != null
          ? List<Season>.from(map['seasons']?.map((x) => Season.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory League.fromJson(String source) => League.fromMap(json.decode(source));

  @override
  String toString() => 'League(country: $country, seasons: $seasons)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is League &&
        other.country == country &&
        listEquals(other.seasons, seasons);
  }

  @override
  int get hashCode => country.hashCode ^ seasons.hashCode;
}
