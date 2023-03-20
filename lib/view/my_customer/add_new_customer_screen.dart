import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service/controller/customer_controller.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
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
                              controller: customerCtrl.customerLastNameCtrl,
                              keyboardType: TextInputType.name,
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: CustomTextField(
                              labelText: "Last Name",
                              controller: customerCtrl.customerLastNameCtrl,
                              keyboardType: TextInputType.name,
                            )),
                          ],
                        ),
                        CustomTextField(
                          labelText: "Email",
                          controller: customerCtrl.customerEmailCtrl,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CustomTextField(
                          labelText: "Phone",
                          controller: customerCtrl.customerMobileCtrl,
                          keyboardType: TextInputType.phone,
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
                          height: 30,
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
                          keyboardType: TextInputType.streetAddress,
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
                          readOnly: false,
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
                          keyboardType: TextInputType.name,
                          readOnly: false,
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
                          keyboardType: TextInputType.name,
                          readOnly: false,
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
                          readOnly: false,
                          onTap: () {
                            customerCtrl.searchTextCtrl.clear();
                            customerCtrl.suggestedAddressList.clear();
                            customerCtrl.update();
                            searchAddress();
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Customer notes",
                          style: CustomTextStyle.mediumBoldStyleDarkGrey,
                        ),
                        const Divider(),
                        CustomTextField(
                          labelText: "Notes",
                          controller: customerCtrl.customerNoteCtrl,
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
                                    buttonName: "SAVE", onPressed: () {})),
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
                height: Get.height / 2,
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
                        child: ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: customerCtrl.suggestedAddressList.length,
                            itemBuilder: (buildContext, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(customerCtrl
                                      .suggestedAddressList[index]!),
                                  onTap: () {
                                    customerCtrl.searchTextCtrl.text =
                                        customerCtrl
                                            .suggestedAddressList[index]!;

                                    customerCtrl.getAddressDetails();
                                  },
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              );
            });
      });
}
