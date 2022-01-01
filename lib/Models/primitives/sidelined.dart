import 'dart:convert';

class Sidelined {
  String? type;
  String? start;
  String? end;
  Sidelined({
    this.type,
    this.start,
    this.end,
  });

  Sidelined copyWith({
    String? type,
    String? start,
    String? end,
  }) {
    return Sidelined(
      type: type ?? this.type,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'start': start,
      'end': end,
    };
  }

  factory Sidelined.fromMap(Map<String, dynamic> map) {
    return Sidelined(
      type: map['type'],
      start: map['start'],
      end: map['end'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Sidelined.fromJson(String source) =>
      Sidelined.fromMap(json.decode(source));

  @override
  String toString() => 'Sidelined(type: $type, start: $start, end: $end)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sidelined &&
        other.type == type &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => type.hashCode ^ start.hashCode ^ end.hashCode;
}
