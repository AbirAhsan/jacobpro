import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/profile/views/contact_details_view.dart';
import 'package:service/view/profile/views/document_details_view.dart';
import 'package:service/view/profile/views/employee_details_view.dart';

import '../../controller/screen_controller.dart';
import '../variables/colors_variable.dart';
import '../variables/text_style.dart';
import '../widgets/custom_drawer.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "VERIFICATION PENDING!",
                      style: CustomTextStyle.titleBoldStylWarning,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Your profile isn't verified yet. Please provide all the data properly and submit to get reviewed and verified!",
                      style: CustomTextStyle.normalRegularStyleGrey,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              GetBuilder<ScreenController>(
                  init: ScreenController(),
                  builder: (screenCtrl) {
                    return TabBar(
                      indicatorColor: CustomColors.primary,
                      unselectedLabelColor: CustomColors.grey,
                      controller: screenCtrl.profileTabController,
                      labelStyle: CustomTextStyle.normalBoldStyleBlack,
                      automaticIndicatorColorAdjustment: true,
                      labelColor: CustomColors.primary,
                      isScrollable: false,
                      onTap: (value) {
                        screenCtrl.changeProfileTabbar(value);
                      },
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('GENERAL'),
                              const SizedBox(width: 8),
                              Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomColors.green),
                                child: const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: CustomColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('SKILLS'),
                              const SizedBox(width: 8),
                              Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomColors.warning),
                                child: const Icon(
                                  Icons.error_outline,
                                  size: 18,
                                  color: CustomColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('DOCUMENTS'),
                              const SizedBox(width: 8),
                              Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CustomColors.green),
                                child: const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: CustomColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: GetBuilder<ScreenController>(
          init: ScreenController(),
          builder: (screenCtrl) {
            return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: screenCtrl.profileTabController,
              children: const [
                ContactDetailsView(),
                EmployeeDetailsView(),
                DocumentDetailsView(),
              ],
            );
          }),
    );
  }
}
