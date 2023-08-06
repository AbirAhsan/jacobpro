import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:service/controller/job_controller.dart';
import 'package:service/controller/payment_controller.dart';
import 'package:service/services/launch_url_services.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/icon_variables.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/cupertino_bottom_sheet.dart';
import 'package:service/view/widgets/custom_appbar.dart';

import '../../model/job_grid_model.dart';
import '../../model/job_report_model.dart';
import '../../services/custom_dialog_class.dart';
import '../../services/page_navigation_service.dart';
import '../widgets/custom_company_button.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JobGridDetailsModel? jobGridDetails = Get.arguments[0];
    final GlobalKey<PaginationViewState>? paginateKey = Get.arguments[1];

    return Scaffold(
      appBar: const CustomAppBar(title: "Job Details"),
      body: GetBuilder<JobController>(
          init: JobController(),
          initState: (state) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await Get.put(PaymentController())
                  .fetchJobPaymentSummery(jobGridDetails!.jobSystemId);
              await Get.put(JobController()).fetchJobReportDetails(
                  jobGridDetails.jobUuid,
                  jobGridDetails.jobOptionId.toString());
              await Get.put(JobController()).fetchJobLifeCycle(
                  jobGridDetails.jobUuid,
                  jobGridDetails.jobOptionId.toString());
            });
          },
          builder: (jobCtrl) {
            return RefreshIndicator(
              onRefresh: () async {
                await Get.put(PaymentController())
                    .fetchJobPaymentSummery(jobGridDetails!.jobSystemId);
                await jobCtrl.fetchJobLifeCycle(jobGridDetails.jobUuid,
                    jobGridDetails.jobOptionId.toString());
                await jobCtrl.fetchJobReportDetails(jobGridDetails.jobUuid,
                    jobGridDetails.jobOptionId.toString());
              },
              child: SingleChildScrollView(
                  child:
                      jobCtrl.jobLifeCycle.isNotEmpty &&
                              jobCtrl.jobReportFutureDetails.value != null
                          ? Column(
                              children: [
                                Padding(
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
                                              // Job Life Cycle
                                              Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 50,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle, // border: Border.all(color: ),
                                                                color: jobCtrl.jobLifeCycle
                                                                            .firstWhereOrNull(
                                                                              (element) => element!.lifecycleStatusName == "OMW",
                                                                            )
                                                                            ?.jobOccuranceStatus ==
                                                                        1
                                                                    ? CustomColors.primary
                                                                    : jobCtrl.jobLifeCycle
                                                                                .firstWhereOrNull(
                                                                                  (element) => element!.lifecycleStatusName == "OMW",
                                                                                )
                                                                                ?.jobOccuranceStatus ==
                                                                            0
                                                                        ? CustomColors.primary.withOpacity(0.1)
                                                                        : CustomColors.darkGrey.withOpacity(0.1)),
                                                            child: IconButton(
                                                              onPressed: jobCtrl
                                                                              .jobLifeCycle
                                                                              .firstWhereOrNull(
                                                                                (element) => element!.lifecycleStatusName == "OMW",
                                                                              )
                                                                              ?.jobOccuranceStatus ==
                                                                          0 &&
                                                                      jobCtrl
                                                                              .jobReportFutureDetails
                                                                              .value!
                                                                              .jobAssociateCurrentStatus !=
                                                                          2
                                                                  ? () {
                                                                      CustomDialogShow.showInfoDialog(
                                                                          title: "Are You Sure?",
                                                                          description: "You're declaring that you're ON THE WAY towards the service location.",
                                                                          okayButtonName: "YES",
                                                                          btnOkOnPress: () async {
                                                                            await jobCtrl.declareLifecycleOnMyWay(
                                                                              jobGridDetails!.jobUuid,
                                                                              jobGridDetails.jobOptionId.toString(),
                                                                            );
                                                                            paginateKey?.currentState!.refresh();
                                                                            PageNavigationService.backScreen();
                                                                          },
                                                                          cancelButtonName: "BACK",
                                                                          btnCancelOnPress: () {
                                                                            PageNavigationService.backScreen();
                                                                          });
                                                                    }
                                                                  : null,
                                                              icon: Icon(
                                                                Icons
                                                                    .car_repair,
                                                                size: 30,
                                                                color: jobCtrl
                                                                            .jobLifeCycle
                                                                            .firstWhereOrNull(
                                                                              (element) => element!.lifecycleStatusName == "OMW",
                                                                            )
                                                                            ?.jobOccuranceStatus ==
                                                                        1
                                                                    ? CustomColors
                                                                        .white
                                                                    : CustomColors
                                                                        .primary,
                                                              ),
                                                            ),
                                                          ),
                                                          const Text(
                                                              "ON MY WAY"),
                                                          Visibility(
                                                            visible: jobCtrl
                                                                    .jobLifeCycle
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
                                                                  children: jobCtrl
                                                                              .jobLifeCycle
                                                                              .firstWhereOrNull(
                                                                                (element) => element!.lifecycleStatusName == "OMW",
                                                                              )
                                                                              ?.jobLifecycleDatetime !=
                                                                          null
                                                                      ? [
                                                                          TextSpan(
                                                                              text: DateFormat.jms('en').format(DateTime.parse(jobCtrl.jobLifeCycle
                                                                                      .firstWhereOrNull(
                                                                                        (element) => element!.lifecycleStatusName == "OMW",
                                                                                      )
                                                                                      ?.jobLifecycleDatetime ??
                                                                                  "")))
                                                                        ]
                                                                      : []),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 50,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle, // border: Border.all(color: ),
                                                                color: jobCtrl.jobLifeCycle
                                                                            .firstWhereOrNull(
                                                                              (element) => element!.lifecycleStatusName == "START",
                                                                            )
                                                                            ?.jobOccuranceStatus ==
                                                                        1
                                                                    ? CustomColors.primary
                                                                    : jobCtrl.jobLifeCycle
                                                                                    .firstWhereOrNull(
                                                                                      (element) => element!.lifecycleStatusName == "START",
                                                                                    )
                                                                                    ?.jobOccuranceStatus ==
                                                                                0 &&
                                                                            jobCtrl.jobLifeCycle
                                                                                    .firstWhereOrNull(
                                                                                      (element) => element!.lifecycleStatusName == "OMW",
                                                                                    )
                                                                                    ?.jobLifecycleDatetime !=
                                                                                null
                                                                        ? CustomColors.primary.withOpacity(0.1)
                                                                        : CustomColors.darkGrey.withOpacity(0.1)),
                                                            child: IconButton(
                                                              onPressed: jobCtrl
                                                                              .jobLifeCycle
                                                                              .firstWhereOrNull(
                                                                                (element) => element!.lifecycleStatusName == "START",
                                                                              )
                                                                              ?.jobOccuranceStatus ==
                                                                          0 &&
                                                                      jobCtrl
                                                                              .jobLifeCycle
                                                                              .firstWhereOrNull(
                                                                                (element) => element!.lifecycleStatusName == "OMW",
                                                                              )
                                                                              ?.jobLifecycleDatetime !=
                                                                          null &&
                                                                      jobCtrl
                                                                              .jobReportFutureDetails
                                                                              .value!
                                                                              .jobAssociateCurrentStatus !=
                                                                          2
                                                                  ? () {
                                                                      CustomDialogShow.showInfoDialog(
                                                                          title: "Are You Sure?",
                                                                          description: "You're going to START the job",
                                                                          okayButtonName: "YES",
                                                                          btnOkOnPress: () async {
                                                                            await jobCtrl.declareLifecycleStart(
                                                                              jobGridDetails!.jobUuid,
                                                                              jobGridDetails.jobOptionId.toString(),
                                                                            );
                                                                            paginateKey?.currentState!.refresh();

                                                                            PageNavigationService.backScreen();
                                                                          },
                                                                          cancelButtonName: "BACK",
                                                                          btnCancelOnPress: () {
                                                                            PageNavigationService.backScreen();
                                                                          });
                                                                    }
                                                                  : null,
                                                              icon: Icon(
                                                                Icons
                                                                    .play_arrow,
                                                                size: 30,
                                                                color: jobCtrl
                                                                            .jobLifeCycle
                                                                            .firstWhereOrNull(
                                                                              (element) => element!.lifecycleStatusName == "START",
                                                                            )
                                                                            ?.jobOccuranceStatus ==
                                                                        1
                                                                    ? CustomColors
                                                                        .white
                                                                    : CustomColors
                                                                        .primary,
                                                              ),
                                                            ),
                                                          ),
                                                          Text("START"),
                                                          Visibility(
                                                            visible: jobCtrl
                                                                    .jobLifeCycle
                                                                    .firstWhereOrNull(
                                                                      (element) =>
                                                                          element
                                                                              ?.lifecycleStatusName ==
                                                                          "START",
                                                                    )
                                                                    ?.jobLifecycleDatetime !=
                                                                null,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: '',
                                                                  style: CustomTextStyle
                                                                      .normalRegularStyleDarkGrey,
                                                                  children: jobCtrl
                                                                              .jobLifeCycle
                                                                              .firstWhereOrNull(
                                                                                (element) => element?.lifecycleStatusName == "START",
                                                                              )
                                                                              ?.jobLifecycleDatetime !=
                                                                          null
                                                                      ? [
                                                                          TextSpan(
                                                                              text: DateFormat.jms('en').format(DateTime.parse(jobCtrl.jobLifeCycle
                                                                                      .firstWhereOrNull(
                                                                                        (element) => element!.lifecycleStatusName == "START",
                                                                                      )!
                                                                                      .jobLifecycleDatetime ??
                                                                                  "")))
                                                                        ]
                                                                      : []),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 50,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle, // border: Border.all(color: ),
                                                                color: jobCtrl.jobLifeCycle
                                                                            .firstWhereOrNull(
                                                                              (element) => element!.lifecycleStatusName == "FINISH",
                                                                            )
                                                                            ?.jobOccuranceStatus ==
                                                                        1
                                                                    ? CustomColors.primary
                                                                    : jobCtrl.jobLifeCycle
                                                                                    .firstWhereOrNull(
                                                                                      (element) => element!.lifecycleStatusName == "FINISH",
                                                                                    )
                                                                                    ?.jobOccuranceStatus ==
                                                                                0 &&
                                                                            jobCtrl.jobLifeCycle
                                                                                    .firstWhereOrNull(
                                                                                      (element) => element!.lifecycleStatusName == "START",
                                                                                    )
                                                                                    ?.jobLifecycleDatetime !=
                                                                                null
                                                                        ? CustomColors.primary.withOpacity(0.1)
                                                                        : CustomColors.darkGrey.withOpacity(0.1)),
                                                            child: IconButton(
                                                              onPressed: jobCtrl
                                                                              .jobLifeCycle
                                                                              .firstWhereOrNull(
                                                                                (element) => element!.lifecycleStatusName == "FINISH",
                                                                              )
                                                                              ?.jobOccuranceStatus ==
                                                                          0 &&
                                                                      jobCtrl
                                                                              .jobLifeCycle
                                                                              .firstWhereOrNull(
                                                                                (element) => element!.lifecycleStatusName == "START",
                                                                              )
                                                                              ?.jobLifecycleDatetime !=
                                                                          null &&
                                                                      jobCtrl
                                                                              .jobReportFutureDetails
                                                                              .value!
                                                                              .jobAssociateCurrentStatus !=
                                                                          2
                                                                  ? () {
                                                                      CustomDialogShow.showInfoDialog(
                                                                          title: "Are You Sure?",
                                                                          description: "You've completed this job and have tricked everything on the scope of work.",
                                                                          okayButtonName: "YES",
                                                                          btnOkOnPress: () async {
                                                                            await jobCtrl.declareLifecycleFinished(
                                                                              jobGridDetails!.jobUuid,
                                                                              jobGridDetails.jobOptionId.toString(),
                                                                            );
                                                                            paginateKey?.currentState!.refresh();
                                                                            PageNavigationService.backScreen();
                                                                          },
                                                                          cancelButtonName: "BACK",
                                                                          btnCancelOnPress: () {
                                                                            PageNavigationService.backScreen();
                                                                          });
                                                                    }
                                                                  : null,
                                                              icon: Icon(
                                                                Icons.stop,
                                                                size: 30,
                                                                color: jobCtrl
                                                                            .jobLifeCycle
                                                                            .firstWhereOrNull(
                                                                              (element) => element!.lifecycleStatusName == "FINISH",
                                                                            )
                                                                            ?.jobOccuranceStatus ==
                                                                        1
                                                                    ? CustomColors
                                                                        .white
                                                                    : CustomColors
                                                                        .primary,
                                                              ),
                                                            ),
                                                          ),
                                                          const Text("FINISH"),
                                                          Visibility(
                                                            visible: jobCtrl
                                                                    .jobLifeCycle
                                                                    .firstWhereOrNull(
                                                                      (element) =>
                                                                          element
                                                                              ?.lifecycleStatusName ==
                                                                          "FINISH",
                                                                    )
                                                                    ?.jobLifecycleDatetime !=
                                                                null,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                  text: '',
                                                                  style: CustomTextStyle
                                                                      .normalRegularStyleDarkGrey,
                                                                  children: jobCtrl
                                                                              .jobLifeCycle
                                                                              .firstWhereOrNull(
                                                                                (element) => element?.lifecycleStatusName == "FINISH",
                                                                              )
                                                                              ?.jobLifecycleDatetime !=
                                                                          null
                                                                      ? [
                                                                          TextSpan(
                                                                              text: DateFormat.jms('en').format(DateTime.parse(jobCtrl.jobLifeCycle
                                                                                      .firstWhereOrNull(
                                                                                        (element) => element!.lifecycleStatusName == "FINISH",
                                                                                      )!
                                                                                      .jobLifecycleDatetime ??
                                                                                  "")))
                                                                        ]
                                                                      : []),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),

                                                  //<============ Pay system
                                                  GetBuilder<PaymentController>(
                                                      init: PaymentController(),
                                                      builder: (paymentCtrl) {
                                                        return Visibility(
                                                          visible: jobCtrl
                                                                  .jobLifeCycle
                                                                  .firstWhereOrNull(
                                                                    (element) =>
                                                                        element
                                                                            ?.lifecycleStatusName ==
                                                                        "FINISH",
                                                                  )
                                                                  ?.jobOccuranceStatus ==
                                                              1,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Flexible(
                                                                child: SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      CustomCompanyButton(
                                                                    topMargin:
                                                                        30,
                                                                    leftMargin:
                                                                        30,
                                                                    rightMargin:
                                                                        30,
                                                                    buttonName:
                                                                        "MAKE PAYMENT",
                                                                    isFitted:
                                                                        false,
                                                                    onPressed:
                                                                        () async {
                                                                      await Get.put(
                                                                              PaymentController())
                                                                          .fetchJobPaymentSummery(
                                                                              jobGridDetails!.jobSystemId);
                                                                      if (double.parse(paymentCtrl.jobPaymentSummery.value!.jobTotalRemainAmount ??
                                                                              "0") >
                                                                          0) {
                                                                        //
                                                                        showCupertinoModalPopup(
                                                                            barrierDismissible:
                                                                                false,
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return MyCupertinoBottomSheet(
                                                                                  title: Text(
                                                                                    "Pay for inspection",
                                                                                    style: CustomTextStyle.titleRegularStyleDarkGrey,
                                                                                  ),
                                                                                  confirmButtonName: "CONTINUE",
                                                                                  onConfirm: () {
                                                                                    //<========== Show bottom modal for payment
                                                                                    paymentCtrl.clearCardText();
                                                                                    paymentCtrl.paymentDetails.paymentNote = '';
                                                                                    PageNavigationService.removeAndNavigate("/PaymentScreen", arguments: jobCtrl.jobReportFutureDetails.value);
                                                                                  },
                                                                                  onCancel: () {
                                                                                    PageNavigationService.backScreen();
                                                                                  },
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Image.asset(
                                                                                          CustomIcons.card,
                                                                                          width: double.infinity,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        "Please choose the payment option for your inspection",
                                                                                        style: CustomTextStyle.normalBoldStyleBlack,
                                                                                      )
                                                                                    ],
                                                                                  ));
                                                                            });
                                                                      } else {
                                                                        CustomDialogShow.showInfoDialog(
                                                                            title:
                                                                                "No payment can be done!",
                                                                            description:
                                                                                "Payment is already done for this job. You can't add more payment.",
                                                                            okayButtonName:
                                                                                "OKAY",
                                                                            btnOkOnPress: () =>
                                                                                PageNavigationService.backScreen());
                                                                      }
                                                                    },
                                                                    fizedSize:
                                                                        const Size(
                                                                            double.infinity,
                                                                            40),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            30.0),
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await paymentCtrl
                                                                              .getPaymentinvoiceList(jobGridDetails!.jobSystemId);

                                                                          CustomDialogShow.showInformation(
                                                                              title: "Payment Information",
                                                                              contents: paymentCtrl.paymentInvoiceList.isNotEmpty
                                                                                  ? paymentCtrl.paymentInvoiceList.map((invoice) {
                                                                                      return Card(
                                                                                        margin: const EdgeInsets.only(bottom: 10),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                            children: [
                                                                                              Flexible(
                                                                                                flex: 3,
                                                                                                child: Column(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Text(invoice.paymentSystemNo ?? "", style: CustomTextStyle.normalBoldStyleDarkGrey),
                                                                                                    Text("${DateFormat.yMEd('en').format(DateTime.parse(invoice.paymentDatetime ?? ""))} at ${DateFormat.jms('en').format(DateTime.parse(invoice.paymentDatetime ?? ""))}", style: CustomTextStyle.normalRegularStyleGrey),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              Flexible(
                                                                                                flex: 1,
                                                                                                child: Column(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                  children: [
                                                                                                    Text("\$${double.tryParse(invoice.paymentAmount ?? "0.00")}", style: CustomTextStyle.normalBoldStyleDarkGrey),
                                                                                                    Text(invoice.paymentMethodName ?? "", style: CustomTextStyle.normalRegularStyleGrey),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    }).toList()
                                                                                  : [const Text("No payment done for this job yet!")],
                                                                              okayButtonName: "Close",
                                                                              btnOkOnPress: () {
                                                                                PageNavigationService.backScreen();
                                                                              });
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .info_outline,
                                                                          size:
                                                                              26,
                                                                        )),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              ),
// Job Report
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
                                                          jobCtrl
                                                                  .jobReportFutureDetails
                                                                  .value!
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
                                                          onTap: () => UrlLauncherService
                                                              .openDialer(jobCtrl
                                                                  .jobReportFutureDetails
                                                                  .value!
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
                                                          onTap: () => UrlLauncherService
                                                              .launchMessage(jobCtrl
                                                                  .jobReportFutureDetails
                                                                  .value!
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
                                                    Flexible(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: Icon(
                                                                Icons
                                                                    .location_on_outlined,
                                                                color:
                                                                    CustomColors
                                                                        .grey,
                                                              )),
                                                          Flexible(
                                                            child: Text(
                                                              jobCtrl
                                                                      .jobReportFutureDetails
                                                                      .value!
                                                                      .customerAddressStreetUnit ??
                                                                  "",
                                                              style: CustomTextStyle
                                                                  .normalRegularStyleDarkGrey,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
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
                                                      jobCtrl
                                                              .jobReportFutureDetails
                                                              .value!
                                                              .coreServiceName ??
                                                          "",
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
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Icon(
                                                        Icons.add_chart,
                                                        color:
                                                            CustomColors.grey,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        jobCtrl
                                                                .jobReportFutureDetails
                                                                .value!
                                                                .jobPrivateNote ??
                                                            "",
                                                        style: CustomTextStyle
                                                            .normalRegularStyleDarkGrey,
                                                      ),
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
                                                  jobCtrl
                                                              .jobReportFutureDetails
                                                              .value!
                                                              .jobScheduleStartDate !=
                                                          null
                                                      ? "${DateFormat.yMEd('en').format(DateTime.parse(jobCtrl.jobReportFutureDetails.value!.jobScheduleStartDate ?? ""))} at ${DateFormat.Hm('en').format(DateTime.parse(jobCtrl.jobReportFutureDetails.value!.jobScheduleStartDate ?? ""))}"
                                                      : "",
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
                                                          child: const Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 3,
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
                                                                flex: 2,
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
                                                                    itemCount: jobCtrl
                                                                            .jobReportFutureDetails
                                                                            .value!
                                                                            .jobItems
                                                                            ?.length ??
                                                                        0,
                                                                    physics:
                                                                        const NeverScrollableScrollPhysics(),
                                                                    itemBuilder:
                                                                        (buildContext,
                                                                            index) {
                                                                      JobItems jobItem = jobCtrl
                                                                          .jobReportFutureDetails
                                                                          .value!
                                                                          .jobItems![index];
                                                                      return Row(
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                5,
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
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(15.0),
                                                                              child: Text(
                                                                                "\$${double.tryParse(jobItem.itemUnitPrice ?? "0")! * double.tryParse(jobItem.itemQty ?? "0")!}",
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
                                ),
                              ],
                            )
                          : Container(
                              height: Get.height,
                              width: Get.width,
                              padding: const EdgeInsets.all(15.0),
                              child: Card(
                                child: Container(
                                  height: Get.height,
                                  width: Get.width,
                                ),
                              ),
                            )),
            );
          }),
    );
  }
}
