import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/schedule_controller.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../variables/text_style.dart';
import '../widgets/custom_appbar.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Schedule",
      ),
      body: GetBuilder<ScheduleController>(
          init: ScheduleController(),
          initState: (state) {},
          builder: (scheduleCtrl) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Card(
                    child: Container(
                      height: Get.height - 155,
                      padding: const EdgeInsets.all(8.0),
                      child: SfCalendar(
                        minDate: DateTime.now(),
                        maxDate: DateTime.now().add(const Duration(days: 365)),
                        view: CalendarView.workWeek,
                        controller: scheduleCtrl.calenderController,
                        onViewChanged: (viewChangedDetails) {
                          // print(viewChangedDetails.visibleDates);

                          // print(DateFormat('yyyy-MM-dd', "en")
                          //     .format(viewChangedDetails.visibleDates.first)
                          //     .toString());
                          // scheduleCtrl.fetchScheduleList(
                          //     DateFormat('yyyy-MM-dd', "en")
                          //         .format(viewChangedDetails.visibleDates.first)
                          //         .toString()
                          //         .toString());
                        },
                        dataSource: scheduleCtrl.getCalendarDataSource(),
                        cellBorderColor: CustomColors.green,
                        blackoutDates: [],
                        blackoutDatesTextStyle:
                            CustomTextStyle.normalRegularStyleError,
                        onTap: (value) {
                          //  print(value);
                        },
                        showNavigationArrow: true,
                        firstDayOfWeek: 7,
                        onSelectionChanged: (calendarSelectionDetails) {},
                        scheduleViewSettings: ScheduleViewSettings(
                          hideEmptyScheduleWeek: false,
                        ),
                        timeSlotViewSettings: TimeSlotViewSettings(
                            startHour: 7,
                            endHour: 18,
                            nonWorkingDays: [],
                            timeRulerSize: 30
                            // timeInterval: Duration(minutes: 30)
                            ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //       padding: const EdgeInsets.only(top: 15.0),
                  //       shrinkWrap: true,
                  //       physics: const ScrollPhysics(),
                  //       itemCount: 10,
                  //       itemBuilder: (buildContext, index) {
                  //         return Card(
                  //           elevation: 5,
                  //           child: Column(
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Text(
                  //                       "Mon, 14, Mar",
                  //                       style: CustomTextStyle
                  //                           .mediumRegularStyleDarkGrey,
                  //                     ),
                  //                     IconButton(
                  //                         onPressed: () {},
                  //                         icon: Icon(Icons.more_horiz_sharp))
                  //                   ],
                  //                 ),
                  //               ),
                  //               IntrinsicHeight(
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Expanded(
                  //                         flex: 4,
                  //                         child: Column(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.start,
                  //                           children: [
                  //                             const Padding(
                  //                               padding: EdgeInsets.only(
                  //                                   left: 10, bottom: 10.0),
                  //                               child: Text(
                  //                                 "9:00",
                  //                                 style: CustomTextStyle
                  //                                     .mediumBoldStyleBlack,
                  //                               ),
                  //                             ),
                  //                             const Padding(
                  //                               padding: EdgeInsets.only(
                  //                                   left: 10, bottom: 10.0),
                  //                               child: Text(
                  //                                 "5.0736 miles",
                  //                                 style: CustomTextStyle
                  //                                     .normalRegularStyleDarkGrey,
                  //                               ),
                  //                             ),
                  //                             Container(
                  //                               padding:
                  //                                   const EdgeInsets.all(10),
                  //                               decoration: const BoxDecoration(
                  //                                 color: CustomColors.primary,
                  //                                 borderRadius:
                  //                                     BorderRadius.only(
                  //                                   topRight:
                  //                                       Radius.circular(10),
                  //                                   bottomRight:
                  //                                       Radius.circular(10),
                  //                                 ),
                  //                               ),
                  //                               child: const Text(
                  //                                 "Assessment",
                  //                                 style: CustomTextStyle
                  //                                     .mediumBoldStyleWhite,
                  //                               ),
                  //                             ),
                  //                             const SizedBox(
                  //                               height: 10,
                  //                             )
                  //                           ],
                  //                         )),
                  //                     const VerticalDivider(
                  //                       color: Colors.amber,
                  //                       thickness: 2,
                  //                     ),
                  //                     Expanded(
                  //                         flex: 4,
                  //                         child: Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               right: 10, left: 10),
                  //                           child: Column(
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.end,
                  //                             children: [
                  //                               Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.only(
                  //                                         bottom: 5.0),
                  //                                 child: Row(
                  //                                   children: const [
                  //                                     Icon(Icons
                  //                                         .insert_drive_file_outlined),
                  //                                     Text(
                  //                                       "Jack ",
                  //                                       style: CustomTextStyle
                  //                                           .normalBoldStyleBlack,
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                               Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.only(
                  //                                         bottom: 5.0),
                  //                                 child: Row(
                  //                                   children: const [
                  //                                     Icon(Icons
                  //                                         .location_on_outlined),
                  //                                     Text(
                  //                                       "Dhaka, Bangladesh",
                  //                                       style: CustomTextStyle
                  //                                           .normalRegularStyleDarkGrey,
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                               Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.only(
                  //                                         bottom: 5.0),
                  //                                 child: Row(
                  //                                   children: const [
                  //                                     Icon(Icons
                  //                                         .document_scanner_outlined),
                  //                                     Text(
                  //                                       "Something Here",
                  //                                       style: CustomTextStyle
                  //                                           .normalRegularStyleDarkGrey,
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                               CustomCompanyButtonWithIcon(
                  //                                   fizedSize: Size(100, 20),
                  //                                   buttonName: "Details",
                  //                                   onPressed: () {}),
                  //                               const SizedBox(
                  //                                 height: 10,
                  //                               )
                  //                             ],
                  //                           ),
                  //                         )),
                  //                   ],
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         );
                  //       }),
                  // )
                ],
              ),
            );
          }),
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
