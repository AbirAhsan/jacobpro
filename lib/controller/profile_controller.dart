import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/screen_controller.dart';
import 'package:service/model/skill_model.dart';
import 'package:service/services/api_service/profile_api_service.dart';

import '../model/technician_profile_model.dart';
import '../services/custom_dialog_class.dart';
import '../services/custom_eassy_loading.dart';
import '../services/error_code_handle_service.dart';
import '../services/page_navigation_service.dart';
import '../services/shared_data_manage_service.dart';
import '../services/validator_service.dart';

class ProfileController extends GetxController {
  GlobalKey<FormState> profileContactFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> profileSkillFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> profileBankFormKey = GlobalKey<FormState>();
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

  ///
  TextEditingController? userYearOfExperienceTxtCtrl = TextEditingController();
  TextEditingController? userPerHourWageTxtCtrl = TextEditingController();

  ///
  TextEditingController? bankNameTxtCtrl = TextEditingController();
  TextEditingController? branchNameTxtCtrl = TextEditingController();
  TextEditingController? accountNumberTxtCtrl = TextEditingController();
  TextEditingController? routingNumberTxtCtrl = TextEditingController();
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
        await fetchMyProfileSkills();
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
        userYearOfExperienceTxtCtrl!.text =
            myProfileDetails.value!.profileSkillData!.userYearOfExperience ??
                "";
        userPerHourWageTxtCtrl!.text =
            myProfileDetails.value!.profileSkillData!.userPerHourWage ?? "";
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

