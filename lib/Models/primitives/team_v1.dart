import 'dart:convert';

class Team_v1 {
  int? id;
  String? name;
  String? logo;
  Team_v1({
    this.id,
    this.name,
    this.logo,
  });

  Team_v1 copyWith({
    int? id,
    String? name,
    String? logo,
  }) {
    return Team_v1(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
    };
  }

  Team_v1.fromMap(Map<String, dynamic> map) {
    id = map['id']?.toInt();
    name = map['name'];
    logo = map['logo'];
  }

  String toJson() => json.encode(toMap());

  Team_v1.fromJson(String source) {
    Team_v1.fromMap(json.decode(source));
  }

  @override
  String toString() => 'Team_v1(id: $id, name: $name, logo: $logo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Team_v1 &&
        other.id == id &&
        other.name == name &&
        other.logo == logo;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ logo.hashCode;
}
