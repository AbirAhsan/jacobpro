import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/job_grid_model.dart';
import 'package:service/model/job_report_model.dart';
import 'package:service/services/api_service/job_api_service.dart';

import '../services/custom_eassy_loading.dart';
import '../services/error_code_handle_service.dart';

class JobController extends GetxController {
  RxList<JobGridDetailsModel?> pendingJobList =
      List<JobGridDetailsModel?>.empty(growable: true).obs;
  RxList<JobGridDetailsModel?> assignedJobList =
      List<JobGridDetailsModel?>.empty(growable: true).obs;
  RxList<JobGridDetailsModel?> rejectedJobList =
      List<JobGridDetailsModel?>.empty(growable: true).obs;

  Rx<Future<JobReportModel?>> jobReportFutureDetails =
      Future.value(JobReportModel()).obs;

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

//<=============== Fetch Assigned Job List
  Future<void> fetchAssignedJobList() async {
    print("working");
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().getMyAssignedJobList().then((resp) {
        assignedJobList.value = resp;

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

//<=============== Fetch Assigned Job List
  Future<void> fetchRejectedJobList() async {
    print("working");
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().getMyRejectedJobList().then((resp) {
        rejectedJobList.value = resp;

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
  Future<void> acceptOrRejectPendingJob(int? jobSystemId, int isAccept) async {
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

  //<======================================================== Fetch Job Report Details
  Future<void> fetchJobReportDetails(String? jobUuid) async {
    try {
      jobReportFutureDetails.value =
          JobApiService().getJobReortDetails(jobUuid!);

      // consultantProfile.value = profile;

      update();
    } on SocketException catch (e) {
      debugPrint('error $e');
    } catch (e) {
      debugPrint("$e");
    }
  }
}
