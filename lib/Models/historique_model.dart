import 'dart:convert';

import 'package:get/get.dart';

class HistoriqueModel {
  String? image;
  String? name;
  String? route;

  goTo() => Get.toNamed(route!);

  HistoriqueModel({
    this.image,
    this.name,
    this.route,
  });

  HistoriqueModel copyWith({
    String? image,
    String? name,
    String? route,
  }) {
    return HistoriqueModel(
      image: image ?? this.image,
      name: name ?? this.name,
      route: route ?? this.route,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'route': route,
    };
  }

  factory HistoriqueModel.fromMap(Map<String, dynamic> map) {
    return HistoriqueModel(
      image: map['image'],
      name: map['name'],
      route: map['route'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoriqueModel.fromJson(String source) =>
      HistoriqueModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'HistoriqueModel(image: $image, name: $name, route: $route)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoriqueModel &&
        other.image == image &&
        other.name == name &&
        other.route == route;
  }

  @override
  int get hashCode => image.hashCode ^ name.hashCode ^ route.hashCode;
}
