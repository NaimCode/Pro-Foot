import 'dart:convert';

class Season {
  int? year;
  String? start;
  String? end;
  bool? current;
  Season({
    this.year,
    this.start,
    this.end,
    this.current,
  });

  Season copyWith({
    int? year,
    String? start,
    String? end,
    bool? current,
  }) {
    return Season(
      year: year ?? this.year,
      start: start ?? this.start,
      end: end ?? this.end,
      current: current ?? this.current,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'start': start,
      'end': end,
      'current': current,
    };
  }

  factory Season.fromMap(Map<String, dynamic> map) {
    return Season(
      year: map['year']?.toInt(),
      start: map['start'],
      end: map['end'],
      current: map['current'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Season.fromJson(String source) => Season.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Season(year: $year, start: $start, end: $end, current: $current)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Season &&
        other.year == year &&
        other.start == start &&
        other.end == end &&
        other.current == current;
  }

  @override
  int get hashCode {
    return year.hashCode ^ start.hashCode ^ end.hashCode ^ current.hashCode;
  }
}
