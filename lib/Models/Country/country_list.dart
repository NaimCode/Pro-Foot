import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:api_football/Models/Country/country.dart';
import 'package:flutter/services.dart';

class CountryList {
  List<Country>? countriesList;
  CountryList({
    this.countriesList,
  });

  CountryList copyWith({
    List<Country>? countriesList,
  }) {
    return CountryList(
      countriesList: countriesList ?? this.countriesList,
    );
  }

  CountryList.fromLocalJson(String jsonString) {
    Iterable iterable = json.decode(jsonString);
    countriesList = iterable
        .map((e) => Country(name: e['name'], flag: e['flag'], code: e['code']))
        .toList();
    // countriesList = List<Country>.from(
    //     iterable.map((jsonNode) => Country.fromJson(jsonNode.toString())));
  }

  Map<String, dynamic> toMap() {
    return {
      'countriesList': countriesList?.map((x) => x.toMap()).toList(),
    };
  }

  factory CountryList.fromMap(Map<String, dynamic> map) {
    return CountryList(
      countriesList: map['countriesList'] != null
          ? List<Country>.from(
              map['countriesList']?.map((x) => Country.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryList.fromJson(String source) =>
      CountryList.fromMap(json.decode(source));

  @override
  String toString() => 'CountryList(countriesList: $countriesList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryList &&
        listEquals(other.countriesList, countriesList);
  }

  @override
  int get hashCode => countriesList.hashCode;
}
