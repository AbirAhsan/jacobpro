import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  GlobalKey<FormState> addCustomerFormKey = GlobalKey<FormState>();
  TextEditingController customerFirstNameCtrl = TextEditingController();
  TextEditingController customerLastNameCtrl = TextEditingController();
  TextEditingController customerEmailCtrl = TextEditingController();
  TextEditingController customerMobileCtrl = TextEditingController();
  TextEditingController customerAddressCtrl = TextEditingController();
  TextEditingController customerStateCtrl = TextEditingController();
  TextEditingController customerCityCtrl = TextEditingController();
  TextEditingController customerCountryCtrl = TextEditingController();
  TextEditingController customerPostCodeCtrl = TextEditingController();
  TextEditingController customerNoteCtrl = TextEditingController();
}
