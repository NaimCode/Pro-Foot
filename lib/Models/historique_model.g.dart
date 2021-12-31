// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historique_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoriqueModelAdapter extends TypeAdapter<HistoriqueModel> {
  @override
  final int typeId = 0;

  @override
  HistoriqueModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoriqueModel(
      image: fields[1] as String?,
      name: fields[0] as String?,
      route: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HistoriqueModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.route);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoriqueModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
