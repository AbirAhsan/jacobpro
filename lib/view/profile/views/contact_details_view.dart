import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service/controller/profile_controller.dart';
import 'package:service/controller/screen_controller.dart';
import 'package:service/services/validator_service.dart';

import '../../../services/image_picker_service.dart';
import '../../variables/text_style.dart';
import '../../widgets/custom_company_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/profile_Image_widget.dart';

class ContactDetailsView extends StatelessWidget {
  const ContactDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        initState: (state) {
          Get.put(ProfileController()).fetchMyProfileDetails();
        },
        builder: (profileCtrl) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: profileCtrl.profileContactFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: ProfileImageWidget(
                            imageUrl: profileCtrl.myProfileDetails.value!
                                    .profileGeneralData?.userImgRef ??
                                "",
                            radius: 36,
                            isEditable: true,
                            onEdit: () async {
                              await ImagePickService()
                                  .getSingleImage(ImageSource.gallery)
                                  .then((imagePath) {
                                profileCtrl.uploadUserFile(imagePath, 100);
                              });
                            },
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "PERSONAL CONTACT",
                        style: CustomTextStyle.mediumBoldStyleDarkGrey,
                      ),
                      const Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              labelText: "First Name",
                              prefixIcon: const Icon(Icons.person),
                              isRequired: true,
                              controller: profileCtrl.pFirstNameTxtCtrl,
                              onChanged: (value) {
                                profileCtrl.myProfileDetails.value!
                                    .profileGeneralData!.userFirstName = value;
                                profileCtrl.update();
                              },
                              validator: (value) {
                                final RegExp nameRegExp = RegExp('[a-zA-Z]');
                                if (value!.isEmpty) {
                                  return "Enter your first name";
                                } else if (!nameRegExp.hasMatch(value)) {
                                  return 'Enter a Valid Name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomTextField(
                              labelText: "Last Name",
                              prefixIcon: const Icon(Icons.person),
                              controller: profileCtrl.pLastNameTxtCtrl,
                              isRequired: true,
                              onChanged: (value) {
                                profileCtrl.myProfileDetails.value!
                                    .profileGeneralData!.userLastName = value;
                                profileCtrl.update();
                              },
                              validator: (value) {
                                final RegExp nameRegExp = RegExp('[a-zA-Z]');
                                if (value!.isEmpty) {
                                  return "Enter your last name";
                                } else if (!nameRegExp.hasMatch(value)) {
                                  return 'Enter a Valid Name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        controller: profileCtrl.pEmailTxtCtrl,
                        isRequired: true,
                        onChanged: (value) {
                          profileCtrl.myProfileDetails.value!
                              .profileGeneralData!.userMail = value;
                          profileCtrl.update();
                        },
                        validator: ValidatorService.validateEmail,
                      ),
                      CustomTextField(
                        labelText: "Phone",
                        prefixIcon: const Icon(Icons.call),
                        controller: profileCtrl.pPhoneTxtCtrl,
                        isRequired: true,
                        onChanged: (value) {
                          profileCtrl.myProfileDetails.value!
                              .profileGeneralData!.userContactNo = value;
                          profileCtrl.update();
                        },
                        validator: ValidatorService.validateMobile,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "EMERGENCY CONTACT",
                        style: CustomTextStyle.mediumBoldStyleDarkGrey,
                      ),
                      const Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              labelText: "First Name",
                              prefixIcon: const Icon(Icons.person),
                              controller: profileCtrl.eFirstNameTxtCtrl,
                              isRequired: true,
                              onChanged: (value) {
                                profileCtrl
                                    .myProfileDetails
                                    .value!
                                    .profileEmergencyContactData!
                                    .emergencyContactFirstName = value;
                                profileCtrl.update();
                              },
                              validator: (value) {
                                final RegExp nameRegExp = RegExp('[a-zA-Z]');
                                if (value!.isEmpty) {
                                  return "Enter your emergency first name";
                                } else if (!nameRegExp.hasMatch(value)) {
                                  return 'Enter a Valid Name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomTextField(
                              labelText: "Last Name",
                              prefixIcon: const Icon(Icons.person),
                              controller: profileCtrl.eLastNameTxtCtrl,
                              isRequired: true,
                              onChanged: (value) {
                                profileCtrl
                                    .myProfileDetails
                                    .value!
                                    .profileEmergencyContactData!
                                    .emergencyContactLastName = value;
                                profileCtrl.update();
                              },
                              validator: (value) {
                                final RegExp nameRegExp = RegExp('[a-zA-Z]');
                                if (value!.isEmpty) {
                                  return "Enter your emergency last name";
                                } else if (!nameRegExp.hasMatch(value)) {
                                  return 'Enter a Valid Name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        controller: profileCtrl.eEmailTxtCtrl,
                        isRequired: true,
                        onChanged: (value) {
                          profileCtrl
                              .myProfileDetails
                              .value!
                              .profileEmergencyContactData!
                              .emergencyContactMail = value;
                          profileCtrl.update();
                        },
                        validator: (String? value) {
                          String? pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = RegExp(pattern);
                          if (value!.isEmpty) {
                            return "Enter your emergency email address";
                          } else if (!regex.hasMatch(value)) {
                            return "Emergency email address is not valid";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        labelText: "Phone",
                        prefixIcon: const Icon(Icons.call),
                        controller: profileCtrl.ePhoneTxtCtrl,
                        isRequired: true,
                        onChanged: (value) {
                          profileCtrl
                              .myProfileDetails
                              .value!
                              .profileEmergencyContactData!
                              .emergencyContactContactNo = value;
                          profileCtrl.update();
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Enter you emergency phone number";
                          } else if (value.length != 11) {
                            return "Emergency phone number is not valid";
                          }
                          return null;
                        },
                      ),
                      GetBuilder<ScreenController>(
                          init: ScreenController(),
                          builder: (screenCtrl) {
                            return Align(
                                alignment: Alignment.bottomRight,
                                child: CustomCompanyButton(
                                    buttonName: "PROCEED",
                                    //  textStyle: CustomTextStyle.mediumBoldStylePrimary,
                                    isFitted: true,
                                    onPressed: () async {
                                      await profileCtrl.updateProfileContact();
                                      //  screenCtrl.changeProfileTabbar(1);
                                    }));
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
