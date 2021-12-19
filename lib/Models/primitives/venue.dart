import 'dart:convert';

class Venue {
  int? id;
  String? name;
  String? address;
  int? capacity;
  String? city;
  String? image;
  String? surface;
  Venue({
    this.id,
    this.name,
    this.address,
    this.capacity,
    this.city,
    this.image,
    this.surface,
  });

  Venue copyWith({
    int? id,
    String? name,
    String? address,
    int? capacity,
    String? city,
    String? image,
    String? surface,
  }) {
    return Venue(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      capacity: capacity ?? this.capacity,
      city: city ?? this.city,
      image: image ?? this.image,
      surface: surface ?? this.surface,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'capacity': capacity,
      'city': city,
      'image': image,
      'surface': surface,
    };
  }

  factory Venue.fromMap(Map<String, dynamic> map) {
    return Venue(
      id: map['id']?.toInt(),
      name: map['name'],
      address: map['address'],
      capacity: map['capacity']?.toInt(),
      city: map['city'],
      image: map['image'],
      surface: map['surface'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Venue.fromJson(String source) => Venue.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Venue(id: $id, name: $name, address: $address, capacity: $capacity, city: $city, image: $image, surface: $surface)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Venue &&
        other.id == id &&
        other.name == name &&
        other.address == address &&
        other.capacity == capacity &&
        other.city == city &&
        other.image == image &&
        other.surface == surface;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        capacity.hashCode ^
        city.hashCode ^
        image.hashCode ^
        surface.hashCode;
  }
}
