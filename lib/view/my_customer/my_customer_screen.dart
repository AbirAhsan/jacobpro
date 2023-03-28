import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/customer_model.dart';
import 'package:service/services/page_navigation_service.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_company_button.dart';
import 'package:service/view/widgets/custom_drawer.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../controller/customer_controller.dart';
import '../widgets/custom_appbar.dart';

class MyCustomersScreen extends StatelessWidget {
  const MyCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "My Customers",
          elevation: 0,
        ),
        drawer: const CustomDrawer(),
        body: GetBuilder<CustomerController>(
            init: CustomerController(),
            initState: (state) {
              Get.put(CustomerController()).getCustomerList();
            },
            builder: (customerCtrl) {
              return Column(
                children: [
                  Card(
                    elevation: 0,
                    child: CustomTextField(
                        marginLeft: 15,
                        marginRight: 15,
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search Customer",
                        controller: customerCtrl.searchCustomerTextCtrl,
                        onChanged: (value) {
                          customerCtrl.debouncer.run(() {
                            customerCtrl.getCustomerList();
                            //perform search here
                          });
                        }),
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        itemCount: customerCtrl.customerList.length,
                        itemBuilder: (buildContext, index) {
                          CustomerInfoModel? customerInfo =
                              customerCtrl.customerList[index];
                          return Card(
                              child: ListTile(
                            onTap: () {
                              PageNavigationService.generalNavigation(
                                  "/CustomerDetailsScreen",
                                  arguments:
                                      customerInfo.customerId.toString());
                            },
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, bottom: 5),
                              child: Text(
                                "${customerInfo!.customerDisplayName ?? ""}"
                                    .toUpperCase(),
                                style: CustomTextStyle.normalBoldStyleBlack,
                              ),
                            ),
                            subtitle: customerInfo.customerBillingAddress !=
                                    null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 16,
                                      ),
                                      Expanded(
                                        child: Text(
                                          customerInfo.customerBillingAddress ??
                                              "",
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ));
                        }),
                  )
                ],
              );
            }),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          height: 100,
          child: CustomCompanyButton(
              buttonName: "Add New Customer",
              onPressed: () {
                PageNavigationService.generalNavigation(
                    "/AddNewCustomerScreen");
              }),
        ),
      ),
    );
  }
}