  Future<void> updateProfileContact() async {
    if (ValidatorService().validateAndSave(profileContactFormKey)) {
      try {
        CustomEassyLoading.startLoading();
        FocusManager.instance.primaryFocus?.unfocus();
        Get.put(ScreenController()).changeProfileTabbar(1);
        await ProfileApiService.updateOwnProfile(
          myProfileDetails.value!,
          selectedSkillList != null
              ? selectedSkillList!.map((skill) => skill!.skillId!).toList()
              : myProfileDetails.value!.profileSkillData?.profileSkillIdList,
          otherSkillTxtCtrl.text,
          [
            drivingLicenseExpiryTxtCtrl?.text ?? "",
            idCardExpiryTxtCtrl?.text ?? "",
            technicalLicenseExpiryTxtCtrl?.text ?? "",
          ],
          userYearOfExperienceTxtCtrl!.text,
          userPerHourWageTxtCtrl!.text,
        ).then((resp) async {
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
  }

  Future<void> updateProfileBankDetails() async {
    if (ValidatorService().validateAndSave(profileBankFormKey)) {
      CustomEassyLoading.startLoading();
      FocusManager.instance.primaryFocus?.unfocus();
      Get.put(ScreenController()).changeProfileTabbar(3);

      try {
        CustomEassyLoading.startLoading();
        FocusManager.instance.primaryFocus?.unfocus();
        Get.put(ScreenController()).changeProfileTabbar(3);
        await ProfileApiService.updateOwnProfile(
          myProfileDetails.value!,
          selectedSkillList != null
              ? selectedSkillList!.map((skill) => skill!.skillId!).toList()
              : myProfileDetails.value!.profileSkillData?.profileSkillIdList,
          otherSkillTxtCtrl.text,
          [
            drivingLicenseExpiryTxtCtrl?.text ?? "",
            idCardExpiryTxtCtrl?.text ?? "",
            technicalLicenseExpiryTxtCtrl?.text ?? "",
          ],
          userYearOfExperienceTxtCtrl!.text,
          userPerHourWageTxtCtrl!.text,
        ).then((resp) async {
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
  }

  Future<void> updateProfileSkill() async {
    if (ValidatorService().validateAndSave(profileSkillFormKey)) {
      if (selectedSkillList!.isEmpty) {
        ApiErrorHandleService.handleStatusCodeError(
            {"code": 405, "message": 'Select a skill'});
      } else if (myProfileDetails.value?.profileGeneralData?.workingMode ==
          null) {
        ApiErrorHandleService.handleStatusCodeError(
            {"code": 405, "message": 'Select your woking mode'});
      } else {
        try {
          CustomEassyLoading.startLoading();
          FocusManager.instance.primaryFocus?.unfocus();
          Get.put(ScreenController()).changeProfileTabbar(2);
          await ProfileApiService.updateOwnProfile(
            myProfileDetails.value!,
            selectedSkillList != null
                ? selectedSkillList!.map((skill) => skill!.skillId!).toList()
                : myProfileDetails.value!.profileSkillData?.profileSkillIdList,
            otherSkillTxtCtrl.text,
            [
              drivingLicenseExpiryTxtCtrl?.text ?? "",
              idCardExpiryTxtCtrl?.text ?? "",
              technicalLicenseExpiryTxtCtrl?.text ?? "",
            ],
            userYearOfExperienceTxtCtrl!.text,
            userPerHourWageTxtCtrl!.text,
          ).then((resp) async {
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
    }
  }

  Future<void> updateOwnProfile() async {
    if (myProfileDetails.value!.profileGeneralData!.userFirstName!.isEmpty ||
        myProfileDetails.value!.profileGeneralData!.userFirstName!.length < 3) {
      Get.put(ScreenController()).changeProfileTabbar(0);
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Enter your first name'
      }); //Personal contact First name warning
    } else if (myProfileDetails.value!.profileGeneralData!.userLastName!.isEmpty ||
        myProfileDetails.value!.profileGeneralData!.userLastName!.length < 3) {
      Get.put(ScreenController()).changeProfileTabbar(0);
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Enter your last name'
      }); //Personal contact Last name warning
    } else if (!myProfileDetails.value!.profileGeneralData!.userMail!.isEmail) {
      Get.put(ScreenController()).changeProfileTabbar(0);
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Enter your email'
      }); //Personal contact email warning
    } else if (!myProfileDetails
        .value!.profileGeneralData!.userContactNo!.isPhoneNumber) {
      Get.put(ScreenController()).changeProfileTabbar(0);
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Enter your phone number'
      }); //Personal contact phone number warning
    } else if (myProfileDetails.value!.profileEmergencyContactData!.emergencyContactFirstName!.isEmpty ||
        myProfileDetails.value!.profileEmergencyContactData!.emergencyContactFirstName!.length <
            3) {
      Get.put(ScreenController()).changeProfileTabbar(0);
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Enter emergency first name'
      }); //Emergency contact first name warning
    } else if (myProfileDetails.value!.profileEmergencyContactData!.emergencyContactLastName!.isEmpty ||
        myProfileDetails.value!.profileEmergencyContactData!.emergencyContactLastName!.length <
            3) {
      Get.put(ScreenController()).changeProfileTabbar(0);
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Enter emergency last name'
      }); //Emergency contact Last name warning
    } else if (!myProfileDetails
        .value!.profileEmergencyContactData!.emergencyContactMail!.isEmail) {
      Get.put(ScreenController()).changeProfileTabbar(0);
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Enter emergency email'
      }); //Emergency contact email warning
    } else if (!myProfileDetails.value!.profileEmergencyContactData!
        .emergencyContactContactNo!.isPhoneNumber) {
      Get.put(ScreenController()).changeProfileTabbar(0);
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Enter emergency phone number'
      }); //Emergency contact phone number warning
    } else if (selectedSkillCategoryId == null) {
      Get.put(ScreenController()).changeProfileTabbar(1);
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Select a skill category'
      }); //Skill category warning
    } else if (selectedSKillSubCategoryId == null) {
      Get.put(ScreenController()).changeProfileTabbar(1);
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Select a skill sub-category'
      }); //Skill sub-category warning
    } else if (myProfileDetails
        .value!.profileSkillData!.profileSkillIdList!.isEmpty) {
      Get.put(ScreenController()).changeProfileTabbar(1);
      ApiErrorHandleService.handleStatusCodeError(
          {"code": 405, "message": 'Select a skill'}); //Skill  warning
    } else if (myProfileDetails.value?.profileGeneralData?.workingMode ==
        null) {
      Get.put(ScreenController()).changeProfileTabbar(1);
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Select your woking mode'
      }); //Working mode warning
    } else if (drivingLicenseExpiryTxtCtrl!.text == "" ||
        !myProfileDetails.value!.profileDocumentsWrapperData![0].profileDocumentsData!
            .any((doc) => doc.profileDocumentTypeId == 11) ||
        !myProfileDetails.value!.profileDocumentsWrapperData![0].profileDocumentsData!
            .any((doc) => doc.profileDocumentTypeId == 12)) {
      ApiErrorHandleService.handleStatusCodeError(
          {"code": 405, "message": 'Provide your driving license details'});
    } else if (technicalLicenseExpiryTxtCtrl!.text == "" ||
        !myProfileDetails.value!.profileDocumentsWrapperData![2].profileDocumentsData!
            .any((doc) => doc.profileDocumentTypeId == 15)) {
      ApiErrorHandleService.handleStatusCodeError(
          {"code": 405, "message": 'Provide your technician license details'});
    } else if (!myProfileDetails.value!.profileDocumentsWrapperData![3].profileDocumentsData!
        .any((doc) => doc.profileDocumentTypeId == 17)) {
      ApiErrorHandleService.handleStatusCodeError({
        "code": 405,
        "message": 'Provide your social security card details'
      });
    } else {
      try {
        CustomEassyLoading.startLoading();
        FocusManager.instance.primaryFocus?.unfocus();
        await ProfileApiService.updateOwnProfile(
          myProfileDetails.value!,
          selectedSkillList != null
              ? selectedSkillList!.map((skill) => skill!.skillId!).toList()
              : myProfileDetails.value!.profileSkillData?.profileSkillIdList,
          otherSkillTxtCtrl.text,
          [
            drivingLicenseExpiryTxtCtrl?.text ?? "",
            idCardExpiryTxtCtrl?.text ?? "",
            technicalLicenseExpiryTxtCtrl?.text ?? "",
          ],
          userYearOfExperienceTxtCtrl!.text,
          userPerHourWageTxtCtrl!.text,
        ).then((resp) async {
          await fetchMyProfileDetails();
          CustomDialogShow.showSuccessDialog(
              title: "Submitted For Verification!",
              description:
                  "You've successfully submitted your profile info. You'll get notified once the admin approve/decline your request",
              okayButtonName: "DONE",
              btnOkOnPress: () {
                PageNavigationService.backScreen();
              });
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

  assignBankDetails(String? bankName, String? branchName, String? accountNumber,
      String? routingNumber) {
    bankNameTxtCtrl!.text = bankName ?? "";
    branchNameTxtCtrl!.text = branchName ?? "";
    accountNumberTxtCtrl!.text = accountNumber ?? "";
    routingNumberTxtCtrl!.text = routingNumber ?? "";
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
