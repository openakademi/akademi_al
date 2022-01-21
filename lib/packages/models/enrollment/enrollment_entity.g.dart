// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnrollmentEntityAdapter extends TypeAdapter<EnrollmentEntity> {
  @override
  final int typeId = 3;

  @override
  EnrollmentEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnrollmentEntity(
      id: fields[0] as String,
      status: fields[1] as String,
      userId: fields[2] as String,
      classroomId: fields[3] as String,
      classroom: fields[4] as ClassroomEntity,
      enrolledAt: fields[5] as String,
      lessons: (fields[6] as List)?.cast<Lessons>(),
      lastSyncDate: fields[7] as String,
      isDeleted: fields[9] as bool,
      isUpdated: fields[8] as bool,
      user: fields[10] as User,
    );
  }

  @override
  void write(BinaryWriter writer, EnrollmentEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.classroomId)
      ..writeByte(4)
      ..write(obj.classroom)
      ..writeByte(5)
      ..write(obj.enrolledAt)
      ..writeByte(6)
      ..write(obj.lessons)
      ..writeByte(7)
      ..write(obj.lastSyncDate)
      ..writeByte(8)
      ..write(obj.isUpdated)
      ..writeByte(9)
      ..write(obj.isDeleted)
      ..writeByte(10)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnrollmentEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EnrollmentClassroomUserCreatedByAdapter
    extends TypeAdapter<EnrollmentClassroomUserCreatedBy> {
  @override
  final int typeId = 5;

  @override
  EnrollmentClassroomUserCreatedBy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnrollmentClassroomUserCreatedBy(
      firstName: fields[0] as String,
      lastName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EnrollmentClassroomUserCreatedBy obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnrollmentClassroomUserCreatedByAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EnrollmentClassroomFileAdapter
    extends TypeAdapter<EnrollmentClassroomFile> {
  @override
  final int typeId = 6;

  @override
  EnrollmentClassroomFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnrollmentClassroomFile()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..filePath = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, EnrollmentClassroomFile obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.filePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnrollmentClassroomFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
