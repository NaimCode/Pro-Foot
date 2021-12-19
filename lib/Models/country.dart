import 'dart:convert';

class Country {
  String? name;
  String? code;
  String? flag;
  Country({
    this.name,
    this.code,
    this.flag,
  });

  Country copyWith({
    String? name,
    String? code,
    String? flag,
  }) {
    return Country(
      name: name ?? this.name,
      code: code ?? this.code,
      flag: flag ?? this.flag,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'flag': flag,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name'],
      code: map['code'],
      flag: map['flag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() => 'Country(name: $name, code: $code, flag: $flag)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.name == name &&
        other.code == code &&
        other.flag == flag;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ flag.hashCode;
}
