import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/customer_model.dart';
import 'package:service/services/page_navigation_service.dart';
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
                        marginLeft: 30,
                        marginRight: 30,
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
                        itemCount: customerCtrl.customerList.length,
                        itemBuilder: (buildContext, index) {
                          CustomerInfoModel? customerInfo =
                              customerCtrl.customerList[index];
                          return Card(
                              child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                customerInfo!.customerDisplayName ?? "",
                              ),
                            ),
                            subtitle: customerInfo.customerBillingAddress !=
                                    null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.edit),
                                ),
                                customerInfo.customerDefaultContact != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.call),
                                      )
                                    : Container()
                              ],
                            ),
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
                })),
      ),
    );
  }
}
