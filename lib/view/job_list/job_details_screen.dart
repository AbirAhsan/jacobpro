import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_appbar.dart';

import '../../services/custom_dialog_class.dart';
import '../../services/page_navigation_service.dart';
import '../widgets/custom_collapsed_widget.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int? jobId = Get.arguments;
    return Scaffold(
      appBar: const CustomAppBar(title: "Job Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Card(
                child: CustomCollapsibleWidget(
                  name: "Monday, 24 Mar",
                  textStyle: CustomTextStyle.mediumBoldStylePrimary,
                  initiallyCollapsed: false,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                                shape: BoxShape
                                    .circle, // border: Border.all(color: ),
                                color: CustomColors.primary.withOpacity(0.1)),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.car_repair,
                                color: CustomColors.primary,
                              ),
                            ),
                          ),
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                                shape: BoxShape
                                    .circle, // border: Border.all(color: ),
                                color: CustomColors.primary.withOpacity(0.1)),
                            child: IconButton(
                              onPressed: () {
                                CustomDialogShow.showInfoDialog(
                                    title: "Confirm",
                                    description:
                                        "Do you confirm to start the job ?",
                                    okayButtonName: "YES",
                                    btnOkOnPress: () {
                                      PageNavigationService.backScreen();
                                    },
                                    cancelButtonName: "BACK",
                                    btnCancelOnPress: () {
                                      PageNavigationService.backScreen();
                                    });
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                color: CustomColors.primary,
                              ),
                            ),
                          ),
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                                shape: BoxShape
                                    .circle, // border: Border.all(color: ),
                                color: CustomColors.primary.withOpacity(0.1)),
                            child: IconButton(
                              onPressed: () {
                                CustomDialogShow.showInfoDialog(
                                    title: "Confirm",
                                    description:
                                        "Are You sure that you have complete this job ?",
                                    okayButtonName: "YES",
                                    btnOkOnPress: () {
                                      PageNavigationService.backScreen();
                                    },
                                    cancelButtonName: "BACK",
                                    btnCancelOnPress: () {
                                      PageNavigationService.backScreen();
                                    });
                              },
                              icon: const Icon(
                                Icons.stop,
                                color: CustomColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Customer",
                          style: CustomTextStyle.mediumBoldStyleDarkGrey,
                        ),
                      ),
                      Image.network(
                        "https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/home-improvement/wp-content/uploads/2022/07/download-23.jpg",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //<==== Customer name, call and message
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.person,
                                      color: CustomColors.grey,
                                    )),
                                Text(
                                  "Darren Kevin",
                                  style: CustomTextStyle
                                      .normalRegularStyleDarkGrey,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                //call button
                                Container(
                                    height: 40,
                                    width: 40,
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // border: Border.all(color: ),
                                        color: CustomColors.primary
                                            .withOpacity(0.1)),
                                    child: const Icon(
                                      Icons.call,
                                      color: CustomColors.primary,
                                      size: 20,
                                    )),
                                //message button
                                Container(
                                    height: 40,
                                    width: 40,
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // border: Border.all(color: ),
                                        color: CustomColors.primary
                                            .withOpacity(0.1)),
                                    child: Icon(
                                      Icons.message,
                                      color: CustomColors.primary,
                                      size: 20,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                      //<========== Customer Location
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      color: CustomColors.grey,
                                    )),
                                Text(
                                  "Dubai, Dubai",
                                  style: CustomTextStyle
                                      .normalRegularStyleDarkGrey,
                                ),
                              ],
                            ),
                            Container(
                                height: 40,
                                width: 40,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // border: Border.all(color: ),
                                    color:
                                        CustomColors.primary.withOpacity(0.1)),
                                child: const Icon(
                                  Icons.location_on_outlined,
                                  color: CustomColors.primary,
                                  size: 20,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.fact_check_sharp,
                                color: CustomColors.grey,
                              ),
                            ),
                            Text(
                              "Wiring issue",
                              style: CustomTextStyle.normalRegularStyleDarkGrey,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.manage_search_rounded,
                                color: CustomColors.grey,
                              ),
                            ),
                            Text(
                              "Please check the wiring issue and submit the report",
                              style: CustomTextStyle.normalRegularStyleDarkGrey,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                elevation: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Schedule",
                          style: CustomTextStyle.mediumBoldStyleDarkGrey,
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "14 March at 16:00:00 - 16:30:00",
                          style: CustomTextStyle.normalRegularStyleDarkGrey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 20.0),
                        child: Text(
                          "Arrival window is 16:00 - 16:30",
                          style: CustomTextStyle.normalRegularStyleDarkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Job's Items",
                          style: CustomTextStyle.mediumBoldStyleDarkGrey,
                        ),
                      ),
                      Divider(),
                      Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: CustomColors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    border:
                                        Border.all(color: CustomColors.grey),
                                    color: CustomColors.grey,
                                  ),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            "Services",
                                            style: CustomTextStyle
                                                .mediumBoldStyleWhite,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            "Amount",
                                            style: CustomTextStyle
                                                .mediumBoldStyleWhite,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Wiring issue",
                                                style: CustomTextStyle
                                                    .normalRegularStyleBlack,
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                "Please check the wiring issue and submit the report",
                                                style: CustomTextStyle
                                                    .normalRegularStyleDarkGrey,
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            "\$10",
                                            style: CustomTextStyle
                                                .normalRegularStyleDarkGrey,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Assigned Employees",
                          style: CustomTextStyle.mediumBoldStyleDarkGrey,
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15.0),
                        child: Card(
                          child: ListTile(
                            leading: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/home-improvement/wp-content/uploads/2022/07/download-23.jpg"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            title: Text(
                              "Retest Emp",
                              style: CustomTextStyle.mediumRegularStyleDarkGrey,
                            ),
                            subtitle: Text(
                              "Electrician ",
                              style: CustomTextStyle.normalRegularStyleDarkGrey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
