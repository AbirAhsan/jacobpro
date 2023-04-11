import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/widgets/custom_appbar.dart';

import '../../controller/screen_controller.dart';
import '../variables/colors_variable.dart';
import '../variables/text_style.dart';
import 'views/pending_joblist_screen.dart';
import 'views/time_sheet_approved_view.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job List"),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: GetBuilder<ScreenController>(
              init: ScreenController(),
              builder: (screenCtrl) {
                return TabBar(
                  indicatorColor: CustomColors.primary,
                  unselectedLabelColor: CustomColors.grey,
                  controller: screenCtrl.jobListTabController,
                  labelStyle: CustomTextStyle.normalBoldStyleBlack,
                  automaticIndicatorColorAdjustment: true,
                  labelColor: CustomColors.primary,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return states.contains(MaterialState.focused)
                          ? null
                          : Colors.white;
                    },
                  ),
                  isScrollable: true,
                  onTap: (value) {
                    screenCtrl.changeTimeSheetTabbar(value);
                  },
                  tabs: [
                    Tab(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: screenCtrl.jobListCurrentIndex == 0
                              ? CustomColors.primary
                              : CustomColors.grey,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '1',
                          style: CustomTextStyle.mediumBoldStyleWhite,
                        ),
                      ),
                      text: 'PENDING',
                    ),
                    Tab(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: screenCtrl.jobListCurrentIndex == 1
                              ? CustomColors.primary
                              : CustomColors.grey,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '2',
                          style: CustomTextStyle.mediumBoldStyleWhite,
                        ),
                      ),
                      text: 'ASSIGNED',
                    ),
                    Tab(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: screenCtrl.jobListCurrentIndex == 2
                              ? CustomColors.primary
                              : CustomColors.grey,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '2',
                          style: CustomTextStyle.mediumBoldStyleWhite,
                        ),
                      ),
                      text: 'APPROVED',
                    ),
                    Tab(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: screenCtrl.jobListCurrentIndex == 3
                              ? CustomColors.white
                              : CustomColors.white,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '',
                          style: CustomTextStyle.mediumBoldStyleWhite,
                        ),
                      ),
                      text: 'ONGOING',
                    ),
                    Tab(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: screenCtrl.jobListCurrentIndex == 4
                              ? CustomColors.primary
                              : CustomColors.grey,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '2',
                          style: CustomTextStyle.mediumBoldStyleWhite,
                        ),
                      ),
                      text: 'COMPLETED',
                    ),
                  ],
                );
              }),
        ),
      ),
      body: GetBuilder<ScreenController>(
          init: ScreenController(),
          builder: (screenCtrl) {
            return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: screenCtrl.jobListTabController,
              children: const [
                PendingJobView(),
                AssignedTabView(),
                AssignedTabView(),
                AssignedTabView(),
                AssignedTabView(),
              ],
            );
          }),
    );
  }
}
