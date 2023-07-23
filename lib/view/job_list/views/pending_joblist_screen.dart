import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/job_controller.dart';
import 'package:service/view/variables/text_style.dart';

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
            child: jobCtrl.pendingJobList.isNotEmpty
                ? ListView.builder(
                    itemCount: jobCtrl.pendingJobList.length,
                    padding: const EdgeInsets.all(15.0),
                    itemBuilder: (BuildContext buildContext, index) {
                      return JobCardWidget(
                        hasAcceptButton: true,
                        hasRejectButton: true,
                        jobdetails: jobCtrl.pendingJobList[index],
                      );
                    })
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.document_scanner_outlined,
                          size: 50,
                        ),
                        Text(
                          "No pending jobs yet",
                          style: CustomTextStyle.normalBoldStyleDarkGrey,
                        )
                      ],
                    ),
                  ),
          );
        });
  }
}
