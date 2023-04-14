import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/job_controller.dart';
import 'package:service/services/launch_url_services.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/icon_variables.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/cupertino_bottom_sheet.dart';
import 'package:service/view/widgets/custom_appbar.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../model/job_grid_model.dart';
import '../../model/job_report_model.dart';
import '../../services/custom_dialog_class.dart';
import '../../services/page_navigation_service.dart';
import '../widgets/custom_collapsed_widget.dart';
import '../widgets/no_internet_widget.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JobGridDetailsModel? jobGridDetails = Get.arguments;

    return Scaffold(
      appBar: const CustomAppBar(title: "Job Details"),
      body: GetBuilder<JobController>(
          init: JobController(),
          initState: (state) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await Get.put(JobController())
                  .fetchJobLifeCycle(jobGridDetails!.jobUuid);
              await Get.put(JobController())
                  .fetchJobReportDetails(jobGridDetails.jobUuid);
            });
          },
          builder: (jobCtrl) {
            return RefreshIndicator(
              onRefresh: () async {
                await jobCtrl.fetchJobLifeCycle(jobGridDetails!.jobUuid);
                await jobCtrl.fetchJobReportDetails(jobGridDetails.jobUuid);
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder(
                        future: jobCtrl.jobLifeCycle.value,
                        builder: (context, snapshot) {
                          if (!snapshot.hasError) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return const NoInternetWidget();
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                              default:
                                return Card(
                                  margin: const EdgeInsets.all(15.0),
                                  child: CustomCollapsibleWidget(
                                    name: "Which Date Here ?",
                                    textStyle:
                                        CustomTextStyle.mediumBoldStylePrimary,
                                    initiallyCollapsed: false,
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape
                                                          .circle, // border: Border.all(color: ),
                                                      color: snapshot.data!
                                                                  .firstWhereOrNull(
                                                                    (element) =>
                                                                        element!
                                                                            .lifecycleStatusName ==
                                                                        "OMW",
                                                                  )
                                                                  ?.jobOccuranceStatus ==
                                                              1
                                                          ? CustomColors.primary
                                                          : snapshot.data!
                                                                      .firstWhereOrNull(
                                                                        (element) =>
                                                                            element!.lifecycleStatusName ==
                                                                            "OMW",
                                                                      )
                                                                      ?.jobOccuranceStatus ==
                                                                  0
                                                              ? CustomColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.1)
                                                              : CustomColors
                                                                  .darkGrey
                                                                  .withOpacity(
                                                                      0.1)),
                                                  child: IconButton(
                                                    onPressed: snapshot.data!
                                                                .firstWhereOrNull(
                                                                  (element) =>
                                                                      element!
                                                                          .lifecycleStatusName ==
                                                                      "OMW",
                                                                )
                                                                ?.jobOccuranceStatus ==
                                                            0
                                                        ? () {
                                                            CustomDialogShow
                                                                .showInfoDialog(
                                                                    title:
                                                                        "Confirm",
                                                                    description:
                                                                        "Are You sure that you have OMW this job ?",
                                                                    okayButtonName:
                                                                        "YES",
                                                                    btnOkOnPress:
                                                                        () async {
                                                                      await jobCtrl.gotoNextJobLifeCycle(
                                                                          jobGridDetails!
                                                                              .jobSystemId,
                                                                          jobGridDetails
                                                                              .jobUuid,
                                                                          12);
                                                                      PageNavigationService
                                                                          .backScreen();
                                                                    },
                                                                    cancelButtonName:
                                                                        "BACK",
                                                                    btnCancelOnPress:
                                                                        () {
                                                                      PageNavigationService
                                                                          .backScreen();
                                                                    });
                                                          }
                                                        : null,
                                                    icon: Icon(
                                                      Icons.car_repair,
                                                      size: 40,
                                                      color: snapshot.data!
                                                                  .firstWhereOrNull(
                                                                    (element) =>
                                                                        element!
                                                                            .lifecycleStatusName ==
                                                                        "OMW",
                                                                  )
                                                                  ?.jobOccuranceStatus ==
                                                              1
                                                          ? CustomColors.white
                                                          : CustomColors
                                                              .primary,
                                                    ),
                                                  ),
                                                ),
                                                Text("ON MY WAY"),
                                                Visibility(
                                                  visible: snapshot.data!
                                                          .firstWhereOrNull(
                                                            (element) =>
                                                                element
                                                                    ?.lifecycleStatusName ==
                                                                "OMW",
                                                          )
                                                          ?.jobLifecycleDatetime !=
                                                      null,
                                                  child: RichText(
                                                    text: TextSpan(
                                                        text: '',
                                                        style: CustomTextStyle
                                                            .normalRegularStyleDarkGrey,
                                                        children: snapshot.data!
                                                                    .firstWhereOrNull(
                                                                      (element) =>
                                                                          element!
                                                                              .lifecycleStatusName ==
                                                                          "OMW",
                                                                    )
                                                                    ?.jobLifecycleDatetime !=
                                                                null
                                                            ? [
                                                                TextSpan(
                                                                    text: DateFormat.jms('en').format(DateTime.parse(snapshot
                                                                            .data!
                                                                            .firstWhereOrNull(
                                                                              (element) => element!.lifecycleStatusName == "OMW",
                                                                            )
                                                                            ?.jobLifecycleDatetime ??
                                                                        "")))
                                                              ]
                                                            : []),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape
                                                          .circle, // border: Border.all(color: ),
                                                      color: snapshot.data!
                                                                  .firstWhereOrNull(
                                                                    (element) =>
                                                                        element!
                                                                            .lifecycleStatusName ==
                                                                        "Start",
                                                                  )
                                                                  ?.jobOccuranceStatus ==
                                                              1
                                                          ? CustomColors.primary
                                                          : snapshot.data!
                                                                      .firstWhereOrNull(
                                                                        (element) =>
                                                                            element!.lifecycleStatusName ==
                                                                            "Start",
                                                                      )
                                                                      ?.jobOccuranceStatus ==
                                                                  0
                                                              ? CustomColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.1)
                                                              : CustomColors
                                                                  .darkGrey
                                                                  .withOpacity(
                                                                      0.1)),
                                                  child: IconButton(
                                                    onPressed: snapshot.data!
                                                                .firstWhereOrNull(
                                                                  (element) =>
                                                                      element!
                                                                          .lifecycleStatusName ==
                                                                      "Start",
                                                                )
                                                                ?.jobOccuranceStatus ==
                                                            0
                                                        ? () {
                                                            CustomDialogShow
                                                                .showInfoDialog(
                                                                    title:
                                                                        "Confirm",
                                                                    description:
                                                                        "Do you confirm to start the job ?",
                                                                    okayButtonName:
                                                                        "YES",
                                                                    btnOkOnPress:
                                                                        () async {
                                                                      await jobCtrl.gotoNextJobLifeCycle(
                                                                          jobGridDetails!
                                                                              .jobSystemId,
                                                                          jobGridDetails
                                                                              .jobUuid,
                                                                          13);
                                                                      PageNavigationService
                                                                          .backScreen();
                                                                    },
                                                                    cancelButtonName:
                                                                        "BACK",
                                                                    btnCancelOnPress:
                                                                        () {
                                                                      PageNavigationService
                                                                          .backScreen();
                                                                    });
                                                          }
                                                        : null,
                                                    icon: Icon(
                                                      Icons.play_arrow,
                                                      size: 40,
                                                      color: snapshot.data!
                                                                  .firstWhereOrNull(
                                                                    (element) =>
                                                                        element!
                                                                            .lifecycleStatusName ==
                                                                        "Start",
                                                                  )
                                                                  ?.jobOccuranceStatus ==
                                                              1
                                                          ? CustomColors.white
                                                          : CustomColors
                                                              .primary,
                                                    ),
                                                  ),
                                                ),
                                                Text("START"),
                                                Visibility(
                                                  visible: snapshot.data!
                                                          .firstWhereOrNull(
                                                            (element) =>
                                                                element
                                                                    ?.lifecycleStatusName ==
                                                                "Start",
                                                          )
                                                          ?.jobLifecycleDatetime !=
                                                      null,
                                                  child: RichText(
                                                    text: TextSpan(
                                                        text: '',
                                                        style: CustomTextStyle
                                                            .normalRegularStyleDarkGrey,
                                                        children: snapshot.data!
                                                                    .firstWhereOrNull(
                                                                      (element) =>
                                                                          element
                                                                              ?.lifecycleStatusName ==
                                                                          "Start",
                                                                    )
                                                                    ?.jobLifecycleDatetime !=
                                                                null
                                                            ? [
                                                                TextSpan(
                                                                    text: DateFormat.jms('en').format(DateTime.parse(snapshot
                                                                            .data!
                                                                            .firstWhereOrNull(
                                                                              (element) => element!.lifecycleStatusName == "Start",
                                                                            )!
                                                                            .jobLifecycleDatetime ??
                                                                        "")))
                                                              ]
                                                            : []),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape
                                                          .circle, // border: Border.all(color: ),
                                                      color: snapshot.data!
                                                                  .firstWhereOrNull(
                                                                    (element) =>
                                                                        element!
                                                                            .lifecycleStatusName ==
                                                                        "Finished",
                                                                  )
                                                                  ?.jobOccuranceStatus ==
                                                              1
                                                          ? CustomColors.primary
                                                          : snapshot.data!
                                                                      .firstWhereOrNull(
                                                                        (element) =>
                                                                            element!.lifecycleStatusName ==
                                                                            "Finished",
                                                                      )
                                                                      ?.jobOccuranceStatus ==
                                                                  0
                                                              ? CustomColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.1)
                                                              : CustomColors
                                                                  .darkGrey
                                                                  .withOpacity(
                                                                      0.1)),
                                                  child: IconButton(
                                                    onPressed: snapshot.data!
                                                                .firstWhereOrNull(
                                                                  (element) =>
                                                                      element!
                                                                          .lifecycleStatusName ==
                                                                      "Finished",
                                                                )
                                                                ?.jobOccuranceStatus ==
                                                            0
                                                        ? () {
                                                            showCupertinoModalPopup(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return MyCupertinoBottomSheet(
                                                                      title:
                                                                          "Pay for inspection",
                                                                      confirmButtonName:
                                                                          "CONTINUE",
                                                                      onConfirm:
                                                                          () {
                                                                        //<========== Show bottom modal for payment
                                                                        PageNavigationService.removeAndNavigate(
                                                                            "/PaymentScreen");
                                                                      },
                                                                      onCancel:
                                                                          () {
                                                                        PageNavigationService
                                                                            .backScreen();
                                                                      },
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            CustomIcons.card,
                                                                            width:
                                                                                double.infinity,
                                                                          ),
                                                                          Text(
                                                                              "Please choose the payment option for your inspection")
                                                                        ],
                                                                      ));
                                                                });

                                                            // CustomDialogShow
                                                            //     .showInfoDialog(
                                                            //         title:
                                                            //             "Confirm",
                                                            //         description:
                                                            //             "Are You sure that you have complete this job and have tricked everything on the scope of work?",
                                                            //         okayButtonName:
                                                            //             "YES",
                                                            //         btnOkOnPress:
                                                            //             () async {
                                                            //           await jobCtrl
                                                            //               .gotoNextJobLifeCycle(
                                                            //                   jobGridDetails!.jobSystemId,
                                                            //                   jobGridDetails.jobUuid,
                                                            //                   14)
                                                            //               .then((resp) {
                                                            //             if (resp) {

                                                            //             }
                                                            //           });
                                                            //           PageNavigationService
                                                            //               .backScreen();
                                                            //         },
                                                            //         cancelButtonName:
                                                            //             "BACK",
                                                            //         btnCancelOnPress:
                                                            //             () {
                                                            //           PageNavigationService
                                                            //               .backScreen();
                                                            //         });
                                                          }
                                                        : null,
                                                    icon: Icon(
                                                      Icons.stop,
                                                      size: 40,
                                                      color: snapshot.data!
                                                                  .firstWhereOrNull(
                                                                    (element) =>
                                                                        element!
                                                                            .lifecycleStatusName ==
                                                                        "Finished",
                                                                  )
                                                                  ?.jobOccuranceStatus ==
                                                              1
                                                          ? CustomColors.white
                                                          : CustomColors
                                                              .primary,
                                                    ),
                                                  ),
                                                ),
                                                Text("FINISH"),
                                                Visibility(
                                                  visible: snapshot.data!
                                                          .firstWhereOrNull(
                                                            (element) =>
                                                                element
                                                                    ?.lifecycleStatusName ==
                                                                "Finished",
                                                          )
                                                          ?.jobLifecycleDatetime !=
                                                      null,
                                                  child: RichText(
                                                    text: TextSpan(
                                                        text: '',
                                                        style: CustomTextStyle
                                                            .normalRegularStyleDarkGrey,
                                                        children: snapshot.data!
                                                                    .firstWhereOrNull(
                                                                      (element) =>
                                                                          element
                                                                              ?.lifecycleStatusName ==
                                                                          "Finished",
                                                                    )
                                                                    ?.jobLifecycleDatetime !=
                                                                null
                                                            ? [
                                                                TextSpan(
                                                                    text: DateFormat.jms('en').format(DateTime.parse(snapshot
                                                                            .data!
                                                                            .firstWhereOrNull(
                                                                              (element) => element!.lifecycleStatusName == "Finished",
                                                                            )!
                                                                            .jobLifecycleDatetime ??
                                                                        "")))
                                                              ]
                                                            : []),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                            }
                          } else if (snapshot.hasError) {
                            if (snapshot.connectionState ==
                                    ConnectionState.none ||
                                snapshot.error
                                    .toString()
                                    .contains("Failed host lookup")) {
                              return const NoInternetWidget();
                            }
                            return Center(child: Text("${snapshot.error}"));
                          } else {
                            return const Text("Something went to wrong");
                          }
                        }),
                    FutureBuilder(
                        future: jobCtrl.jobReportFutureDetails.value,
                        builder: (context, snapshot) {
                          if (!snapshot.hasError) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return const NoInternetWidget();
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                              default:
                                JobReportModel? jobReportDetails =
                                    snapshot.data;
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: Text(
                                                  "Customer",
                                                  style: CustomTextStyle
                                                      .mediumBoldStyleDarkGrey,
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
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: Icon(
                                                              Icons.person,
                                                              color:
                                                                  CustomColors
                                                                      .grey,
                                                            )),
                                                        Text(
                                                          jobReportDetails!
                                                                  .customerDisplayName ??
                                                              "",
                                                          style: CustomTextStyle
                                                              .normalRegularStyleDarkGrey,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        //call button
                                                        InkWell(
                                                          onTap: () => UrlLauncherServie
                                                              .openDialer(
                                                                  jobReportDetails
                                                                      .customerContactNo!),
                                                          child: Container(
                                                              height: 40,
                                                              width: 40,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle, // border: Border.all(color: ),
                                                                      color: CustomColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.1)),
                                                              child: const Icon(
                                                                Icons.call,
                                                                color:
                                                                    CustomColors
                                                                        .primary,
                                                                size: 20,
                                                              )),
                                                        ),
                                                        //message button
                                                        InkWell(
                                                          onTap: () => UrlLauncherServie
                                                              .launchMessage(
                                                                  jobReportDetails
                                                                      .customerContactNo!),
                                                          child: Container(
                                                              height: 40,
                                                              width: 40,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle, // border: Border.all(color: ),
                                                                      color: CustomColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.1)),
                                                              child: const Icon(
                                                                Icons.message,
                                                                color:
                                                                    CustomColors
                                                                        .primary,
                                                                size: 20,
                                                              )),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              //<========== Customer Location
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: Icon(
                                                              Icons
                                                                  .location_on_outlined,
                                                              color:
                                                                  CustomColors
                                                                      .grey,
                                                            )),
                                                        Text(
                                                          jobReportDetails
                                                                  .customerAddressStreetUnit ??
                                                              "",
                                                          style: CustomTextStyle
                                                              .normalRegularStyleDarkGrey,
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                        height: 40,
                                                        width: 40,
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle, // border: Border.all(color: ),
                                                                color: CustomColors
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.1)),
                                                        child: const Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          color: CustomColors
                                                              .primary,
                                                          size: 20,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Icon(
                                                        Icons.fact_check_sharp,
                                                        color:
                                                            CustomColors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      "jobReportDetails.jo,",
                                                      style: CustomTextStyle
                                                          .normalRegularStyleDarkGrey,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: const [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Icon(
                                                        Icons
                                                            .manage_search_rounded,
                                                        color:
                                                            CustomColors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Which property should be bind here",
                                                      style: CustomTextStyle
                                                          .normalRegularStyleDarkGrey,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: Text(
                                                  "Schedule",
                                                  style: CustomTextStyle
                                                      .mediumBoldStyleDarkGrey,
                                                ),
                                              ),
                                              const Divider(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  "${DateFormat.yMEd('en').format(DateTime.parse(jobReportDetails.jobScheduleStartDate ?? ""))} at ${DateFormat.Hm('en').format(DateTime.parse(jobReportDetails.jobScheduleStartDate ?? ""))}",
                                                  style: CustomTextStyle
                                                      .normalRegularStyleDarkGrey,
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: EdgeInsets.only(
                                              //       left: 15.0,
                                              //       right: 15.0,
                                              //       bottom: 20.0),
                                              //   child: Text(
                                              //     "Arrival window is 16:00 - 16:30",
                                              //     style: CustomTextStyle
                                              //         .normalRegularStyleDarkGrey,
                                              //   ),
                                              // ),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: Text(
                                                  "Job's Items",
                                                  style: CustomTextStyle
                                                      .mediumBoldStyleDarkGrey,
                                                ),
                                              ),
                                              Divider(),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: CustomColors
                                                                .grey),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                            ),
                                                            border: Border.all(
                                                                color:
                                                                    CustomColors
                                                                        .grey),
                                                            color: CustomColors
                                                                .grey,
                                                          ),
                                                          child: Row(
                                                            children: const [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              15.0),
                                                                  child: Text(
                                                                    "Services & Materials",
                                                                    style: CustomTextStyle
                                                                        .mediumBoldStyleWhite,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              15.0),
                                                                  child: Text(
                                                                    "Amount",
                                                                    style: CustomTextStyle
                                                                        .mediumBoldStyleWhite,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: ListView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount: jobReportDetails
                                                                            .jobItems
                                                                            ?.length ??
                                                                        0,
                                                                    itemBuilder:
                                                                        (buildContext,
                                                                            index) {
                                                                      JobItems
                                                                          jobItem =
                                                                          jobReportDetails
                                                                              .jobItems![index];
                                                                      return Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(15.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    jobItem.itemName ?? "",
                                                                                    style: CustomTextStyle.normalRegularStyleBlack,
                                                                                    textAlign: TextAlign.start,
                                                                                  ),
                                                                                  Text(
                                                                                    jobItem.itemDescription ?? "",
                                                                                    style: CustomTextStyle.normalRegularStyleDarkGrey,
                                                                                    textAlign: TextAlign.start,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(15.0),
                                                                              child: Text(
                                                                                "\$${jobItem.itemSUBTotal}",
                                                                                style: CustomTextStyle.normalRegularStyleDarkGrey,
                                                                                textAlign: TextAlign.end,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    })),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: Text(
                                                  "Assigned Employees",
                                                  style: CustomTextStyle
                                                      .mediumBoldStyleDarkGrey,
                                                ),
                                              ),
                                              Divider(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15, right: 15.0),
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
                                                      style: CustomTextStyle
                                                          .mediumRegularStyleDarkGrey,
                                                    ),
                                                    subtitle: Text(
                                                      "Electrician ",
                                                      style: CustomTextStyle
                                                          .normalRegularStyleDarkGrey,
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
                                );
                            }
                          } else if (snapshot.hasError) {
                            if (snapshot.connectionState ==
                                    ConnectionState.none ||
                                snapshot.error
                                    .toString()
                                    .contains("Failed host lookup")) {
                              return const NoInternetWidget();
                            }
                            return Center(child: Text("${snapshot.error}"));
                          } else {
                            return const Text("Something went to wrong");
                          }
                        }),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
