
class ProgressLessonEnrollmentsDto {
  String id;
  String lessonId;
  String enrollmentId;
  String createdBy;
  String updatedBy;

  ProgressLessonEnrollmentsDto({this.id, this.lessonId, this.enrollmentId,
      this.createdBy, this.updatedBy});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['LessonId'] = this.lessonId;
    data['EnrollmentId'] = this.enrollmentId;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}