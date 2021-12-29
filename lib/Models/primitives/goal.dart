import 'dart:convert';

import 'package:api_football/Models/primitives/number_statistic.dart';

class Goal {
  NumberStatistic? against;
  NumberStatistic? forr;
  Goal({
    this.against,
    this.forr,
  });

  Goal copyWith({
    NumberStatistic? against,
    NumberStatistic? forr,
  }) {
    return Goal(
      against: against ?? this.against,
      forr: forr ?? this.forr,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'against': against?.toMap(),
      'forr': forr?.toMap(),
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      against: map['against'] != null
          ? NumberStatistic.fromMap(map['against'])
          : null,
      forr: map['forr'] != null ? NumberStatistic.fromMap(map['forr']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Goal.fromJson(String source) => Goal.fromMap(json.decode(source));

  @override
  String toString() => 'Goal(against: $against, forr: $forr)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Goal && other.against == against && other.forr == forr;
  }

  @override
  int get hashCode => against.hashCode ^ forr.hashCode;
}
