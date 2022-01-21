class Subject {
  String id;
  String subjectId;
  String subjectName;
  String classRoomId;

  Subject({this.id, this.subjectId, this.subjectName, this.classRoomId});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
    classRoomId = json['classRoomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subjectId'] = this.subjectId;
    data['subjectName'] = this.subjectName;
    data['classRoomId'] = this.classRoomId;
    return data;
  }
}