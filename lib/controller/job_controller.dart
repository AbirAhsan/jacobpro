import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/job_grid_model.dart';
import 'package:service/services/api_service/job_api_service.dart';

import '../services/custom_eassy_loading.dart';
import '../services/error_code_handle_service.dart';

class JobController extends GetxController {
  RxList<JobGridDetailsModel?> pendingJobList =
      List<JobGridDetailsModel?>.empty(growable: true).obs;

  int? page;
  @override
  void onInit() {
    page = -1;
    super.onInit();
  }

//<=============== Fetch Pending Job List
  Future<void> fetchPendingJobList() async {
    print("working");
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().getMyPendingJobList().then((resp) {
        pendingJobList.value = resp;

        update();
        CustomEassyLoading.stopLoading();
      }, onError: (err) {
        debugPrint(err.toString());
        CustomEassyLoading.stopLoading();
        ApiErrorHandleService.handleStatusCodeError(err);
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }

//<=============== Accept or Reject Job From Pending Job List
  Future<void> acceptOrRejectJob(int? jobSystemId, int isAccept) async {
    try {
      CustomEassyLoading.startLoading();
      await JobApiService()
          .acceptOrRejectPendingJob(jobSystemId, isAccept)
          .then((resp) {
        if (resp) {
          pendingJobList
              .removeWhere((element) => element!.jobSystemId == jobSystemId);
          update();
          fetchPendingJobList();
        }

        CustomEassyLoading.stopLoading();
      }, onError: (err) {
        debugPrint(err.toString());
        CustomEassyLoading.stopLoading();
        ApiErrorHandleService.handleStatusCodeError(err);
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }
}
