import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/dashboard/widgets/dashboard_card_widget_1.dart';
import '../../controller/profile_controller.dart';
import '../../services/page_navigation_service.dart';
import '../variables/icon_variables.dart';
import '../variables/text_style.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/profile_Image_widget.dart';
import 'widgets/dashboard_card_widget_2.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          CustomIcons.logo,
          width: 100,
        ),
        actions: [
          IconButton(
              onPressed: () {
                PageNavigationService.generalNavigation("/NotificationScreen");
              },
              icon: const Icon(Icons.notifications_active_outlined))
        ],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(
          //     elevation: 5,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: GetBuilder<ProfileController>(
          //           init: ProfileController(),
          //           builder: (profileCtrl) {
          //             return ListTile(
          //               leading: ProfileImageWidget(
          //                 imageUrl: "",
          //                 radius: 26,
          //               ),
          //               title: Text(
          //                 "Abir Ahsan".toUpperCase(),
          //                 style: CustomTextStyle.mediumBoldStyleBlack,
          //               ),
          //               subtitle: RichText(
          //                   text: TextSpan(text: "", children: [
          //                 TextSpan(
          //                   text: "ID : ",
          //                   style: CustomTextStyle.smallRegularStyleDarkGrey,
          //                 ),
          //                 TextSpan(
          //                   text: "846268372",
          //                   style: CustomTextStyle.smallRegularStyleDarkGrey,
          //                 ),
          //                 TextSpan(
          //                   text: "\nPermenent Staff",
          //                   style: CustomTextStyle.smallRegularStylePrimary,
          //                 ),
          //               ])),
          //               trailing: Row(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   CupertinoSwitch(
          //                     value: profileCtrl.isOnline,
          //                     onChanged: (value) {
          //                       profileCtrl.isOnline = value;
          //                       profileCtrl.update();
          //                     },
          //                   ),
          //                   Text(
          //                     profileCtrl.isOnline ? "ONLINE" : "OFFLINE",
          //                     style: profileCtrl.isOnline
          //                         ? CustomTextStyle.normalBoldStyleGreen
          //                         : CustomTextStyle.normalBoldStyleGrey,
          //                   ),
          //                 ],
          //               ),
          //             );
          //           }),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<ProfileController>(
                    init: ProfileController(),
                    builder: (profileCtrl) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProfileImageWidget(
                                imageUrl: "",
                                radius: 26,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Abir Ahsan".toUpperCase(),
                                    style:
                                        CustomTextStyle.mediumRegularStyleBlack,
                                  ),
                                  Text(
                                    "Permanent Staff",
                                    style:
                                        CustomTextStyle.normalRegularStyleGrey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CupertinoSwitch(
                                value: profileCtrl.isOnline,
                                onChanged: (value) {
                                  profileCtrl.isOnline = value;
                                  profileCtrl.update();
                                },
                              ),
                              Text(
                                profileCtrl.isOnline ? "ONLINE" : "OFFLINE",
                                style: profileCtrl.isOnline
                                    ? CustomTextStyle.normalBoldStyleGreen
                                    : CustomTextStyle.normalBoldStyleGrey,
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
          //<===== Profile End
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //  mainAxisExtent: _width / 2,
              childAspectRatio: 1.7,
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            children: const [
              DashBoardCardWidget1(
                name: "Pending",
                assetImage: CustomIcons.pending,
                quantity: 0,
              ),
              DashBoardCardWidget1(
                name: "Schedule",
                assetImage: CustomIcons.schedule,
                quantity: 17,
              ),
            ],
          ),
          //<================
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //  mainAxisExtent: _width / 2,
                  // childAspectRatio: 0.90,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                children: [
                  DashBoardCardWidget2(
                    name: "ON GOING JOB",
                    assetImage: CustomIcons.ongoingJob,
                    onTap: () {
                      PageNavigationService.generalNavigation(
                          '/OnGoingJobScreen');
                    },
                  ),
                  DashBoardCardWidget2(
                    name: "SCHEDULE",
                    assetImage: CustomIcons.scheduleImage,
                    onTap: () {
                      PageNavigationService.generalNavigation(
                          '/ScheduleScreen');
                    },
                  ),
                  DashBoardCardWidget2(
                    name: "JOB LIST",
                    assetImage: CustomIcons.jobList,
                    onTap: () {
                      PageNavigationService.generalNavigation('/JobListScreen');
                    },
                  ),
                  DashBoardCardWidget2(
                    name: "TIME SHEET",
                    assetImage: CustomIcons.timesheet,
                    onTap: () {
                      PageNavigationService.generalNavigation(
                          '/TimeSheetMainScreen');
                    },
                  ),
                ]),
          )
        ],
      )),
    );
  }
}
