// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassroomEntityAdapter extends TypeAdapter<ClassroomEntity> {
  @override
  final int typeId = 4;

  @override
  ClassroomEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassroomEntity(
      id: fields[0] as String,
      createdBy: fields[1] as String,
      name: fields[2] as String,
      code: fields[3] as String,
      description: fields[4] as String,
      isAsync: fields[5] as bool,
      gradeSubjectId: fields[6] as String,
      requireApproval: fields[7] as bool,
      subjectPlan: fields[8] as SubjectPlan,
      file: fields[9] as File,
      gradeSubject: fields[10] as GradeSubject,
      userCreatedBy: fields[11] as UserCreatedBy,
      organization: fields[12] as Organization,
      lastSyncDate: fields[13] as String,
      isUpdated: fields[14] as bool,
      isDeleted: fields[15] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ClassroomEntity obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdBy)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.isAsync)
      ..writeByte(6)
      ..write(obj.gradeSubjectId)
      ..writeByte(7)
      ..write(obj.requireApproval)
      ..writeByte(8)
      ..write(obj.subjectPlan)
      ..writeByte(9)
      ..write(obj.file)
      ..writeByte(10)
      ..write(obj.gradeSubject)
      ..writeByte(11)
      ..write(obj.userCreatedBy)
      ..writeByte(12)
      ..write(obj.organization)
      ..writeByte(13)
      ..write(obj.lastSyncDate)
      ..writeByte(14)
      ..write(obj.isUpdated)
      ..writeByte(15)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassroomEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubjectPlanAdapter extends TypeAdapter<SubjectPlan> {
  @override
  final int typeId = 11;

  @override
  SubjectPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectPlan(
      id: fields[0] as String,
      createdBy: fields[1] as String,
      updatedBy: fields[2] as String,
      name: fields[3] as String,
      status: fields[4] as String,
      classroomId: fields[5] as String,
      organizationId: fields[6] as String,
      createdAt: fields[7] as String,
      updatedAt: fields[8] as String,
      deletedAt: fields[9] as String,
      subjectPlanTree: fields[10] as SubjectPlanTree,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectPlan obj) {
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
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.classroomId)
      ..writeByte(6)
      ..write(obj.organizationId)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.deletedAt)
      ..writeByte(10)
      ..write(obj.subjectPlanTree);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FileAdapter extends TypeAdapter<File> {
  @override
  final int typeId = 15;

  @override
  File read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return File(
      id: fields[0] as String,
      name: fields[1] as String,
      filePath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, File obj) {
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
      other is FileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GradeSubjectAdapter extends TypeAdapter<GradeSubject> {
  @override
  final int typeId = 14;

  @override
  GradeSubject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GradeSubject(
      id: fields[0] as String,
      gradeId: fields[1] as String,
      grade: fields[2] as Grade,
      subject: fields[3] as Subject,
    );
  }

  @override
  void write(BinaryWriter writer, GradeSubject obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.gradeId)
      ..writeByte(2)
      ..write(obj.grade)
      ..writeByte(3)
      ..write(obj.subject);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradeSubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserCreatedByAdapter extends TypeAdapter<UserCreatedBy> {
  @override
  final int typeId = 16;

  @override
  UserCreatedBy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCreatedBy(
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      manuallyActivated: fields[2] as bool,
      manuallyActivatedBy: fields[3] as String,
      manuallyActivatedOn: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserCreatedBy obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.manuallyActivated)
      ..writeByte(3)
      ..write(obj.manuallyActivatedBy)
      ..writeByte(5)
      ..write(obj.manuallyActivatedOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCreatedByAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
