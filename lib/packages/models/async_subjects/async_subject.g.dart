// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_subject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AsyncSubjectAdapter extends TypeAdapter<AsyncSubject> {
  @override
  final int typeId = 17;

  @override
  AsyncSubject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AsyncSubject(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      icon: fields[3] as String,
      gradeSubjects: (fields[7] as List)?.cast<GradeSubjects>(),
      isDeleted: fields[6] as bool,
      lastSyncDate: fields[4] as String,
      isUpdated: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AsyncSubject obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(7)
      ..write(obj.gradeSubjects)
      ..writeByte(4)
      ..write(obj.lastSyncDate)
      ..writeByte(5)
      ..write(obj.isUpdated)
      ..writeByte(6)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncSubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GradeSubjectsAdapter extends TypeAdapter<GradeSubjects> {
  @override
  final int typeId = 18;

  @override
  GradeSubjects read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GradeSubjects(
      id: fields[0] as String,
      classrooms: (fields[1] as List)?.cast<ClassroomEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, GradeSubjects obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.classrooms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradeSubjectsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
