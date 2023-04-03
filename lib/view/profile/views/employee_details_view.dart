import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/technician_profile_model.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../../controller/profile_controller.dart';
import '../../../controller/screen_controller.dart';
import '../../widgets/custom_company_button.dart';
import '../../widgets/custom_dropdown.dart';

class EmployeeDetailsView extends StatelessWidget {
  const EmployeeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        initState: (state) {
          Get.put(ProfileController()).fetchMyProfileSkills();
        },
        builder: (profileCtrl) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  CustomDropDown(
                      label: "Category",
                      value: profileCtrl.selectedSkillCategoryId,
                      items: profileCtrl.myProfileSkills.map((category) {
                        return DropdownMenuItem<int?>(
                            value: category!.skillCategoryId,
                            child: Text(category.skillCategoryName.toString()));
                      }).toList(),
                      onChanged: (value) async {
                        profileCtrl.selectedSkillCategoryId = value;
                        profileCtrl.getSkillSubCategories(value);

                        profileCtrl.update();
                      }),
                  CustomDropDown(
                      label: "Sub Category",
                      value: profileCtrl.selectedSKillSubCategoryId,
                      items: profileCtrl.skillSubCategories?.map((subCategory) {
                            return DropdownMenuItem<int?>(
                                value: subCategory!.skillSubCategoryId,
                                child: Text(subCategory.skillSubCategoryName!));
                          }).toList() ??
                          [],
                      onChanged: (value) async {
                        profileCtrl.selectedSKillSubCategoryId = value;
                        profileCtrl.myProfileDetails.value!.profileSkillData!
                            .profileSkillIdList!
                            .clear();
                        profileCtrl.getSkills(value);

                        profileCtrl.update();
                        print(value);
                      }),
                  profileCtrl.selectedSKillSubCategoryId != 17 // For Speciality
                      ? CustomDropDown(
                          label: "Skill",
                          value: profileCtrl.selectedSKillId,
                          items: profileCtrl.skills?.map((skill) {
                                return DropdownMenuItem<int?>(
                                    value: skill!.skillId,
                                    child: Text(skill.skillName!));
                              }).toList() ??
                              [],
                          onChanged: (value) async {
                            profileCtrl.selectedSKillId = value;
                            profileCtrl.myProfileDetails.value!
                                .profileSkillData!.profileSkillIdList!
                                .add(value);
                            profileCtrl.update();
                          })
                      : Container(
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: CustomColors.primary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          constraints: const BoxConstraints(
                              minHeight: 50,
                              maxHeight: double.infinity,
                              minWidth: double.infinity),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: profileCtrl.selectedSkillList
                                    ?.map((skill) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Chip(
                                      label: Text(
                                        skill!.skillName!,
                                      ),
                                      labelStyle:
                                          CustomTextStyle.normalBoldStyleWhite,
                                      backgroundColor: CustomColors.primary,
                                      deleteIconColor: CustomColors.white,
                                      onDeleted: () {
                                        profileCtrl.removeSkill(skill.skillId);
                                      },
                                    ),
                                  );
                                }).toList() ??
                                [],
                          ),
                        ),
                  profileCtrl.selectedSKillSubCategoryId == 17
                      ? Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: profileCtrl.skills?.map((skill) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Chip(
                                        label: Text(skill!.skillName!),
                                        labelStyle: CustomTextStyle
                                            .normalBoldStyleBlack,
                                        deleteIconColor: CustomColors.primary,
                                        deleteIcon: const Icon(Icons.add),
                                        onDeleted: () {
                                          profileCtrl
                                              .selectSkill(skill.skillId);
                                        }),
                                  );
                                }).toList() ??
                                [],
                          ),
                        )
                      : Container(),
                  profileCtrl.selectedSkillList!.any((skill) =>
                          skill!.skillId == 30) //Skill id 30 for other skill
                      ? CustomTextField(
                          marginRight: 20,
                          marginLeft: 20,
                          controller: profileCtrl.otherSkillTxtCtrl,
                          labelText: "Others",
                          // onChanged: (value) {
                          //   profileCtrl.update();
                          // },
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: const Text(
                              "Working Mode",
                              style: CustomTextStyle.normalBoldStyleDarkGrey,
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              children: profileCtrl.workingModeList
                                  .map((workingMode) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio(
                                      value: profileCtrl.myProfileDetails.value
                                          ?.profileGeneralData?.workingMode,
                                      groupValue: workingMode['id'],
                                      onChanged: (value) {
                                        profileCtrl
                                            .myProfileDetails
                                            .value
                                            ?.profileGeneralData
                                            ?.workingMode = workingMode['id'];

                                        profileCtrl.update();
                                      },
                                    ),
                                    Text(workingMode['name']),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: GetBuilder<ScreenController>(
                          init: ScreenController(),
                          builder: (screenCtrl) {
                            return CustomCompanyButton(
                                buttonName: "PROCEED",
                                //  textStyle: CustomTextStyle.mediumBoldStylePrimary,
                                isFitted: true,
                                onPressed: () async {
                                  await profileCtrl.updateOwnProfile();
                                  screenCtrl.changeProfileTabbar(2);
                                });
                          })),
                ],
              ),
            ),
          );
        });
  }
}
