// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roles.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RolesAdapter extends TypeAdapter<Roles> {
  @override
  final int typeId = 10;

  @override
  Roles read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Roles(
      id: fields[1] as String,
      code: fields[2] as String,
      userRoleId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Roles obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.userRoleId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RolesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
