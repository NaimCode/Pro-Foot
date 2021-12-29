import 'dart:convert';

class Lineup {
  String? formation;
  int? played;
  Lineup({
    this.formation,
    this.played,
  });

  Lineup copyWith({
    String? formation,
    int? played,
  }) {
    return Lineup(
      formation: formation ?? this.formation,
      played: played ?? this.played,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'formation': formation,
      'played': played,
    };
  }

  factory Lineup.fromMap(Map<String, dynamic> map) {
    return Lineup(
      formation: map['formation'],
      played: map['played']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Lineup.fromJson(String source) => Lineup.fromMap(json.decode(source));

  @override
  String toString() => 'Lineup(formation: $formation, played: $played)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Lineup &&
        other.formation == formation &&
        other.played == played;
  }

  @override
  int get hashCode => formation.hashCode ^ played.hashCode;
}
