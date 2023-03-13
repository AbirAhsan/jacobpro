import 'package:get/get.dart' hide Trans;

import '../view/variables/colors_variable.dart';

class ApiErrorHandleService {
  static handleStatusCodeError(Map<String, dynamic> status) async {
    await Get.closeCurrentSnackbar();

    if (status["code"] == 401) {
      Get.snackbar(
        "Warning",
        status["message"] ?? "Session Expired",
        backgroundColor: CustomColors.secondary,
        // duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
      //  Get.put(AuthController()).tryToLogOut();
    } else if (status["code"] == 404) {
      Get.snackbar(
        "Not Found",
        "${status["message"]}",
        backgroundColor: CustomColors.grey,
        //  duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
    } else if (status["code"] > 499) {
      Get.snackbar(
        "Attention",
        "Server Error, Try Again after sometimes",
        backgroundColor: CustomColors.primary,
        //  duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        "Warning",
        status["message"] ?? "Somthing went to wrong",
        backgroundColor: CustomColors.secondary,
        // duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
