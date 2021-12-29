import 'dart:convert';

class NumberStatistic {
  int? home;
  int? away;
  int? total;
  NumberStatistic({
    this.home,
    this.away,
    this.total,
  });

  NumberStatistic copyWith({
    int? home,
    int? away,
    int? total,
  }) {
    return NumberStatistic(
      home: home ?? this.home,
      away: away ?? this.away,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'home': home,
      'away': away,
      'total': total,
    };
  }

  factory NumberStatistic.fromMap(Map<String, dynamic> map) {
    return NumberStatistic(
      home: map['home']?.toInt(),
      away: map['away']?.toInt(),
      total: map['total']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NumberStatistic.fromJson(String source) =>
      NumberStatistic.fromMap(json.decode(source));

  @override
  String toString() =>
      'NumberStatistic(home: $home, away: $away, total: $total)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NumberStatistic &&
        other.home == home &&
        other.away == away &&
        other.total == total;
  }

  @override
  int get hashCode => home.hashCode ^ away.hashCode ^ total.hashCode;
}
