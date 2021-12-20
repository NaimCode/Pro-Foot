import 'dart:convert';

// ignore: camel_case_types
class League_v1 {
  int? id;
  String? name;
  String? type;
  String? logo;
  League_v1({
    this.id,
    this.name,
    this.type,
    this.logo,
  });

  League_v1 copyWith({
    int? id,
    String? name,
    String? type,
    String? logo,
  }) {
    return League_v1(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'logo': logo,
    };
  }

  League_v1.fromMap(Map<String, dynamic> map) {
    id = map['id']?.toInt();
    name = map['name'];
    type = map['type'];
    logo = map['logo'];
  }

  String toJson() => json.encode(toMap());

  factory League_v1.fromJson(String source) =>
      League_v1.fromMap(json.decode(source));

  @override
  String toString() {
    return 'League_v1(id: $id, name: $name, type: $type, logo: $logo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is League_v1 &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.logo == logo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ type.hashCode ^ logo.hashCode;
  }
}
