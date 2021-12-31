import 'dart:convert';

class Player {
  int? id;
  String? name;
  int? number;
  String? pos;
  String? grid;
  String? photo;
  String? firstname;
  String? lastname;
  int? age;
  String? nationality;

  Player({
    this.id,
    this.name,
    this.number,
    this.pos,
    this.grid,
    this.photo,
    this.firstname,
    this.lastname,
    this.age,
    this.nationality,
  });

  Player copyWith({
    int? id,
    String? name,
    int? number,
    String? pos,
    String? grid,
    String? photo,
    String? firstname,
    String? lastname,
    int? age,
    String? nationality,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      pos: pos ?? this.pos,
      grid: grid ?? this.grid,
      photo: photo ?? this.photo,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      age: age ?? this.age,
      nationality: nationality ?? this.nationality,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'pos': pos,
      'grid': grid,
      'photo': photo,
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
      'nationality': nationality,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id']?.toInt(),
      name: map['name'],
      number: map['number']?.toInt(),
      pos: map['pos'],
      grid: map['grid'],
      photo: map['photo'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      age: map['age']?.toInt(),
      nationality: map['nationality'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Player(id: $id, name: $name, number: $number, pos: $pos, grid: $grid, photo: $photo, firstname: $firstname, lastname: $lastname, age: $age, nationality: $nationality)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Player &&
      other.id == id &&
      other.name == name &&
      other.number == number &&
      other.pos == pos &&
      other.grid == grid &&
      other.photo == photo &&
      other.firstname == firstname &&
      other.lastname == lastname &&
      other.age == age &&
      other.nationality == nationality;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      number.hashCode ^
      pos.hashCode ^
      grid.hashCode ^
      photo.hashCode ^
      firstname.hashCode ^
      lastname.hashCode ^
      age.hashCode ^
      nationality.hashCode;
  }
}
