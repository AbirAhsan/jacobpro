class SkillDataModel {
  int? skillCategoryId;
  String? skillCategoryName;
  List<SkillSubCategoryData>? skillSubCategoryData;

  SkillDataModel(
      {this.skillCategoryId,
      this.skillCategoryName,
      this.skillSubCategoryData});

  SkillDataModel.fromJson(Map<String, dynamic> json) {
    skillCategoryId = json['skillCategoryId'];
    skillCategoryName = json['skillCategoryName'];
    if (json['skillSubCategoryData'] != null) {
      skillSubCategoryData = <SkillSubCategoryData>[];
      json['skillSubCategoryData'].forEach((v) {
        skillSubCategoryData!.add(SkillSubCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skillCategoryId'] = skillCategoryId;
    data['skillCategoryName'] = skillCategoryName;
    if (skillSubCategoryData != null) {
      data['skillSubCategoryData'] =
          skillSubCategoryData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SkillSubCategoryData {
  int? skillSubCategoryId;
  String? skillSubCategoryName;
  List<SkillData>? skillData;

  SkillSubCategoryData(
      {this.skillSubCategoryId, this.skillSubCategoryName, this.skillData});

  SkillSubCategoryData.fromJson(Map<String, dynamic> json) {
    skillSubCategoryId = json['skillSubCategoryId'];
    skillSubCategoryName = json['skillSubCategoryName'];
    if (json['skillData'] != null) {
      skillData = <SkillData>[];
      json['skillData'].forEach((v) {
        skillData!.add(SkillData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skillSubCategoryId'] = skillSubCategoryId;
    data['skillSubCategoryName'] = skillSubCategoryName;
    if (skillData != null) {
      data['skillData'] = skillData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SkillData {
  int? skillId;
  String? skillName;

  SkillData({this.skillId, this.skillName});

  SkillData.fromJson(Map<String, dynamic> json) {
    skillId = json['skillId'];
    skillName = json['skillName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skillId'] = skillId;
    data['skillName'] = skillName;
    return data;
  }
}
