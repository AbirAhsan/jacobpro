import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:service/controller/customer_controller.dart';
import 'package:service/services/validator_service.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_company_button.dart';
import 'package:service/view/widgets/custom_submit_button.dart';

import '../../generated/locale_keys.g.dart';
import '../../services/page_navigation_service.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_text_field.dart';

class AddNewCustomerScreen extends StatelessWidget {
  const AddNewCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
        init: CustomerController(),
        builder: (customerCtrl) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Form(
              key: customerCtrl.addCustomerFormKey,
              child: Scaffold(
                appBar: const CustomAppBar(
                  title: "Add New Customer",
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Info",
                          style: CustomTextStyle.mediumBoldStyleDarkGrey,
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                                child: CustomTextField(
                              labelText: "First Name",
                              controller: customerCtrl.customerFirstNameCtrl,
                              keyboardType: TextInputType.name,
                              prefixIcon: const Icon(Icons.person),
                              // validator: ValidatorService.validateSimpleFiled,
                              onChanged: (value) {
                                customerCtrl.customerPrefferedNameCtrl.text =
                                    "$value ${customerCtrl.customerLastNameCtrl.text}";
                              },
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: CustomTextField(
                              labelText: "Last Name",
                              controller: customerCtrl.customerLastNameCtrl,
                              prefixIcon: const Icon(Icons.person),
                              keyboardType: TextInputType.name,
                              //   validator: ValidatorService.validateSimpleFiled,
                              onChanged: (value) {
                                customerCtrl.customerPrefferedNameCtrl.text =
                                    "${customerCtrl.customerFirstNameCtrl.text} $value";
                              },
                            )),
                          ],
                        ),
                        CustomTextField(
                          labelText: "Display Name",
                          controller: customerCtrl.customerPrefferedNameCtrl,
                          prefixIcon: const Icon(Icons.person),
                          keyboardType: TextInputType.name,
                          validator: ValidatorService.validateSimpleFiled,
                        ),
                        CustomTextField(
                          labelText: "Email",
                          controller: customerCtrl.customerEmailCtrl,
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: ValidatorService.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CustomTextField(
                          labelText: "Phone",
                          controller: customerCtrl.customerMobileCtrl,
                          keyboardType: TextInputType.phone,
                          prefixIcon: const Icon(Icons.call),
                          validator: (phone) {
                            if (phone!.isEmpty) {
                              return LocaleKeys.auth_phoneNumberRule1.tr();
                            } else if (!phone.isPhoneNumber) {
                              return LocaleKeys.auth_phoneNumberRule2.tr();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Location Info",
                          style: CustomTextStyle.mediumBoldStyleDarkGrey,
                        ),
                        const Divider(),
                        CustomTextField(
                          labelText: "Address",
                          readOnly: true,
                          controller: customerCtrl.customerAddressCtrl,
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          keyboardType: TextInputType.streetAddress,
                          validator: ValidatorService.validateSimpleFiled,
                          onTap: () {
                            customerCtrl.searchTextCtrl.clear();
                            customerCtrl.suggestedAddressList.clear();
                            customerCtrl.update();
                            searchAddress();
                          },
                        ),
                        CustomTextField(
                          labelText: "State",
                          controller: customerCtrl.customerStateCtrl,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(Icons.add_location_outlined),
                          readOnly: true,
                          onTap: () {
                            customerCtrl.searchTextCtrl.clear();
                            customerCtrl.suggestedAddressList.clear();
                            customerCtrl.update();
                            searchAddress();
                          },
                        ),
                        CustomTextField(
                          labelText: "City",
                          controller: customerCtrl.customerCityCtrl,
                          prefixIcon: const Icon(Icons.location_city),
                          keyboardType: TextInputType.name,
                          validator: ValidatorService.validateSimpleFiled,
                          readOnly: true,
                          onTap: () {
                            customerCtrl.searchTextCtrl.clear();
                            customerCtrl.suggestedAddressList.clear();
                            customerCtrl.update();
                            searchAddress();
                          },
                        ),
                        CustomTextField(
                          labelText: "Country",
                          controller: customerCtrl.customerCountryCtrl,
                          prefixIcon: const Icon(Icons.location_searching),
                          keyboardType: TextInputType.name,
                          validator: ValidatorService.validateSimpleFiled,
                          readOnly: true,
                          onTap: () {
                            customerCtrl.searchTextCtrl.clear();
                            customerCtrl.suggestedAddressList.clear();
                            customerCtrl.update();
                            searchAddress();
                          },
                        ),
                        CustomTextField(
                          labelText: "Post code",
                          controller: customerCtrl.customerPostCodeCtrl,
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(Icons.local_post_office_sharp),
                          validator: ValidatorService.validateSimpleFiled,
                          readOnly: true,
                          onTap: () {
                            customerCtrl.searchTextCtrl.clear();
                            customerCtrl.suggestedAddressList.clear();
                            customerCtrl.update();
                            searchAddress();
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Customer notes",
                          style: CustomTextStyle.mediumBoldStyleDarkGrey,
                        ),
                        const Divider(),
                        CustomTextField(
                          labelText: "Notes",
                          controller: customerCtrl.customerNoteCtrl,
                          prefixIcon: const Icon(Icons.note_add_rounded),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CustomSubmitButton(
                                    primaryColor: CustomColors.grey,
                                    buttonName: "CANCEL",
                                    onPressed: () {})),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: CustomSubmitButton(
                                    buttonName: "SAVE",
                                    onPressed: () =>
                                        customerCtrl.addNewCustomer())),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  //<================================= Search Player For add team
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
                              child: CustomCompanyButton(
                                  fizedSize: Size(100, 50),
                                  buttonName: "Confirm",
                                  onPressed: () {
                                    PageNavigationService.backScreen();
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
