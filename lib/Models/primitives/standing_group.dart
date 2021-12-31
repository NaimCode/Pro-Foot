// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:api_football/Models/primitives/standing_v1.dart';

class StandingGroup {
  List<Standing_v1>? standing_v1s;
  StandingGroup({
    this.standing_v1s,
  });

  StandingGroup copyWith({
    List<Standing_v1>? standing_v1s,
  }) {
    return StandingGroup(
      standing_v1s: standing_v1s ?? this.standing_v1s,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'standing_v1s': standing_v1s?.map((x) => x.toMap()).toList(),
    };
  }

  factory StandingGroup.fromMap(Map<String, dynamic> map) {
    return StandingGroup(
      standing_v1s: map['standing_v1s'] != null
          ? List<Standing_v1>.from(
              map['standing_v1s']?.map((x) => Standing_v1.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StandingGroup.fromJson(String source) =>
      StandingGroup.fromMap(json.decode(source));

  @override
  String toString() => 'StandingGroup(standing_v1s: $standing_v1s)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StandingGroup &&
        listEquals(other.standing_v1s, standing_v1s);
  }

  @override
  int get hashCode => standing_v1s.hashCode;
}
