import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/time_sheet/views/time_sheet_approved_view.dart';

import '../../controller/screen_controller.dart';
import '../variables/colors_variable.dart';
import '../variables/text_style.dart';
import '../widgets/custom_appbar.dart';

class TimeSheetMainScreen extends StatelessWidget {
  const TimeSheetMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Time Sheet",
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: GetBuilder<ScreenController>(
              init: ScreenController(),
              builder: (screenCtrl) {
                return TabBar(
                  indicatorColor: CustomColors.primary,
                  unselectedLabelColor: CustomColors.grey,
                  controller: screenCtrl.timeSheetTabController,
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
                  isScrollable: false,
                  onTap: (value) {
                    screenCtrl.changeTimeSheetTabbar(value);
                  },
                  tabs: [
                    Tab(
                      icon: Container(
                        padding: const EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: screenCtrl.timeSheetCurrentIndex == 0
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
                        padding: const EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: screenCtrl.timeSheetCurrentIndex == 1
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
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: screenCtrl.timeSheetCurrentIndex == 2
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
                        padding: const EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: screenCtrl.timeSheetCurrentIndex == 3
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
              controller: screenCtrl.timeSheetTabController,
              children: const [
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
