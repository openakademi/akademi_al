class TagsAsync {
  String id;
  String organizationId;
  String parentId;
  bool asyncOnly;
  String subTagsCount;
  bool isGlobal;
  String name;
  String priority;
  String target;
  bool isSelected;

  TagsAsync({
    this.id,
    this.name,
    this.priority,
    this.target,
    this.parentId,
    this.organizationId,
    this.isGlobal,
    this.asyncOnly,
    this.isSelected = false
  });

  TagsAsync.fromJson(Map<String, dynamic> jsonObject){
    id = jsonObject['id'];
    parentId = jsonObject['ParentId'];
    organizationId = jsonObject['OrganizationId'];
    asyncOnly = jsonObject['asyncOnly'];
    subTagsCount = jsonObject['SubTagsCount'];
    isGlobal = jsonObject['isGlobal'];
    name = jsonObject['name'];
    priority = jsonObject['priority'];
    target = jsonObject['target'];
  }
}