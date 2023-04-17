import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/job_grid_model.dart';
import 'package:service/model/job_report_model.dart';
import 'package:service/services/api_service/job_api_service.dart';

import '../model/job_life_cycle_model.dart';
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

  Rx<Future<List<JobLifeCycleModel?>>> jobLifeCycle =
      Future.value(List<JobLifeCycleModel?>.empty(growable: true)).obs;
  List jobCount = List.empty(growable: true);

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

  //<======================================================== Fetch Job LifeCycle
  Future<void> fetchJobLifeCycle(String? jobUuid) async {
    try {
      jobLifeCycle.value = JobApiService().getJobLifeCycle(jobUuid!);

      update();
    } on SocketException catch (e) {
      debugPrint('error $e');
    } catch (e) {
      debugPrint("$e");
    }
  }

  //<======================================================== Go to next Job LifeCycle
  Future<bool> gotoNextJobLifeCycle(
      int? jobSystemId, String? jobUuid, int? lifeCycleId) async {
    bool resp = false;
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().goJobNextLifeCycle(jobSystemId!, lifeCycleId!).then(
          (resp) async {
        CustomEassyLoading.stopLoading();
        if (resp) {
          resp = resp;
          await fetchJobLifeCycle(jobUuid);
        }
      }, onError: (err) {
        debugPrint(err.toString());
        CustomEassyLoading.stopLoading();
        ApiErrorHandleService.handleStatusCodeError(err);
      });

      CustomEassyLoading.stopLoading();
    } on SocketException catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint('error $e');
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
    return resp;
  }

  //<=========================== Fetch  Job Count
  Future<void> fetchJobCount() async {
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().getJobCountList().then((resp) {
        jobCount = resp;
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
