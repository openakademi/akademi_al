import 'dart:convert';

class QuizAnswers {
  String id;
  String userId;
  String lessonId;
  List<AnswerMetaInfo> answerMetaInfo;
  String updatedAt;
  String createdAt;
  String deletedAt;

  QuizAnswers(
      {this.id,
        this.userId,
        this.lessonId,
        this.answerMetaInfo,
        this.updatedAt,
        this.createdAt,
        this.deletedAt});

  QuizAnswers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    lessonId = json['LessonId'];
    answerMetaInfo = json['answerMetaInfo'] != null ? jsonDecode(json['answerMetaInfo']).map<AnswerMetaInfo>((e) =>AnswerMetaInfo.fromJson(e)).toList() : null;
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['LessonId'] = this.lessonId;
    data['answerMetaInfo'] = this.answerMetaInfo.map((e) => jsonEncode(e.toJson()).toString()).toList().toString();
    return data;
  }

  QuizAnswers copyWith({
    String id,
    String userId,
    String lessonId,
    List<AnswerMetaInfo> answerMetaInfo,
    String updatedAt,
    String createdAt,
    String deletedAt,
  }) {
    return new QuizAnswers(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lessonId: lessonId ?? this.lessonId,
      answerMetaInfo: answerMetaInfo ?? this.answerMetaInfo,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  String toString() {
    return 'QuizAnswers{id: $id, userId: $userId, lessonId: $lessonId, answerMetaInfo: $answerMetaInfo, updatedAt: $updatedAt, createdAt: $createdAt, deletedAt: $deletedAt}';
  }
}


class AnswerMetaInfo {
  String questionId;
  List<Answer> answers;

  AnswerMetaInfo({this.questionId, this.answers});

  AnswerMetaInfo.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    if (json['answers'] != null) {
      answers = new List<Answer>();
      json['answers'].forEach((v) {
        answers.add(new Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'AnswerMetaInfo{questionId: $questionId, answers: $answers}';
  }
}

class Answer {
  String answerId;

  Answer({this.answerId});

  Answer.fromJson(Map<String, dynamic> json) {
    answerId = json['answerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answerId'] = this.answerId;
    return data;
  }

  @override
  String toString() {
    return 'Answer{answerId: $answerId}';
  }
}
