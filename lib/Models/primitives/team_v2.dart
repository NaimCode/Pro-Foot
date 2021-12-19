import 'dart:convert';

import 'package:api_football/Models/primitives/team_v1.dart';

class Team_v2 extends Team_v1 {
  int? founded;
  String? country;
  bool? national;
  Team_v2({
    this.founded,
    this.country,
    this.national,
    id,
    name,
    logo,
  }) : super(id: id, name: name, logo: logo);

  @override
  Map<String, dynamic> toMap() {
    return {
      'founded': founded,
      'country': country,
      'national': national,
    };
  }

  @override
  Team_v2.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    founded = map['founded']?.toInt();
    country = map['country'];
    national = map['national'];
  }

  @override
  String toJson() => json.encode(toMap());

  Team_v2.fromJson(String source) : super.fromJson(source) {
    Team_v2.fromMap(json.decode(source));
  }

  @override
  String toString() =>
      'Team_v2(founded: $founded, country: $country, national: $national)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Team_v2 &&
        other.founded == founded &&
        other.country == country &&
        other.national == national;
  }

  @override
  int get hashCode => founded.hashCode ^ country.hashCode ^ national.hashCode;
}
