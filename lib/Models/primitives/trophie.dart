import 'dart:convert';

class Trophie {
  String? season;
  String? place;
  String? league;
  Trophie({
    this.season,
    this.place,
    this.league,
  });
  

  Trophie copyWith({
    String? season,
    String? place,
    String? league,
  }) {
    return Trophie(
      season: season ?? this.season,
      place: place ?? this.place,
      league: league ?? this.league,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'season': season,
      'place': place,
      'league': league,
    };
  }

  factory Trophie.fromMap(Map<String, dynamic> map) {
    return Trophie(
      season: map['season'],
      place: map['place'],
      league: map['league'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Trophie.fromJson(String source) => Trophie.fromMap(json.decode(source));

  @override
  String toString() => 'Trophie(season: $season, place: $place, league: $league)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Trophie &&
      other.season == season &&
      other.place == place &&
      other.league == league;
  }

  @override
  int get hashCode => season.hashCode ^ place.hashCode ^ league.hashCode;
}
