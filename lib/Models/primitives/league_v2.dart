import 'dart:convert';

import 'package:api_football/Models/primitives/league_v1.dart';

class League_v2 extends League_v1 {
  int? season;
  String? country;
  String? flag;
  String? round;
  League_v2({this.season, this.country, this.flag, id, name, type, logo})
      : super(id: id, logo: logo, type: type, name: name);

  Map<String, dynamic> toMap() {
    return {
      'season': season,
      'country': country,
      'flag': flag,
    };
  }

  League_v2.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    season = map['season']?.toInt();
    country = map['country'];
    flag = map['flag'];
    round = map['round'];
  }

  String toJson() => json.encode(toMap());

  factory League_v2.fromJson(String source) =>
      League_v2.fromMap(json.decode(source));

  @override
  String toString() =>
      'League_v2(season: $season, country: $country, flag: $flag)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is League_v2 &&
        other.season == season &&
        other.country == country &&
        other.flag == flag;
  }

  @override
  int get hashCode => season.hashCode ^ country.hashCode ^ flag.hashCode;
}
