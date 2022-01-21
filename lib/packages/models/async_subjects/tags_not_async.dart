class TagsNotAsync {
  String id;
  String organizationId;
  String parentId;
  bool asyncOnly;
  String createdAt;
  String createdBy;
  String deletedAt;
  bool isGlobal;
  String name;
  String priority;
  String target;
  String updatedAt;
  String updatedBy;
  bool isSelected;

  TagsNotAsync({
    this.id,
    this.name,
    this.priority,
    this.deletedAt,
    this.updatedAt,
    this.createdAt,
    this.createdBy,
    this.target,
    this.parentId,
    this.organizationId,
    this.isGlobal,
    this.asyncOnly,
    this.updatedBy,
    this.isSelected = false
  });

  TagsNotAsync.fromJson(Map<String, dynamic> jsonObject){
    id = jsonObject['id'];
    createdBy = jsonObject['createdBy'];
    updatedBy = jsonObject['updatedBy'];
    parentId = jsonObject['ParentId'];
    organizationId = jsonObject['OrganizationId'];
    asyncOnly = jsonObject['asyncOnly'];
    deletedAt = jsonObject['deletedAt'];
    isGlobal = jsonObject['isGlobal'];
    name = jsonObject['name'];
    priority = jsonObject['priority'];
    target = jsonObject['target'];
  }
}