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

//<=============== Fetch Recommended Ground List
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
}
