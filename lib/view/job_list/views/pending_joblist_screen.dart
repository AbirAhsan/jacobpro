import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/job_controller.dart';

import '../job_card_widget.dart';

class PendingJobView extends StatelessWidget {
  const PendingJobView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobController>(
        init: JobController(),
        initState: (state) {
          Get.put(JobController()).fetchPendingJobList();
          Get.put(JobController()).fetchJobCount();
        },
        builder: (jobCtrl) {
          return RefreshIndicator(
            onRefresh: () async {
              await jobCtrl.fetchJobCount();
              await jobCtrl.fetchPendingJobList();
            },
            child: ListView.builder(
                itemCount: jobCtrl.pendingJobList.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (BuildContext buildContext, index) {
                  return JobCardWidget(
                    hasAcceptButton: true,
                    hasRejectButton: true,
                    jobdetails: jobCtrl.pendingJobList[index],
                  );
                }),
          );
        });
  }
}
