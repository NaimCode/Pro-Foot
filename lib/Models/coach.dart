import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'primitives/career.dart';
import 'primitives/team_v1.dart';

class Coach {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  int? age;

  String? nationality;
  String? height;
  String? weight;
  String? photo;
  String? dateNaissance;
  String? lieuNaissance;
  Team_v1? team;
  List<Career>? careers;
  Coach({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.age,
    this.nationality,
    this.height,
    this.weight,
    this.photo,
    this.dateNaissance,
    this.lieuNaissance,
    this.team,
    this.careers,
  });

  Coach copyWith({
    int? id,
    String? name,
    String? firstName,
    String? lastName,
    int? age,
    String? nationality,
    String? height,
    String? weight,
    String? photo,
    String? dateNaissance,
    String? lieuNaissance,
    Team_v1? team,
    List<Career>? careers,
  }) {
    return Coach(
      id: id ?? this.id,
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      nationality: nationality ?? this.nationality,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      photo: photo ?? this.photo,
      dateNaissance: dateNaissance ?? this.dateNaissance,
      lieuNaissance: lieuNaissance ?? this.lieuNaissance,
      team: team ?? this.team,
      careers: careers ?? this.careers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'nationality': nationality,
      'height': height,
      'weight': weight,
      'photo': photo,
      'dateNaissance': dateNaissance,
      'lieuNaissance': lieuNaissance,
      'team': team?.toMap(),
      'careers': careers?.map((x) => x.toMap()).toList(),
    };
  }

  factory Coach.fromMap(Map<String, dynamic> map) {
    return Coach(
      id: map['id']?.toInt(),
      name: map['name'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      age: map['age']?.toInt(),
      nationality: map['nationality'],
      height: map['height'],
      weight: map['weight'],
      photo: map['photo'],
      dateNaissance: map['dateNaissance'],
      lieuNaissance: map['lieuNaissance'],
      team: map['team'] != null ? Team_v1.fromMap(map['team']) : null,
      careers: map['careers'] != null
          ? List<Career>.from(map['careers']?.map((x) => Career.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coach.fromJson(String source) => Coach.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Coach(id: $id, name: $name, firstName: $firstName, lastName: $lastName, age: $age, nationality: $nationality, height: $height, weight: $weight, photo: $photo, dateNaissance: $dateNaissance, lieuNaissance: $lieuNaissance, team: $team, careers: $careers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coach &&
        other.id == id &&
        other.name == name &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.age == age &&
        other.nationality == nationality &&
        other.height == height &&
        other.weight == weight &&
        other.photo == photo &&
        other.dateNaissance == dateNaissance &&
        other.lieuNaissance == lieuNaissance &&
        other.team == team &&
        listEquals(other.careers, careers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        age.hashCode ^
        nationality.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        photo.hashCode ^
        dateNaissance.hashCode ^
        lieuNaissance.hashCode ^
        team.hashCode ^
        careers.hashCode;
  }
}
