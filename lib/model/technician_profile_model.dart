import '../app_config.dart';

class TechnicianProfileModel {
  ProfileGeneralData? profileGeneralData;
  ProfileEmergencyContactData? profileEmergencyContactData;
  ProfileSkillData? profileSkillData;
  List<ProfileDocumentsWrapperData>? profileDocumentsWrapperData;

  TechnicianProfileModel(
      {this.profileGeneralData,
      this.profileEmergencyContactData,
      this.profileSkillData,
      this.profileDocumentsWrapperData});

  TechnicianProfileModel.fromJson(Map<String, dynamic> json) {
    profileGeneralData = json['profileGeneralData'] != null
        ? ProfileGeneralData.fromJson(json['profileGeneralData'])
        : null;
    profileEmergencyContactData = json['profileEmergencyContactData'] != null
        ? ProfileEmergencyContactData.fromJson(
            json['profileEmergencyContactData'])
        : null;
    profileSkillData = json['profileSkillData'] != null
        ? ProfileSkillData.fromJson(json['profileSkillData'])
        : null;
    if (json['profileDocumentsWrapperData'] != null) {
      profileDocumentsWrapperData = <ProfileDocumentsWrapperData>[];
      json['profileDocumentsWrapperData'].forEach((v) {
        profileDocumentsWrapperData!
            .add(ProfileDocumentsWrapperData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileGeneralData != null) {
      data['profileGeneralData'] = profileGeneralData!.toJson();
    }
    if (profileEmergencyContactData != null) {
      data['profileEmergencyContactData'] =
          profileEmergencyContactData!.toJson();
    }
    if (profileSkillData != null) {
      data['profileSkillData'] = profileSkillData!.toJson();
    }
    if (profileDocumentsWrapperData != null) {
      data['profileDocumentsWrapperData'] =
          profileDocumentsWrapperData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileGeneralData {
  int? userSystemId;
  String? userFirstName;
  String? userLastName;
  String? userAddress;
  String? userContactNo;
  String? userMail;
  int? workingMode;

  ProfileGeneralData(
      {this.userSystemId,
      this.userFirstName,
      this.userLastName,
      this.userAddress,
      this.userContactNo,
      this.userMail,
      this.workingMode});

  ProfileGeneralData.fromJson(Map<String, dynamic> json) {
    userSystemId = json['userSystemId'];
    userFirstName = json['userFirstName'];
    userLastName = json['userLastName'];
    userAddress = json['userAddress'];
    userContactNo = json['userContactNo'];
    userMail = json['userMail'];
    workingMode = json['workingMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userSystemId'] = userSystemId;
    data['userFirstName'] = userFirstName;
    data['userLastName'] = userLastName;
    data['userAddress'] = userAddress;
    data['userContactNo'] = userContactNo;
    data['userMail'] = userMail;
    data['workingMode'] = workingMode;
    return data;
  }
}

class ProfileEmergencyContactData {
  String? emergencyContactFirstName;
  String? emergencyContactLastName;
  String? emergencyContactContactNo;
  String? emergencyContactMail;

  ProfileEmergencyContactData(
      {this.emergencyContactFirstName,
      this.emergencyContactLastName,
      this.emergencyContactContactNo,
      this.emergencyContactMail});

  ProfileEmergencyContactData.fromJson(Map<String, dynamic> json) {
    emergencyContactFirstName = json['emergencyContactFirstName'];
    emergencyContactLastName = json['emergencyContactLastName'];
    emergencyContactContactNo = json['emergencyContactContactNo'];
    emergencyContactMail = json['emergencyContactMail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emergencyContactFirstName'] = emergencyContactFirstName;
    data['emergencyContactLastName'] = emergencyContactLastName;
    data['emergencyContactContactNo'] = emergencyContactContactNo;
    data['emergencyContactMail'] = emergencyContactMail;
    return data;
  }
}

class ProfileSkillData {
  int? profileSkillCategoryId;
  int? profileSkillSubCategoryId;
  List<int>? profileSkillIdList;
  String? profileOtherSkill;

  ProfileSkillData(
      {this.profileSkillCategoryId,
      this.profileSkillSubCategoryId,
      this.profileSkillIdList,
      this.profileOtherSkill});

  ProfileSkillData.fromJson(Map<String, dynamic> json) {
    profileSkillCategoryId = json['profileSkillCategoryId'];
    profileSkillSubCategoryId = json['profileSkillSubCategoryId'];
    profileSkillIdList = json['profileSkillIdList'].cast<int>();
    profileOtherSkill = json['profileOtherSkill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profileSkillCategoryId'] = profileSkillCategoryId;
    data['profileSkillSubCategoryId'] = profileSkillSubCategoryId;
    data['profileSkillIdList'] = profileSkillIdList;
    data['profileOtherSkill'] = profileOtherSkill;
    return data;
  }
}

class ProfileDocumentsWrapperData {
  List<ProfileDocumentsData>? profileDocumentsData;
  String? profileExpiryDate;

  ProfileDocumentsWrapperData(
      {this.profileDocumentsData, this.profileExpiryDate});

  ProfileDocumentsWrapperData.fromJson(Map<String, dynamic> json) {
    if (json['profileDocumentsData'] != null) {
      profileDocumentsData = <ProfileDocumentsData>[];
      json['profileDocumentsData'].forEach((v) {
        profileDocumentsData!.add(ProfileDocumentsData.fromJson(v));
      });
    }
    profileExpiryDate = json['profileExpiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileDocumentsData != null) {
      data['profileDocumentsData'] =
          profileDocumentsData!.map((v) => v.toJson()).toList();
    }
    data['profileExpiryDate'] = profileExpiryDate;
    return data;
  }
}

class ProfileDocumentsData {
  String? profileDocumentURL;
  int? profileDocumentTypeId;

  ProfileDocumentsData({this.profileDocumentURL, this.profileDocumentTypeId});

  ProfileDocumentsData.fromJson(Map<String, dynamic> json) {
    profileDocumentURL =
        "${AppConfig.imageBaseUrl}${json['profileDocumentURL']}";
    profileDocumentTypeId = json['profileDocumentTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profileDocumentURL'] = profileDocumentURL;
    data['profileDocumentTypeId'] = profileDocumentTypeId;
    return data;
  }
}
