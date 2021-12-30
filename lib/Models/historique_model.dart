import 'dart:convert';

import 'package:api_football/Models/league.dart';
import 'package:api_football/Models/team.dart';
import 'package:api_football/Routes/Equipe/equipe_fixture.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Widgets/page.dart';
import 'package:get/get.dart';

class HistoriqueModel {
  String? image;
  String? name;
  String? type;
  String? id;

  goTo() async {
    API api = API();

    switch (type) {
      case "equipe":
        var response = await api.getTeams(name!);
        Team team =
            response.data.map((l) => Team.fromMap(l)).toList().cast<Team>()[0];
        Get.to(
          Root(page: EquipeFixture(team: team)),
          routeName: "/equipes/" + team.team_v2!.id.toString(),
          transition: Transition.leftToRight,
          duration: const Duration(milliseconds: 500),
        );
        break;
      default:
    }
  }

  HistoriqueModel({
    this.image,
    this.name,
    this.type,
    this.id,
  });

  HistoriqueModel copyWith({
    String? image,
    String? name,
    String? type,
    String? id,
  }) {
    return HistoriqueModel(
      image: image ?? this.image,
      name: name ?? this.name,
      type: type ?? this.type,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'type': type,
      'id': id,
    };
  }

  factory HistoriqueModel.fromMap(Map<String, dynamic> map) {
    return HistoriqueModel(
      image: map['image'],
      name: map['name'],
      type: map['type'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoriqueModel.fromJson(String source) =>
      HistoriqueModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoriqueModel(image: $image, name: $name, type: $type, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoriqueModel &&
        other.image == image &&
        other.name == name &&
        other.type == type &&
        other.id == id;
  }

  @override
  int get hashCode {
    return image.hashCode ^ name.hashCode ^ type.hashCode ^ id.hashCode;
  }
}
