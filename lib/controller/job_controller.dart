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
  RxList<JobGridDetailsModel?> ongoingJobList =
      List<JobGridDetailsModel?>.empty(growable: true).obs;
  RxList<JobGridDetailsModel?> rejectedJobList =
      List<JobGridDetailsModel?>.empty(growable: true).obs;
  RxList<JobGridDetailsModel?> completedJobList =
      List<JobGridDetailsModel?>.empty(growable: true).obs;

  Rx<JobReportModel?> jobReportFutureDetails = JobReportModel().obs;

  RxList<JobLifeCycleModel?> jobLifeCycle =
      List<JobLifeCycleModel?>.empty(growable: true).obs;

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
        print("Print job uiuid ${resp.first!.jobUuid}");

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
  Future<void> fetchOngoingJobList() async {
    print("working");
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().getOngoingJobList().then((resp) {
        ongoingJobList.value = resp;

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

//<=============== Fetch Completed Job List
  Future<void> fetchCompletedJobList() async {
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().getCompletedJobList().then((resp) {
        completedJobList.value = resp;

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
  Future<void> fetchJobReportDetails(
      String? jobUuid, String? jobOptionId) async {
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().getJobReortDetails(jobUuid!, jobOptionId).then(
          (resp) {
        jobReportFutureDetails.value = resp;

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

  //<======================================================== Fetch Job LifeCycle
  Future<void> fetchJobLifeCycle(String? jobUuid, String? jobOptionId) async {
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().getJobLifeCycle(jobUuid!, jobOptionId).then((resp) {
        jobLifeCycle.value = resp;
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

  //<======================================================== Job LifeCycle Declare On My Way
  Future<bool> declareLifecycleOnMyWay(
    String? jobUuid,
    String? optionId,
  ) async {
    bool resp = false;
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().lifeCycleOnMyway(jobUuid!, optionId).then(
          (resp) async {
        CustomEassyLoading.stopLoading();
        if (resp) {
          resp = resp;
          await fetchJobLifeCycle(jobUuid, optionId);
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

  //<======================================================== Job LifeCycle Declare Start
  Future<bool> declareLifecycleStart(
    String? jobUuid,
    String? optionId,
  ) async {
    bool resp = false;
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().lifeCycleDeclareStart(jobUuid!, optionId).then(
          (resp) async {
        CustomEassyLoading.stopLoading();
        if (resp) {
          resp = resp;
          await fetchJobLifeCycle(jobUuid, optionId);
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

//<======================================================== Job LifeCycle Declare Finished
  Future<bool> declareLifecycleFinished(
    String? jobUuid,
    String? optionId,
  ) async {
    bool resp = false;
    try {
      CustomEassyLoading.startLoading();
      await JobApiService().lifeCycleFinished(jobUuid!, optionId).then(
          (resp) async {
        CustomEassyLoading.stopLoading();
        if (resp) {
          resp = resp;
          await fetchJobLifeCycle(jobUuid, optionId);
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
        print("Job count $resp");
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
