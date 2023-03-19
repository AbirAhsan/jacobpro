import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service/controller/customer_controller.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_submit_button.dart';

import '../../generated/locale_keys.g.dart';
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
                          controller: customerCtrl.customerAddressCtrl,
                          keyboardType: TextInputType.streetAddress,
                        ),
                        CustomTextField(
                          labelText: "State",
                          controller: customerCtrl.customerStateCtrl,
                          keyboardType: TextInputType.name,
                        ),
                        CustomTextField(
                          labelText: "City",
                          controller: customerCtrl.customerCityCtrl,
                          keyboardType: TextInputType.name,
                        ),
                        CustomTextField(
                          labelText: "Country",
                          controller: customerCtrl.customerCountryCtrl,
                          keyboardType: TextInputType.name,
                        ),
                        CustomTextField(
                          labelText: "Post code",
                          controller: customerCtrl.customerPostCodeCtrl,
                          keyboardType: TextInputType.number,
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
}
