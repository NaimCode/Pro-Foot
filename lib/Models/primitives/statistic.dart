import 'dart:convert';

class Statistic {
  String? type;
  String? value;
  Statistic({
    this.type,
    this.value,
  });

  Statistic copyWith({
    String? type,
    String? value,
  }) {
    return Statistic(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'value': value,
    };
  }

  factory Statistic.fromMap(Map<String, dynamic> map) {
    return Statistic(
      type: map['type'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Statistic.fromJson(String source) => Statistic.fromMap(json.decode(source));

  @override
  String toString() => 'Statistic(type: $type, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Statistic &&
      other.type == type &&
      other.value == value;
  }

  @override
  int get hashCode => type.hashCode ^ value.hashCode;
}
