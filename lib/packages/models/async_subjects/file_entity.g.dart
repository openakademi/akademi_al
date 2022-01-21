// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileAdapter extends TypeAdapter<File> {
  @override
  final int typeId = 20;

  @override
  File read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return File(
      id: fields[0] as String,
      createdBy: fields[1] as String,
      updatedBy: fields[2] as String,
      name: fields[3] as String,
      contentType: fields[4] as String,
      size: fields[5] as int,
      filePath: fields[6] as String,
      createdAt: fields[7] as String,
      updatedAt: fields[8] as String,
      deletedAt: fields[9] as String,
      assignmentUserCommitId: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, File obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdBy)
      ..writeByte(2)
      ..write(obj.updatedBy)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.contentType)
      ..writeByte(5)
      ..write(obj.size)
      ..writeByte(6)
      ..write(obj.filePath)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.deletedAt)
      ..writeByte(10)
      ..write(obj.assignmentUserCommitId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
