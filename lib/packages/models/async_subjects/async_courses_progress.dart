class AsyncCoursesProgress {
  String id;
  String name;
  String icon;
  int lessons;
  int videos;
  int quizes;
  int finishedItems;
  int materials = 0;
  double score = 0;
  double calculatedScore;

  AsyncCoursesProgress(
      {this.id, this.name, this.icon, this.lessons, this.videos, this.quizes, this.finishedItems, this.materials});

  AsyncCoursesProgress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    lessons = json['lessons'];
    videos = json['videos'];
    quizes = json['quizes'];
    finishedItems = json['finishedItems'];
    materials = json['materials'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['lessons'] = this.lessons;
    data['videos'] = this.videos;
    data['quizes'] = this.quizes;
    data['finishedItems'] = this.finishedItems;
    data['materials'] = this.materials;
    return data;
  }

  @override
  String toString() {
    return 'AsyncCoursesProgress{id: $id, name: $name, icon: $icon, lessons: $lessons, videos: $videos, quizes: $quizes, score: $score, calculatedScore: $calculatedScore}';
  }
}
