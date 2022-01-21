// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_lessons.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectLessonsAdapter extends TypeAdapter<SubjectLessons> {
  @override
  final int typeId = 21;

  @override
  SubjectLessons read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectLessons(
      updatedBy: fields[2] as String,
      deletedAt: fields[6] as String,
      createdBy: fields[1] as String,
      asyncOnly: fields[5] as bool,
      classroomTags: (fields[11] as List)?.cast<ClassroomTags>(),
      id: fields[0] as String,
      isGlobal: fields[7] as bool,
      name: fields[8] as String,
      organization: fields[12] as SubjectOrganization,
      organizationId: fields[4] as String,
      parentId: fields[3] as String,
      priority: fields[9] as String,
      target: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectLessons obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdBy)
      ..writeByte(2)
      ..write(obj.updatedBy)
      ..writeByte(3)
      ..write(obj.parentId)
      ..writeByte(4)
      ..write(obj.organizationId)
      ..writeByte(5)
      ..write(obj.asyncOnly)
      ..writeByte(6)
      ..write(obj.deletedAt)
      ..writeByte(7)
      ..write(obj.isGlobal)
      ..writeByte(8)
      ..write(obj.name)
      ..writeByte(9)
      ..write(obj.priority)
      ..writeByte(10)
      ..write(obj.target)
      ..writeByte(11)
      ..write(obj.classroomTags)
      ..writeByte(12)
      ..write(obj.organization);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectLessonsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClassroomTagsAdapter extends TypeAdapter<ClassroomTags> {
  @override
  final int typeId = 22;

  @override
  ClassroomTags read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassroomTags(
      priority: fields[6] as int,
      id: fields[5] as String,
      createdBy: fields[3] as String,
      deletedAt: fields[4] as String,
      updatedBy: fields[8] as String,
      updatedAt: fields[7] as String,
      createdAt: fields[2] as String,
      classroomId: fields[0] as String,
      lessonClassroomTag: (fields[9] as List)?.cast<LessonClassroomTag>(),
      tagId: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ClassroomTags obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.classroomId)
      ..writeByte(1)
      ..write(obj.tagId)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.createdBy)
      ..writeByte(4)
      ..write(obj.deletedAt)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.priority)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.updatedBy)
      ..writeByte(9)
      ..write(obj.lessonClassroomTag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassroomTagsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LessonClassroomTagAdapter extends TypeAdapter<LessonClassroomTag> {
  @override
  final int typeId = 23;

  @override
  LessonClassroomTag read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonClassroomTag(
      createdAt: fields[3] as String,
      updatedAt: fields[5] as String,
      deletedAt: fields[4] as String,
      id: fields[0] as String,
      priority: fields[1] as int,
      classroomTagId: fields[6] as String,
      lesson: fields[7] as Lessons,
      lessonId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LessonClassroomTag obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.priority)
      ..writeByte(2)
      ..write(obj.lessonId)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.deletedAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.classroomTagId)
      ..writeByte(7)
      ..write(obj.lesson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonClassroomTagAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubjectOrganizationAdapter extends TypeAdapter<SubjectOrganization> {
  @override
  final int typeId = 25;

  @override
  SubjectOrganization read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectOrganization(
      parentOrganizationId: fields[3] as String,
      name: fields[1] as String,
      code: fields[5] as String,
      id: fields[0] as String,
      contentType: fields[2] as String,
      createdAt: fields[6] as String,
      createdBy: fields[7] as String,
      defaultValue: fields[8] as bool,
      deletedAt: fields[21] as String,
      domain: fields[9] as String,
      nationality: fields[4] as String,
      numberOfUsers: fields[10] as int,
      ownerEmail: fields[11] as String,
      price: fields[12] as String,
      ratio: fields[13] as String,
      requireApproval: fields[14] as bool,
      sector: fields[15] as String,
      status: fields[16] as String,
      superOrganization: fields[17] as bool,
      type: fields[18] as String,
      updatedAt: fields[19] as String,
      updatedBy: fields[20] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectOrganization obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.contentType)
      ..writeByte(3)
      ..write(obj.parentOrganizationId)
      ..writeByte(4)
      ..write(obj.nationality)
      ..writeByte(5)
      ..write(obj.code)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.createdBy)
      ..writeByte(8)
      ..write(obj.defaultValue)
      ..writeByte(9)
      ..write(obj.domain)
      ..writeByte(10)
      ..write(obj.numberOfUsers)
      ..writeByte(11)
      ..write(obj.ownerEmail)
      ..writeByte(12)
      ..write(obj.price)
      ..writeByte(13)
      ..write(obj.ratio)
      ..writeByte(14)
      ..write(obj.requireApproval)
      ..writeByte(15)
      ..write(obj.sector)
      ..writeByte(16)
      ..write(obj.status)
      ..writeByte(17)
      ..write(obj.superOrganization)
      ..writeByte(18)
      ..write(obj.type)
      ..writeByte(19)
      ..write(obj.updatedAt)
      ..writeByte(20)
      ..write(obj.updatedBy)
      ..writeByte(21)
      ..write(obj.deletedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectOrganizationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
