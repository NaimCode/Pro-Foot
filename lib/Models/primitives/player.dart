import 'dart:convert';

class Player {
  int? id;
  String? name;
  int? number;
  String? pos;
  String? grid;
  Player({
    this.id,
    this.name,
    this.number,
    this.pos,
    this.grid,
  });

  Player copyWith({
    int? id,
    String? name,
    int? number,
    String? pos,
    String? grid,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      pos: pos ?? this.pos,
      grid: grid ?? this.grid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'pos': pos,
      'grid': grid,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id']?.toInt(),
      name: map['name'],
      number: map['number']?.toInt(),
      pos: map['pos'],
      grid: map['grid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Player(id: $id, name: $name, number: $number, pos: $pos, grid: $grid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Player &&
        other.id == id &&
        other.name == name &&
        other.number == number &&
        other.pos == pos &&
        other.grid == grid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        number.hashCode ^
        pos.hashCode ^
        grid.hashCode;
  }
}
