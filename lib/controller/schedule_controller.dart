import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/schedule_data_model.dart';
import 'package:service/services/api_service/schedule_api_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../services/custom_eassy_loading.dart';
import '../services/error_code_handle_service.dart';
import '../view/schedule/schedule_screen.dart';

class ScheduleController extends GetxController {
  CalendarController? calenderController;

  RxList<ScheduleDataModel?> scheduleList =
      List<ScheduleDataModel?>.empty(growable: true).obs;

  //<=============== Fetch Schedule  List
  Future<void> fetchScheduleList(String? firstDate) async {
    print("working");
    try {
      CustomEassyLoading.startLoading();
      await ScheduleApiService.getScheduleList(firstDate).then((resp) {
        scheduleList.value = resp;
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

  DataSource getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];

    for (var element in scheduleList) {
      appointments.add(Appointment(
        startTime: DateTime.parse(element!.scheduleStartDateTime!),
        endTime: DateTime.parse(element.scheduleEndDateTime!),
        // isAllDay: true,

        subject:
            "${element.scheduleCustomerInfo!.customerDisplayName}\n${DateFormat.jm('en').format(
          DateTime.parse(element.scheduleStartDateTime!),
        )}-${DateFormat.jm('en').format(
          DateTime.parse(element.scheduleEndDateTime!),
        )}\n\n${element.scheduleItems} \n${element.scheduleCustomerInfo!.customerContactNo} \n\n${element.scheduleCustomerInfo!.customerAddress}\n\$${element.scheduleBillAmount}",

        color: Color(int.parse(
          element.scheduleColorCode!.replaceAll("#", "0xFF"),
        )),
        startTimeZone: '',
        endTimeZone: '',
      ));
    }
    print(appointments);
    return DataSource(appointments);
  }
}
