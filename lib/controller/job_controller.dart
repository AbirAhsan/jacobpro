import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:service/model/job_grid_model.dart';
import 'package:service/model/job_report_model.dart';
import 'package:service/services/api_service/job_api_service.dart';

import '../model/job_life_cycle_model.dart';
import '../services/custom_eassy_loading.dart';
import '../services/error_code_handle_service.dart';

class JobController extends GetxController {
  List<JobGridDetailsModel?> pendingJobList =
      List<JobGridDetailsModel?>.empty(growable: true);
  List<JobGridDetailsModel?> assignedJobList =
      List<JobGridDetailsModel?>.empty(growable: true);
  List<JobGridDetailsModel?> ongoingJobList =
      List<JobGridDetailsModel?>.empty(growable: true);
  List<JobGridDetailsModel?> rejectedJobList =
      List<JobGridDetailsModel?>.empty(growable: true);
  List<JobGridDetailsModel?> completedJobList =
      List<JobGridDetailsModel?>.empty(growable: true);

  GlobalKey<PaginationViewState>? rejectedPaginationKey;

  Rx<JobReportModel?> jobReportFutureDetails = JobReportModel().obs;

  RxList<JobLifeCycleModel?> jobLifeCycle =
      List<JobLifeCycleModel?>.empty(growable: true).obs;

  List jobCount = List.empty(growable: true);
  int jobStatusId = -1;
  bool isListEmpty = false;
  @override
  void onInit() {
    isListEmpty = false;
    rejectedPaginationKey = GlobalKey<PaginationViewState>();
    super.onInit();
  }

//<=============== Fetch Pending Job List

  Future<List<JobGridDetailsModel?>> fetchPendingJobList(
    int offset,
  ) async {
    try {
      final resp = await JobApiService().getJobList(offset, 0);
      pendingJobList = resp;
      if (resp.isNotEmpty) {
        return resp;
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
    } catch (e) {
      debugPrint("Error: $e");
    }
    return [];
  }

//<=============== Fetch Assigned Job List

  Future<List<JobGridDetailsModel?>> fetchAssignedJobList(
    int offset,
  ) async {
    try {
      final resp = await JobApiService().getJobList(offset, 1);
      assignedJobList = resp;
      if (resp.isNotEmpty) {
        return resp;
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
    } catch (e) {
      debugPrint("Error: $e");
    }
    return [];
  }

//<=============== Fetch Assigned Job List
  Future<List<JobGridDetailsModel?>> fetchOngoingJobList(
    int offset,
  ) async {
    try {
      final resp = await JobApiService().getJobList(offset, 3);
      ongoingJobList = resp;
      if (resp.isNotEmpty) {
        return resp;
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
    } catch (e) {
      debugPrint("Error: $e");
    }
    return [];
  }

//<=============== Fetch Rejected Job List
  Future<List<JobGridDetailsModel?>> fetchRejectedJobList(
    int offset,
  ) async {
    try {
      final resp = await JobApiService().getJobList(offset, 2);
      rejectedJobList = resp;
      if (resp.isNotEmpty) {
        return resp;
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
    } catch (e) {
      debugPrint("Error: $e");
    }
    return [];
  }

  // //<=============== Fetch All Job List
  // Future<List<JobGridDetailsModel?>> fetchAllJobList(
  //   int offset,
  // ) async {
  //   try {
  //     final resp = await JobApiService().getJobList(offset, jobStatusId);
  //     if (jobStatusId == 0) {
  //       pe
  //     } else if (jobStatusId == 1) {
  //     } else if (jobStatusId == 2) {
  //     } else if (jobStatusId == 3) {
  //     } else if (jobStatusId == 4) {}
  //     completedJobList = resp;
  //     if (resp.isNotEmpty) {
  //       return resp;
  //     }
  //   } on SocketException catch (e) {
  //     debugPrint('SocketException: $e');
  //   } catch (e) {
  //     debugPrint("Error: $e");
  //   }
  //   return [];
  // }

//<=============== Fetch Completed Job List
  Future<List<JobGridDetailsModel?>> fetchCompletedJobList(
    int offset,
  ) async {
    try {
      final resp = await JobApiService().getJobList(offset, 4);
      completedJobList = resp;
      if (resp.isNotEmpty) {
        return resp;
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
    } catch (e) {
      debugPrint("Error: $e");
    }
    return [];
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
          // fetchPendingJobList();
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
        fetchJobCount();
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
        if (resp) {
          resp = resp;
          await fetchJobLifeCycle(jobUuid, optionId);
        }
        CustomEassyLoading.startLoading();
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
      await JobApiService().lifeCycleDeclareStart(jobUuid!, optionId).then(
          (resp) async {
        if (resp) {
          resp = resp;
          await fetchJobLifeCycle(jobUuid, optionId);
          CustomEassyLoading.stopLoading();
        }
        CustomEassyLoading.startLoading();
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
        if (resp) {
          resp = resp;
          await fetchJobLifeCycle(jobUuid, optionId);
        }
        CustomEassyLoading.stopLoading();
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
