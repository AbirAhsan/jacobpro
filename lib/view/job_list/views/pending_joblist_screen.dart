import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:service/controller/job_controller.dart';
import 'package:service/view/variables/text_style.dart';

import '../../../model/job_grid_model.dart';
import '../../variables/colors_variable.dart';
import '../../widgets/custom_shimmer_effect.dart';
import '../job_card_widget.dart';

class PendingJobView extends StatelessWidget {
  const PendingJobView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<PaginationViewState> paginationKey =
        GlobalKey<PaginationViewState>();
    return GetBuilder<JobController>(
        init: JobController(),
        // initState: (state) {
        //   Get.put(JobController()).fetchJobCount();
        // },
        builder: (jobCtrl) {
          return PaginationView<JobGridDetailsModel?>(
            // shrinkWrap: true,
            physics: const ScrollPhysics(),
            key: paginationKey,
            paginationViewType: PaginationViewType.listView,
            padding: const EdgeInsets.all(8.0),
            pageFetch: jobCtrl.fetchPendingJobList,
            itemBuilder: (BuildContext context, JobGridDetailsModel? jobGrid,
                int index) {
              return JobCardWidget(
                paginateKey: paginationKey,
                hasAcceptButton: true,
                hasRejectButton: true,
                jobdetails: jobGrid,
              );
            },
            pullToRefresh: true,
            onError: (dynamic erro) => const Center(
                child: Text(
                    "Something Went to wrong") //Image.asset(CustomIcon.error),
                ),
            onEmpty: const Center(
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
            bottomLoader: jobCtrl.pendingJobList.length < 10
                ? Container()
                : CustomShimmerEffect(
                    child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    margin: const EdgeInsets.all(15),
                    width: Get.width,
                    height: 200,
                    color: CustomColors.grey,
                  )),
            initialLoader: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                itemBuilder: (context, index) {
                  return CustomShimmerEffect(
                      child: Container(
                    margin: const EdgeInsets.all(15),
                    width: Get.width,
                    height: 200,
                    color: CustomColors.grey,
                  ));
                }),
          );
        });
  }
}
