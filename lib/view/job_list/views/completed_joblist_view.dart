import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/job_controller.dart';

import '../job_card_widget.dart';

class CompletedJobView extends StatelessWidget {
  const CompletedJobView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobController>(
        init: JobController(),
        initState: (state) {
          Get.put(JobController()).fetchCompletedJobList();
        },
        builder: (jobCtrl) {
          return RefreshIndicator(
            onRefresh: () async {
              await jobCtrl.fetchJobCount();
              await jobCtrl.fetchCompletedJobList();
            },
            child: ListView.builder(
                itemCount: jobCtrl.completedJobList.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (BuildContext buildContext, index) {
                  return JobCardWidget(
                    hasDetailButton: true,
                    showInspection: false,
                    jobdetails: jobCtrl.completedJobList[index],
                  );
                }),
          );
        });
  }
}
