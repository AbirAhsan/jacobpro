import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/skill_model.dart';
import 'package:service/services/api_service/profile_api_service.dart';

import '../app_config.dart';
import '../model/technician_profile_model.dart';
import '../services/custom_eassy_loading.dart';
import '../services/error_code_handle_service.dart';
import '../services/shared_data_manage_service.dart';

class ProfileController extends GetxController {
  TextEditingController? drivingLicenseExpiryTxtCtrl = TextEditingController();
  TextEditingController? idCardExpiryTxtCtrl = TextEditingController();
  TextEditingController? technicalLicenseExpiryTxtCtrl =
      TextEditingController();
  bool isOnline = false;

  Rx<TechnicianProfileModel?> myProfileDetails = TechnicianProfileModel().obs;
  List<SkillDataModel?> myProfileSkills =
      List<SkillDataModel?>.empty(growable: true);

  TextEditingController? pFirstNameTxtCtrl = TextEditingController();
  TextEditingController? pLastNameTxtCtrl = TextEditingController();
  TextEditingController? pEmailTxtCtrl = TextEditingController();
  TextEditingController? pPhoneTxtCtrl = TextEditingController();
  TextEditingController? eFirstNameTxtCtrl = TextEditingController();
  TextEditingController? eLastNameTxtCtrl = TextEditingController();
  TextEditingController? eEmailTxtCtrl = TextEditingController();
  TextEditingController? ePhoneTxtCtrl = TextEditingController();
  List workingModeList = [
    {"id": 1, "name": "Freelance"},
    {"id": 2, "name": "Permanent"}
  ];

  String? drivingLicenseFrontImage;
  String? drivingLicenseBackImage;

  String? identificationFrontImage;
  String? identificationBackImage;

  String? technicalLicenseFrontImage;

  String? socialSecurityFrontImage;

