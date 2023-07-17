import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service/controller/profile_controller.dart';
import 'package:service/controller/screen_controller.dart';
import 'package:service/services/validator_service.dart';

import '../../../controller/customer_controller.dart';
import '../../../services/image_picker_service.dart';
import '../../../services/page_navigation_service.dart';
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
                      CustomTextField(
                        labelText: "First Name",
                        prefixIcon: const Icon(Icons.person),
                        isRequired: true,
                        controller: profileCtrl.pFirstNameTxtCtrl,
                        keyboardType: TextInputType.name,
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
                      CustomTextField(
                        labelText: "Last Name",
                        prefixIcon: const Icon(Icons.person),
                        controller: profileCtrl.pLastNameTxtCtrl,
                        isRequired: true,
                        keyboardType: TextInputType.name,
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
                      CustomTextField(
                        labelText: "Email",
                        readOnly: true,
                        prefixIcon: const Icon(Icons.email),
                        controller: profileCtrl.pEmailTxtCtrl,
                        isRequired: true,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
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
                        readOnly: true,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
                        onChanged: (value) {
                          profileCtrl.myProfileDetails.value!
                              .profileGeneralData!.userContactNo = value;
                          profileCtrl.update();
                        },
                        validator: ValidatorService.validateMobile,
                      ),
                      GetBuilder<CustomerController>(
                          init: CustomerController(),
                          builder: (customerCtrl) {
                            return CustomTextField(
                              labelText: "Address",
                              prefixIcon:
                                  const Icon(Icons.location_on_outlined),
                              controller: profileCtrl.pAddressTxtCtrl,
                              isRequired: true,
                              minLines: 1,
                              maxLines: 3,
                              readOnly: true,
                              validator: ValidatorService.validateSimpleFiled,
                              onTap: () {
                                customerCtrl.searchTextCtrl.clear();
                                customerCtrl.suggestedAddressList.clear();
                                customerCtrl.update();
                                searchAddress();
                              },
                            );
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "EMERGENCY CONTACT",
                        style: CustomTextStyle.mediumBoldStyleDarkGrey,
                      ),
                      const Divider(),
                      CustomTextField(
                        labelText: "First Name",
                        prefixIcon: const Icon(Icons.person),
                        controller: profileCtrl.eFirstNameTxtCtrl,
                        isRequired: true,
                        keyboardType: TextInputType.name,
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
                      CustomTextField(
                        labelText: "Last Name",
                        prefixIcon: const Icon(Icons.person),
                        controller: profileCtrl.eLastNameTxtCtrl,
                        isRequired: true,
                        keyboardType: TextInputType.name,
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
                      CustomTextField(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        controller: profileCtrl.eEmailTxtCtrl,
                        isRequired: true,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
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
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
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
                          } else if (!value.isPhoneNumber) {
                            return "Phone number is not valid";
                          } else if (value.length != 10) {
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
                                      profileCtrl.updateProfileContact();

                                      //  screenCtrl.update();
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

searchAddress() {
  return showModalBottomSheet<void>(
      context: Get.context!,
      enableDrag: false,
      isDismissible: false,
      builder: (BuildContext context) {
        return GetBuilder<CustomerController>(
            init: CustomerController(),
            builder: (customerCtrl) {
              return SizedBox(
                height: Get.height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton.icon(
                            onPressed: () {
                              PageNavigationService.backScreen();
                            },
                            icon: const Icon(Icons.close),
                            label: const Text("Close")),
                      ),
                      CustomTextField(
                        labelText: "Search Address Here",
                        controller: customerCtrl.searchTextCtrl,
                        suffixIcon: IconButton(
                          onPressed: () {
                            customerCtrl.getSuggestedAddressList();
                          },
                          icon: const Icon(
                            Icons.search_sharp,
                            size: 36,
                          ),
                        ),
                        onChanged: (value) {
                          customerCtrl.debouncer.run(() {
                            customerCtrl.getSuggestedAddressList();
                            //perform search here
                          });
                        },
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            customerCtrl.suggestedAddressList.isNotEmpty
                                ? SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(10),
                                        itemCount: customerCtrl
                                            .suggestedAddressList.length,
                                        itemBuilder: (buildContext, index) {
                                          return Card(
                                            child: ListTile(
                                              title: Text(customerCtrl
                                                      .suggestedAddressList[
                                                  index]!),
                                              onTap: () {
                                                customerCtrl.searchTextCtrl
                                                    .text = customerCtrl
                                                        .suggestedAddressList[
                                                    index]!;

                                                customerCtrl
                                                    .getAddressDetails();
                                              },
                                            ),
                                          );
                                        }),
                                  )
                                : Container(),
                            customerCtrl.addressLat != null ||
                                    customerCtrl.addressLong != null
                                ? Image(
                                    image: StaticMapController(
                                    googleApiKey:
                                        "AIzaSyDfVYnKtLaoJJSFXxCQZ54U4udtIwv4ahk",
                                    width: Get.width.toInt(),
                                    height: (Get.width ~/ 2).toInt(),
                                    zoom: 8,
                                    language: "EN",
                                    visible: [
                                      // Location(
                                      //     double.parse(topicDetails
                                      //             .locationLat!.isNotEmpty
                                      //         ? topicDetails.locationLat!
                                      //         : "0.0"),
                                      //     double.parse(topicDetails
                                      //             .locationLong!.isNotEmpty
                                      //         ? topicDetails.locationLong!
                                      //         : "0.0")),
                                    ],
                                    // maptype: StaticMapType.satellite,
                                    markers: [
                                      Marker(locations: [
                                        Location(
                                          customerCtrl.addressLat ?? 0.0,
                                          customerCtrl.addressLong ?? 0.0,
                                        )
                                      ]),
                                    ],
                                    scale: MapScale.scale1,
                                    center: Location(
                                      customerCtrl.addressLat ?? 0.0,
                                      customerCtrl.addressLong ?? 0.0,
                                    ),
                                  ).image)
                                : Container(),
                            Align(
                              alignment: Alignment.topRight,
                              child: GetBuilder<ProfileController>(
                                  init: ProfileController(),
                                  builder: (profileCtrl) {
                                    return CustomCompanyButton(
                                        fizedSize: Size(100, 50),
                                        buttonName: "Confirm",
                                        onPressed: () {
                                          profileCtrl.pAddressTxtCtrl!.text =
                                              customerCtrl.searchTextCtrl.text;
                                          profileCtrl
                                                  .myProfileDetails
                                                  .value!
                                                  .profileGeneralData!
                                                  .userAddress =
                                              customerCtrl.searchTextCtrl.text;
                                          profileCtrl.update();
                                          PageNavigationService.backScreen();
                                        });
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      });
}
