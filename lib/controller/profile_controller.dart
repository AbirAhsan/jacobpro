import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController? drivingLicenseExpiryTxtCtrl = TextEditingController();
  TextEditingController? idCardExpiryTxtCtrl = TextEditingController();
  TextEditingController? technicalLicenseExpiryTxtCtrl =
      TextEditingController();
  TextEditingController? socialSecurityExpiryTxtCtrl = TextEditingController();

  bool isOnline = false;
}