  Future<void> fetchMyProfileDetails() async {
    try {
      CustomEassyLoading.startLoading();

      await ProfileApiService.getMyProfileDetails().then((resp) async {
        myProfileDetails.value = resp;
        await SharedDataManageService().setUserVerification(
            resp.profileGeneralData!.userVerificationStatus.toString());

        update();
        assignPersonalContact(
            myProfileDetails.value!.profileGeneralData?.userFirstName,
            myProfileDetails.value!.profileGeneralData?.userLastName,
            myProfileDetails.value!.profileGeneralData?.userMail,
            myProfileDetails.value!.profileGeneralData?.userContactNo);
        assignEmergencyContact(
            myProfileDetails
                .value!.profileEmergencyContactData?.emergencyContactFirstName,
            myProfileDetails
                .value!.profileEmergencyContactData?.emergencyContactLastName,
            myProfileDetails
                .value!.profileEmergencyContactData?.emergencyContactMail,
            myProfileDetails
                .value!.profileEmergencyContactData?.emergencyContactContactNo);

        await fetchMyProfileSkills();
        assignExpiryDate();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }

  Future<void> fetchMyProfileSkills() async {
    try {
      CustomEassyLoading.startLoading();

      await ProfileApiService.getMyProfileSkill().then((resp) async {
        myProfileSkills = resp;

        update();
        //At first set saved category  ID
        selectedSkillCategoryId =
            myProfileDetails.value!.profileSkillData?.profileSkillCategoryId;
        //2nd  Get SubCategory list based on category ID
        getSkillSubCategories(
            myProfileDetails.value!.profileSkillData!.profileSkillCategoryId!);
        //3rd  set saved Sub category  ID
        selectedSKillSubCategoryId =
            myProfileDetails.value!.profileSkillData?.profileSkillSubCategoryId;

        //4th  Get Skill list based on Sub Category category ID

        getSkills(myProfileDetails
            .value!.profileSkillData?.profileSkillSubCategoryId);
        //5th step: set Skill ids list
        setselectedSkills(
            myProfileDetails.value!.profileSkillData!.profileSkillIdList!);
        print(myProfileDetails.value!.profileSkillData!.profileSkillIdList!);

        update();
        CustomEassyLoading.stopLoading();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }

  Future<void> updateOwnProfile() async {
    try {
      CustomEassyLoading.startLoading();

      await ProfileApiService.updateOwnProfile(
          myProfileDetails.value!,
          selectedSkillList!.map((skill) => skill!.skillId!).toList(),
          otherSkillTxtCtrl.text, [
        drivingLicenseExpiryTxtCtrl?.text ?? "",
        idCardExpiryTxtCtrl?.text ?? "",
        technicalLicenseExpiryTxtCtrl?.text ?? "",
      ]).then((resp) async {
        await fetchMyProfileDetails();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }

  Future<void> uploadUserFile(String? imagePath, int? docType) async {
    try {
      CustomEassyLoading.startLoading();

      await ProfileApiService.uploadUserFile(imagePath, docType).then(
          (resp) async {
        // if (docType == 11) {
        //   drivingLicenseFrontImage = AppConfig.imageBaseUrl + resp!;
        // } else if (docType == 12) {
        //   drivingLicenseBackImage = AppConfig.imageBaseUrl + resp!;
        // } else if (docType == 13) {
        //   identificationFrontImage = AppConfig.imageBaseUrl + resp!;
        // } else if (docType == 14) {
        //   identificationBackImage = AppConfig.imageBaseUrl + resp!;
        // } else if (docType == 15) {
        //   technicalLicenseFrontImage = AppConfig.imageBaseUrl + resp!;
        // } else if (docType == 17) {
        //   socialSecurityFrontImage = AppConfig.imageBaseUrl + resp!;
        // }
        await fetchMyProfileDetails();

        update();

        CustomEassyLoading.stopLoading();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }

  assignPersonalContact(
      String? firstName, String? lastName, String? email, String? phone) {
    pFirstNameTxtCtrl!.text = firstName!;
    pLastNameTxtCtrl!.text = lastName!;
    pEmailTxtCtrl!.text = email!;
    pPhoneTxtCtrl!.text = phone!;
    update();
  }

  assignEmergencyContact(
      String? firstName, String? lastName, String? email, String? phone) {
    eFirstNameTxtCtrl!.text = firstName!;
    eLastNameTxtCtrl!.text = lastName!;
    eEmailTxtCtrl!.text = email!;
    ePhoneTxtCtrl!.text = phone!;
    update();
  }

  //Skills

  int? selectedSkillCategoryId;
  int? selectedSKillSubCategoryId;
  int? selectedSKillId;
  TextEditingController otherSkillTxtCtrl = TextEditingController();

  List<SkillSubCategoryData?>? skillSubCategories = [];
  List<SkillData?>? skills = [];
  List<SkillData?>? selectedSkillList = [];
  List<int>? selectedSkillIDList = [];

  void getSkillSubCategories(int categoryId) {
    selectedSKillSubCategoryId = null;
    selectedSKillId = null;
    skillSubCategories!.clear();
    skills!.clear();
    update();
    myProfileSkills
        .firstWhere((category) => category!.skillCategoryId == categoryId)!
        .skillSubCategoryData
        ?.forEach((subCategory) {
      skillSubCategories!.add(subCategory);
    });
    update();
  }

  void getSkills(int? subCategoryId) {
    selectedSKillId = null;
    skills!.clear();
    update();
    skillSubCategories
        ?.firstWhere(
            (subCategory) => subCategory!.skillSubCategoryId == subCategoryId)
        ?.skillData
        ?.forEach((skill) {
      skills!.add(skill);
    });

    update();
  }

  void selectSkill(int? id) {
    selectedSkillList!.add(skills!.firstWhere((skill) => skill!.skillId == id));
    selectedSkillIDList!.add(id!);
    skills!.removeWhere((skill) => skill!.skillId == id);
    if (myProfileDetails.value!.profileSkillData != null) {
      if (!myProfileDetails.value!.profileSkillData!.profileSkillIdList!
          .contains(id)) {
        myProfileDetails.value!.profileSkillData!.profileSkillIdList!.add(id);
      }
    }

    update();

    print(myProfileDetails.value!.profileSkillData?.profileSkillIdList);
  }

  void setselectedSkills(List<int?> ids) {
    selectedSkillList!.clear();

    if (selectedSKillSubCategoryId != 17) {
      //id = 17 for speciality
      selectedSKillId = ids.first;
    } else {
      for (var i = 0; i < ids.length; i++) {
        selectSkill(ids[i]);

        if (ids[i] == 30) {
          //Skill id 30 for other skill
          otherSkillTxtCtrl.text =
              myProfileDetails.value!.profileSkillData!.profileOtherSkill ?? "";
        }
      }
    }
    update();
  }

  assignExpiryDate() {
    if (myProfileDetails
            .value!.profileDocumentsWrapperData![0].profileExpiryDate !=
        null) {
      drivingLicenseExpiryTxtCtrl!.text = DateFormat('yyyy-MM-dd', "en").format(
          DateTime.parse(myProfileDetails
                  .value!.profileDocumentsWrapperData![0].profileExpiryDate ??
              ""));
    }

//
    if (myProfileDetails
            .value!.profileDocumentsWrapperData?[1].profileExpiryDate !=
        null) {
      idCardExpiryTxtCtrl!.text = DateFormat('yyyy-MM-dd', "en").format(
          DateTime.parse(myProfileDetails
                  .value!.profileDocumentsWrapperData![1].profileExpiryDate ??
              ""));
    }

//
    if (myProfileDetails
            .value!.profileDocumentsWrapperData![2].profileExpiryDate !=
        null) {
      technicalLicenseExpiryTxtCtrl!.text = DateFormat('yyyy-MM-dd', "en")
          .format(DateTime.parse(myProfileDetails
                  .value!.profileDocumentsWrapperData![2].profileExpiryDate ??
              ""));
    }

    update();
  }

  void removeSkill(int? id) {
    skills!.add(selectedSkillList!.firstWhere((skill) => skill!.skillId == id));

    selectedSkillList!.removeWhere((skill) => skill!.skillId == id);
    selectedSkillIDList!.remove(id);
    myProfileDetails.value!.profileSkillData?.profileSkillIdList?.remove(id!);
    print("Object $id");

    update();
  }
}
