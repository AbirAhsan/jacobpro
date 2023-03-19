import 'package:flutter/material.dart';
import 'package:service/services/page_navigation_service.dart';
import 'package:service/view/widgets/custom_company_button.dart';
import 'package:service/view/widgets/custom_drawer.dart';

import '../widgets/custom_appbar.dart';

class MyCustomersScreen extends StatelessWidget {
  const MyCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My Customers",
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          height: 100,
          child: CustomCompanyButton(
              buttonName: "Add New Customer",
              onPressed: () {
                PageNavigationService.generalNavigation(
                    "/AddNewCustomerScreen");
              })),
    );
  }
}
