import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/job_controller.dart';

import '../pending_job_card_widget.dart';

class PendingJobView extends StatelessWidget {
  const PendingJobView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobController>(
        init: JobController(),
        initState: (state) {
          Get.put(JobController()).fetchPendingJobList();
        },
        builder: (jobCtrl) {
          return ListView.builder(
              itemCount: jobCtrl.pendingJobList.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (BuildContext buildContext, index) {
                return PendingJobCardWidget(
                  jobdetails: jobCtrl.pendingJobList[index],
                );
              });
        });
  }
}
