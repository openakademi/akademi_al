// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_plan_tree.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectPlanTreeAdapter extends TypeAdapter<SubjectPlanTree> {
  @override
  final int typeId = 12;

  @override
  SubjectPlanTree read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectPlanTree(
      id: fields[0] as String,
      createdBy: fields[1] as String,
      updatedBy: fields[2] as String,
      name: fields[3] as String,
      description: fields[4] as String,
      left: fields[5] as int,
      right: fields[6] as int,
      level: fields[7] as int,
      subjectPlanId: fields[8] as String,
      startDate: fields[9] as String,
      endDate: fields[10] as String,
      createdAt: fields[11] as String,
      updatedAt: fields[12] as String,
      deletedAt: fields[14] as String,
      lessons: (fields[16] as List)?.cast<Lessons>(),
      isRoot: fields[13] as bool,
      children: (fields[15] as List)?.cast<SubjectPlanTree>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubjectPlanTree obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdBy)
      ..writeByte(2)
      ..write(obj.updatedBy)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.left)
      ..writeByte(6)
      ..write(obj.right)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.subjectPlanId)
      ..writeByte(9)
      ..write(obj.startDate)
      ..writeByte(10)
      ..write(obj.endDate)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.isRoot)
      ..writeByte(14)
      ..write(obj.deletedAt)
      ..writeByte(15)
      ..write(obj.children)
      ..writeByte(16)
      ..write(obj.lessons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectPlanTreeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LessonsAdapter extends TypeAdapter<Lessons> {
  @override
  final int typeId = 13;

  @override
  Lessons read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lessons(
      id: fields[0] as String,
      createdBy: fields[1] as String,
      updatedBy: fields[2] as String,
      name: fields[3] as String,
      description: fields[4] as String,
      startDate: fields[5] as String,
      endDate: fields[6] as String,
      videoUrl: fields[7] as String,
      weekId: fields[8] as String,
      fileId: fields[9] as String,
      lessonType: fields[10] as String,
      copiedFromLessonId: fields[11] as String,
      createdAt: fields[12] as String,
      updatedAt: fields[13] as String,
      deletedAt: fields[14] as String,
      subjectPlanTreeLessons: fields[15] as SubjectPlanTreeLessons,
      lessonSections: (fields[19] as List)?.cast<LessonSections>(),
      lessonMetaInfo: (fields[20] as List)?.cast<Quiz>(),
      file: fields[21] as File,
      zoomLesson: fields[22] as ZoomLesson,
    )
      ..localVideoUrl = fields[23] as String
      ..classroomName = fields[24] as String
      ..userId = fields[25] as String
      ..localVideoUrls = (fields[26] as List)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, Lessons obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdBy)
      ..writeByte(2)
      ..write(obj.updatedBy)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.startDate)
      ..writeByte(6)
      ..write(obj.endDate)
      ..writeByte(7)
      ..write(obj.videoUrl)
      ..writeByte(8)
      ..write(obj.weekId)
      ..writeByte(9)
      ..write(obj.fileId)
      ..writeByte(10)
      ..write(obj.lessonType)
      ..writeByte(11)
      ..write(obj.copiedFromLessonId)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.deletedAt)
      ..writeByte(15)
      ..write(obj.subjectPlanTreeLessons)
      ..writeByte(19)
      ..write(obj.lessonSections)
      ..writeByte(20)
      ..write(obj.lessonMetaInfo)
      ..writeByte(21)
      ..write(obj.file)
      ..writeByte(22)
      ..write(obj.zoomLesson)
      ..writeByte(23)
      ..write(obj.localVideoUrl)
      ..writeByte(24)
      ..write(obj.classroomName)
      ..writeByte(25)
      ..write(obj.userId)
      ..writeByte(26)
      ..write(obj.localVideoUrls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LessonSectionsAdapter extends TypeAdapter<LessonSections> {
  @override
  final int typeId = 19;

  @override
  LessonSections read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonSections(
      id: fields[0] as String,
      createdBy: fields[1] as String,
      updatedBy: fields[2] as String,
      name: fields[3] as String,
      description: fields[4] as String,
      url: fields[5] as String,
      lessonId: fields[6] as String,
      fileId: fields[7] as String,
      createdAt: fields[8] as String,
      updatedAt: fields[9] as String,
      deletedAt: fields[10] as String,
      file: fields[11] as File,
    );
  }

  @override
  void write(BinaryWriter writer, LessonSections obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdBy)
      ..writeByte(2)
      ..write(obj.updatedBy)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.lessonId)
      ..writeByte(7)
      ..write(obj.fileId)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.deletedAt)
      ..writeByte(11)
      ..write(obj.file);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonSectionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
