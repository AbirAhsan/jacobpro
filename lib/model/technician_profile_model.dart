import '../app_config.dart';

class TechnicianProfileModel {
  ProfileGeneralData? profileGeneralData;
  ProfileEmergencyContactData? profileEmergencyContactData;
  ProfileSkillData? profileSkillData;
  ProfilePaymentMethod? profilePaymentMethod;
  List<ProfileDocumentsWrapperData>? profileDocumentsWrapperData;

  TechnicianProfileModel(
      {this.profileGeneralData,
      this.profileEmergencyContactData,
      this.profileSkillData,
      this.profilePaymentMethod,
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
    profilePaymentMethod = json['profilePaymentMethod'] != null
        ? ProfilePaymentMethod.fromJson(json['profilePaymentMethod'])
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
    if (profilePaymentMethod != null) {
      data['profilePaymentMethod'] = profilePaymentMethod!.toJson();
    }
    if (profileDocumentsWrapperData != null) {
      data['profileDocumentsWrapperData'] =
          profileDocumentsWrapperData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileGeneralData {
  int? technicianId;
  String? userFirstName;
  String? userLastName;
  String? userAddress;
  String? userContactNo;
  String? userMail;
  int? userVerificationStatus;
  int? workingMode;
  String? userImgRef;

  ProfileGeneralData(
      {this.technicianId,
      this.userFirstName,
      this.userLastName,
      this.userAddress,
      this.userContactNo,
      this.userMail,
      this.userVerificationStatus,
      this.workingMode,
      userImgRef});

  ProfileGeneralData.fromJson(Map<String, dynamic> json) {
    technicianId = json['technicianId'];
    userFirstName = json['userFirstName'];
    userLastName = json['userLastName'];
    userAddress = json['userAddress'];
    userContactNo = json['userContactNo'];
    userMail = json['userMail'];
    userVerificationStatus = json['userVerificationStatus'] ?? 0;
    workingMode = json['workingMode'];
    userImgRef = "${AppConfig.imageBaseUrl}${json['userImgRef']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['technicianId'] = technicianId;
    data['userFirstName'] = userFirstName;
    data['userLastName'] = userLastName;
    data['userAddress'] = userAddress;
    data['userContactNo'] = userContactNo;
    data['userMail'] = userMail;
    data['userVerificationStatus'] = userVerificationStatus;
    data['workingMode'] = workingMode;
    data['userImgRef'] = userImgRef;
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
  String? userYearOfExperience;
  String? userPerHourWage;

  ProfileSkillData(
      {this.profileSkillCategoryId,
      this.profileSkillSubCategoryId,
      this.profileSkillIdList,
      this.profileOtherSkill,
      this.userYearOfExperience,
      this.userPerHourWage});

  ProfileSkillData.fromJson(Map<String, dynamic> json) {
    profileSkillCategoryId = json['profileSkillCategoryId'];
    profileSkillSubCategoryId = json['profileSkillSubCategoryId'];
    profileSkillIdList = json['profileSkillIdList'].cast<int>();
    userYearOfExperience = json['userYearOfExperience'] != null
        ? json['userYearOfExperience'].toString()
        : json['userYearOfExperience'];
    userPerHourWage = json['userPerHourWage'] != null
        ? json['userPerHourWage'].toString()
        : json['userPerHourWage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profileSkillCategoryId'] = profileSkillCategoryId;
    data['profileSkillSubCategoryId'] = profileSkillSubCategoryId;
    data['profileSkillIdList'] = profileSkillIdList;
    data['profileOtherSkill'] = profileOtherSkill;
    data['userYearOfExperience'] = userYearOfExperience;
    data['userPerHourWage'] = userPerHourWage;
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

class ProfilePaymentMethod {
  String? paymentMethodName;
  String? paymentAccountNo;
  String? paymentAccountName;
  String? paymentAccountBranchName;
  String? paymentRoutingNo;

  ProfilePaymentMethod(
      {this.paymentMethodName,
      this.paymentAccountNo,
      this.paymentAccountName,
      this.paymentAccountBranchName,
      this.paymentRoutingNo});

  ProfilePaymentMethod.fromJson(Map<String, dynamic> json) {
    paymentMethodName = json['paymentMethodName'];
    paymentAccountNo = json['paymentAccountNo'];
    paymentAccountName = json['paymentAccountName'];
    paymentAccountBranchName = json['paymentAccountBranchName'];
    paymentRoutingNo = json['paymentRoutingNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentMethodName'] = paymentMethodName;
    data['paymentAccountNo'] = paymentAccountNo;
    data['paymentAccountName'] = paymentAccountName;
    data['paymentAccountBranchName'] = paymentAccountBranchName;
    data['paymentRoutingNo'] = paymentRoutingNo;
    return data;
  }
}
