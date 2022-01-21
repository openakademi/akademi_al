class ProfilePictureFile {
  String id;
  String name;
  String contentType;
  int size;
  String filePath;
  String createdBy;
  String updatedBy;

  ProfilePictureFile({this.id, this.name, this.contentType, this.size, this.filePath, this.createdBy, this.updatedBy});

  ProfilePictureFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contentType = json['contentType'];
    size = json['size'];
    filePath = json['filePath'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contentType'] = this.contentType;
    data['size'] = this.size;
    data['filePath'] = this.filePath;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    return data;
  }

  @override
  String toString() {
    return 'ProfilePictureFile{id: $id, name: $name, contentType: $contentType, size: $size, filePath: $filePath}';
  }
}
