import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/job_list/views/rejected_joblist_view.dart';

import '../../controller/job_controller.dart';
import '../../controller/screen_controller.dart';
import '../variables/colors_variable.dart';
import '../variables/text_style.dart';
import 'views/pending_joblist_screen.dart';
import 'views/assigned_joblist_view.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job List"),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: GetBuilder<JobController>(
              init: JobController(),
              builder: (jobCtrl) {
                return GetBuilder<ScreenController>(
                    init: ScreenController(),
                    initState: (state) {
                      jobCtrl.fetchJobCount();
                    },
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
                          screenCtrl.changeJobTabbar(value);
                        },
                        tabs: [
                          Tab(
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: screenCtrl.jobListCurrentIndex == 0 &&
                                        jobCtrl.jobCount.any((element) =>
                                            element['statusId'] == 0)
                                    ? CustomColors.primary
                                    : screenCtrl.jobListCurrentIndex != 0 &&
                                            jobCtrl.jobCount.any((element) =>
                                                element['statusId'] == 0)
                                        ? CustomColors.grey
                                        : CustomColors.white,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                jobCtrl.jobCount.any(
                                        (element) => element['statusId'] == 0)
                                    ? '${jobCtrl.jobCount.firstWhereOrNull((element) => element['statusId'] == 0)['noOfJob']}'
                                    : "",
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
                                color: screenCtrl.jobListCurrentIndex == 1 &&
                                        jobCtrl.jobCount.any((element) =>
                                            element['statusId'] == 1)
                                    ? CustomColors.primary
                                    : screenCtrl.jobListCurrentIndex != 1 &&
                                            jobCtrl.jobCount.any((element) =>
                                                element['statusId'] == 1)
                                        ? CustomColors.grey
                                        : CustomColors.white,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                jobCtrl.jobCount.any(
                                        (element) => element['statusId'] == 1)
                                    ? '${jobCtrl.jobCount.firstWhereOrNull((element) => element['statusId'] == 1)['noOfJob']}'
                                    : "",
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
                            text: 'REJECTED',
                          ),
                        ],
                      );
                    });
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
                AssignedJobView(),
                AssignedJobView(),
                AssignedJobView(),
                AssignedJobView(),
                RejectedJobView(),
              ],
            );
          }),
    );
  }
}
