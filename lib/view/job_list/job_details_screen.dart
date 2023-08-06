import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

import '../../controller/estimate_controller.dart';
import '../../model/job_grid_model.dart';
import '../../model/service_and_material_item_model.dart';
import '../../services/custom_dialog_class.dart';
import '../../services/page_navigation_service.dart';
import '../widgets/custom_company_button.dart';
import '../widgets/custom_company_button_with_icon.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_textbox.dart';

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
              Get.put(JobController()).fetchJobLifeCycle(
                  jobGridDetails!.jobUuid,
                  jobGridDetails.jobOptionId.toString());
            });
          },
          builder: (jobCtrl) {
            return RefreshIndicator(
              onRefresh: () async {
                await jobCtrl.fetchJobLifeCycle(jobGridDetails!.jobUuid,
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
                                                                                                    Text("\$${double.tryParse(invoice.paymentAmount ?? "0.00")!.toStringAsFixed(2)}", style: CustomTextStyle.normalBoldStyleDarkGrey),
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      GetBuilder<EstimatedController>(
                                          init: EstimatedController(),
                                          builder: (estimatedCtrl) {
                                            //todo
                                            return Column(
                                              children: [
                                                const SizedBox(
                                                  height: 15.0,
                                                ),

                                                Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Column(
                                                      children: [
                                                        const Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            "SERVICES",
                                                            style: CustomTextStyle
                                                                .mediumBoldStyleDarkGrey,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        const Divider(),
                                                        ListView.builder(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            shrinkWrap: true,
                                                            itemCount: estimatedCtrl
                                                                    .estimationDetails!
                                                                    .lineItems
                                                                    ?.where((item) =>
                                                                        item.itemType ==
                                                                        "S")
                                                                    .toList()
                                                                    .length ??
                                                                0,
                                                            itemBuilder:
                                                                (buildContex,
                                                                    index) {
                                                              ServiceandMaterialItemModel
                                                                  serviceItem =
                                                                  estimatedCtrl
                                                                      .estimationDetails!
                                                                      .lineItems!
                                                                      .where((item) =>
                                                                          item.itemType ==
                                                                          "S")
                                                                      .toList()[index];
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            15),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        InkWell(
                                                                            onTap:
                                                                                () {
                                                                              estimatedCtrl.assignDataForEditItemForm(serviceItem);
                                                                              PageNavigationService.generalNavigation('/AddItemFormScreen', arguments: [
                                                                                jobGridDetails!.jobUuid,
                                                                                "S",
                                                                                jobGridDetails.jobOptionId.toString(),
                                                                              ]);
                                                                            },
                                                                            child: Container(
                                                                                padding: const EdgeInsets.all(5),
                                                                                decoration: BoxDecoration(shape: BoxShape.circle, color: CustomColors.primary.withOpacity(0.1)),
                                                                                child: const Icon(
                                                                                  Icons.edit_calendar_outlined,
                                                                                  color: CustomColors.primary,
                                                                                  size: 16,
                                                                                ))),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              await estimatedCtrl.deleteItem(jobGridDetails!.jobUuid, jobGridDetails.jobOptionId.toString(), serviceItem, (double.tryParse(serviceItem.itemQty.toString())! * double.tryParse(serviceItem.itemUnitPrice ?? "0")!).toString());
                                                                            },
                                                                            child: Container(
                                                                                padding: const EdgeInsets.all(5),
                                                                                decoration: BoxDecoration(shape: BoxShape.circle, color: CustomColors.primary.withOpacity(0.1)),
                                                                                child: const Icon(
                                                                                  Icons.delete_outline,
                                                                                  color: CustomColors.primary,
                                                                                  size: 16,
                                                                                ))),
                                                                      ],
                                                                    ),
                                                                    CustomTextBox(
                                                                      label:
                                                                          "Item",
                                                                      text: serviceItem
                                                                          .itemName,
                                                                      topMargin:
                                                                          0,
                                                                    ),
                                                                    CustomTextBox(
                                                                      label:
                                                                          "Description ",
                                                                      text: serviceItem
                                                                          .itemDescription,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              CustomTextBox(
                                                                            label:
                                                                                "Quantity",
                                                                            text:
                                                                                "${serviceItem.itemQty}",
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              CustomTextBox(
                                                                            label:
                                                                                "Unit Price",
                                                                            text:
                                                                                serviceItem.itemUnitPrice,
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              CustomTextBox(
                                                                            label:
                                                                                "Total",
                                                                            text:
                                                                                (double.tryParse(serviceItem.itemQty.toString())! * double.tryParse(serviceItem.itemUnitPrice ?? "0")!).toString(),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    CheckboxListTile(
                                                                      value: serviceItem
                                                                          .itemIsTaxable,
                                                                      onChanged:
                                                                          null,
                                                                      dense:
                                                                          true,
                                                                      contentPadding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              0.0),
                                                                      controlAffinity:
                                                                          ListTileControlAffinity
                                                                              .leading,
                                                                      activeColor:
                                                                          CustomColors
                                                                              .green,
                                                                      title:
                                                                          const Text(
                                                                        "Tax",
                                                                        style: CustomTextStyle
                                                                            .mediumBoldStyleBlack,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    const Divider(
                                                                      color: CustomColors
                                                                          .grey,
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child:
                                                              CustomCompanyButtonWithIcon(
                                                                  buttonName:
                                                                      "ADD SERVICE",
                                                                  topMargin: 0,
                                                                  bottomMargin:
                                                                      0,
                                                                  bottomPadding:
                                                                      0,
                                                                  topPadding: 0,
                                                                  fizedSize:
                                                                      const Size(
                                                                          double
                                                                              .infinity,
                                                                          30),
                                                                  icon: null,
                                                                  isFitted:
                                                                      true,
                                                                  onPressed:
                                                                      () async {
                                                                    //  print(
                                                                    //  "Job Option id ${estimatedCtrl.estimationDetails!.jobDto!.jobUuid}, $jobOptionId}");
                                                                    estimatedCtrl
                                                                        .clearForTextCtrl();
                                                                    print(
                                                                        "object");
                                                                    PageNavigationService.generalNavigation(
                                                                        '/AddItemFormScreen',
                                                                        arguments: [
                                                                          jobGridDetails!
                                                                              .jobUuid,
                                                                          "S",
                                                                          jobGridDetails
                                                                              .jobOptionId
                                                                              .toString(),
                                                                        ]);
                                                                  }),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                //<-============= Material
                                                Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Column(
                                                      children: [
                                                        const Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            "MATERIALS",
                                                            style: CustomTextStyle
                                                                .mediumBoldStyleDarkGrey,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        const Divider(),
                                                        ListView.builder(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            shrinkWrap: true,
                                                            itemCount: estimatedCtrl
                                                                    .estimationDetails!
                                                                    .lineItems
                                                                    ?.where((item) =>
                                                                        item.itemType ==
                                                                        "M")
                                                                    .toList()
                                                                    .length ??
                                                                0,
                                                            itemBuilder:
                                                                (buildContex,
                                                                    index) {
                                                              ServiceandMaterialItemModel
                                                                  materialItem =
                                                                  estimatedCtrl
                                                                      .estimationDetails!
                                                                      .lineItems!
                                                                      .where((item) =>
                                                                          item.itemType ==
                                                                          "M")
                                                                      .toList()[index];
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            15),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        InkWell(
                                                                            onTap:
                                                                                () {
                                                                              estimatedCtrl.assignDataForEditItemForm(materialItem);
                                                                              PageNavigationService.generalNavigation('/AddItemFormScreen', arguments: [
                                                                                jobGridDetails!.jobUuid,
                                                                                "M",
                                                                                jobGridDetails.jobOptionId.toString(),
                                                                              ]);
                                                                            },
                                                                            child: Container(
                                                                                padding: const EdgeInsets.all(5),
                                                                                decoration: BoxDecoration(shape: BoxShape.circle, color: CustomColors.primary.withOpacity(0.1)),
                                                                                child: const Icon(
                                                                                  Icons.edit_calendar_outlined,
                                                                                  color: CustomColors.primary,
                                                                                  size: 16,
                                                                                ))),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              await estimatedCtrl.deleteItem(jobGridDetails!.jobUuid, jobGridDetails.jobOptionId.toString(), materialItem, (double.tryParse(materialItem.itemQty.toString())! * double.tryParse(materialItem.itemUnitPrice ?? "0")!).toString());
                                                                            },
                                                                            child: Container(
                                                                                padding: const EdgeInsets.all(5),
                                                                                decoration: BoxDecoration(shape: BoxShape.circle, color: CustomColors.primary.withOpacity(0.1)),
                                                                                child: const Icon(
                                                                                  Icons.delete_outline,
                                                                                  color: CustomColors.primary,
                                                                                  size: 16,
                                                                                ))),
                                                                      ],
                                                                    ),
                                                                    CustomTextBox(
                                                                      label:
                                                                          "Item",
                                                                      text: materialItem
                                                                          .itemName,
                                                                      topMargin:
                                                                          0,
                                                                    ),
                                                                    CustomTextBox(
                                                                      label:
                                                                          "Description ",
                                                                      text: materialItem
                                                                          .itemDescription,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              CustomTextBox(
                                                                            label:
                                                                                "Quantity",
                                                                            text:
                                                                                "${materialItem.itemQty}",
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              CustomTextBox(
                                                                            label:
                                                                                "Unit Price",
                                                                            text:
                                                                                materialItem.itemUnitPrice,
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              CustomTextBox(
                                                                            label:
                                                                                "Total",
                                                                            text:
                                                                                (double.tryParse(materialItem.itemQty.toString())! * double.tryParse(materialItem.itemUnitPrice ?? "0")!).toString(),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    CheckboxListTile(
                                                                      value: materialItem
                                                                          .itemIsTaxable,
                                                                      onChanged:
                                                                          null,
                                                                      dense:
                                                                          true,
                                                                      contentPadding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              0.0),
                                                                      controlAffinity:
                                                                          ListTileControlAffinity
                                                                              .leading,
                                                                      activeColor:
                                                                          CustomColors
                                                                              .green,
                                                                      title:
                                                                          const Text(
                                                                        "Tax",
                                                                        style: CustomTextStyle
                                                                            .mediumBoldStyleBlack,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    const Divider(
                                                                      color: CustomColors
                                                                          .grey,
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child:
                                                              CustomCompanyButtonWithIcon(
                                                                  buttonName:
                                                                      "ADD MATERIAL",
                                                                  topMargin: 0,
                                                                  bottomMargin:
                                                                      0,
                                                                  bottomPadding:
                                                                      0,
                                                                  topPadding: 0,
                                                                  fizedSize:
                                                                      const Size(
                                                                          double
                                                                              .infinity,
                                                                          30),
                                                                  icon: null,
                                                                  isFitted:
                                                                      true,
                                                                  onPressed:
                                                                      () async {
                                                                    estimatedCtrl
                                                                        .clearForTextCtrl();
                                                                    PageNavigationService.generalNavigation(
                                                                        '/AddItemFormScreen',
                                                                        arguments: [
                                                                          jobGridDetails!
                                                                              .jobUuid,
                                                                          "M",
                                                                          jobGridDetails
                                                                              .jobOptionId
                                                                              .toString(),
                                                                        ]);
                                                                  }),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                Card(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    width: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Text('')),
                                                            const Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  'Service Price',
                                                                  style: CustomTextStyle
                                                                      .mediumRegularStyleBlack,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                )),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  "\$${estimatedCtrl.totalServicePrice}",
                                                                  style: CustomTextStyle
                                                                      .mediumRegularStyleBlack,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ))
                                                          ],
                                                        ),
                                                        const Divider(),
                                                        // const Divider(
                                                        //   height: 2,
                                                        //   thickness: 0,
                                                        //   color: CustomColors.white,
                                                        // ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Text('')),
                                                            const Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  'Material Price',
                                                                  style: CustomTextStyle
                                                                      .mediumRegularStyleBlack,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                )),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  "\$${estimatedCtrl.totalMaterialPrice}",
                                                                  style: CustomTextStyle
                                                                      .mediumRegularStyleBlack,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ))
                                                          ],
                                                        ),
                                                        const Divider(
                                                          thickness: 2.0,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Text('')),
                                                            const Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  'SUB Total',
                                                                  style: CustomTextStyle
                                                                      .mediumRegularStyleBlack,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                )),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  "\$${(estimatedCtrl.totalServicePrice + estimatedCtrl.totalMaterialPrice)}",
                                                                  style: CustomTextStyle
                                                                      .mediumRegularStyleBlack,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ))
                                                          ],
                                                        ),
                                                        const Divider(),
                                                        //Discount
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Text('')),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  InkWell(
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .edit_document,
                                                                      color: CustomColors
                                                                          .primary,
                                                                    ),
                                                                    onTap: () {
                                                                      estimatedCtrl
                                                                          .discountDesTxtCrtl
                                                                          .text = estimatedCtrl
                                                                              .discountDescription ??
                                                                          "";
                                                                      estimatedCtrl
                                                                          .discountAmountTxtCrtl
                                                                          .text = estimatedCtrl
                                                                              .discountAmount ??
                                                                          "";
                                                                      CustomDialogShow
                                                                          .showInformation(
                                                                        title:
                                                                            "Discount",
                                                                        contents: [
                                                                          Text(
                                                                              "Only one type of discount may be applied at a time"),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          StatefulBuilder(builder:
                                                                              (context, setState) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                top: 8.0,
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: estimatedCtrl.discountTypeList.map((discount) {
                                                                                  return Row(
                                                                                    children: [
                                                                                      Radio(
                                                                                        visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                                                                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                        value: discount['id'],
                                                                                        groupValue: estimatedCtrl.selectedDiscount,
                                                                                        onChanged: (value) {
                                                                                          setState(() {
                                                                                            estimatedCtrl.selectedDiscount = value;
                                                                                          });

                                                                                          estimatedCtrl.update();
                                                                                        },
                                                                                      ),
                                                                                      Text("${discount['text']}")
                                                                                    ],
                                                                                  );
                                                                                }).toList(),
                                                                              ),
                                                                            );
                                                                          }),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: CustomTextField(
                                                                                  marginLeft: 0,
                                                                                  marginRight: 5,
                                                                                  minLines: 1,
                                                                                  maxLines: 3,
                                                                                  labelText: "Description (opt.)",
                                                                                  controller: estimatedCtrl.discountDesTxtCrtl,
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: CustomTextField(
                                                                                  marginLeft: 5,
                                                                                  marginRight: 0,
                                                                                  labelText: "Amount",
                                                                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                                                  inputFormatters: [
                                                                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                                                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                                                                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                                                                                  ],
                                                                                  controller: estimatedCtrl.discountAmountTxtCrtl,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                        cancelButtonName:
                                                                            "Delete",
                                                                        btnCancelOnPress:
                                                                            () {
                                                                          estimatedCtrl.discount =
                                                                              0.0;
                                                                          estimatedCtrl.discountAmount =
                                                                              null;
                                                                          estimatedCtrl.discountDescription =
                                                                              null;
                                                                          estimatedCtrl
                                                                              .discountAmountTxtCrtl
                                                                              .clear();
                                                                          estimatedCtrl
                                                                              .discountDesTxtCrtl
                                                                              .clear();

                                                                          estimatedCtrl
                                                                              .update();
                                                                          PageNavigationService
                                                                              .backScreen();
                                                                          estimatedCtrl
                                                                              .updateEstimate(
                                                                            jobGridDetails!.jobUuid,
                                                                            jobGridDetails.jobOptionId.toString(),
                                                                          );
                                                                        },
                                                                        okayButtonName:
                                                                            "Save",
                                                                        btnOkOnPress:
                                                                            () {
                                                                          estimatedCtrl.discountAmount = estimatedCtrl
                                                                              .discountAmountTxtCrtl
                                                                              .text;
                                                                          estimatedCtrl.discountDescription = estimatedCtrl
                                                                              .discountDesTxtCrtl
                                                                              .text;
                                                                          if (estimatedCtrl.selectedDiscount ==
                                                                              "P") {
                                                                            estimatedCtrl.discount =
                                                                                (estimatedCtrl.totalMaterialPrice + estimatedCtrl.totalServicePrice) * (double.parse(estimatedCtrl.discountAmount ?? "0") * 0.01);
                                                                          } else {
                                                                            estimatedCtrl.discount =
                                                                                double.parse(estimatedCtrl.discountAmount ?? "0");
                                                                          }
                                                                          estimatedCtrl
                                                                              .update();
                                                                          estimatedCtrl
                                                                              .updateEstimate(
                                                                            jobGridDetails!.jobUuid,
                                                                            jobGridDetails.jobOptionId.toString(),
                                                                          );
                                                                          PageNavigationService
                                                                              .backScreen();
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      const Text(
                                                                        'Discount',
                                                                        style: CustomTextStyle
                                                                            .mediumRegularStyleBlack,
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                      ),
                                                                      estimatedCtrl.discountAmount != null ||
                                                                              estimatedCtrl.discountAmount != '' ||
                                                                              estimatedCtrl.discountAmount != 0.0
                                                                          ? RichText(
                                                                              text: TextSpan(
                                                                                text: '',
                                                                                style: DefaultTextStyle.of(context).style,
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: estimatedCtrl.discountDescription,
                                                                                    style: CustomTextStyle.normalRegularStyleGrey,
                                                                                  ),
                                                                                  TextSpan(text: " (${estimatedCtrl.discountAmount ?? ""}", style: CustomTextStyle.normalRegularStyleGrey),
                                                                                  TextSpan(
                                                                                      text: estimatedCtrl.selectedDiscount == "P"
                                                                                          ? "%)"
                                                                                          : estimatedCtrl.selectedDiscount == "F"
                                                                                              ? ")"
                                                                                              : "",
                                                                                      style: CustomTextStyle.normalRegularStyleGrey),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  "(-) \$${estimatedCtrl.discount.toStringAsFixed(2)}",
                                                                  style: CustomTextStyle
                                                                      .mediumRegularStyleBlack,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ))
                                                          ],
                                                        ),
                                                        const Divider(),
                                                        //<= Tax

                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            // const Expanded(flex: 1, child: Text('')),
                                                            Expanded(
                                                              flex: 7,
                                                              child:
                                                                  CustomDropDown(
                                                                marginRight: 0,
                                                                label:
                                                                    "Tax Rate",
                                                                labelStyle:
                                                                    CustomTextStyle
                                                                        .mediumRegularStyleBlack,
                                                                value: estimatedCtrl
                                                                    .selectedTaxCategory,
                                                                items: estimatedCtrl
                                                                    .taxCategoryList
                                                                    .map((tax) {
                                                                  return DropdownMenuItem(
                                                                    value: tax[
                                                                        'id'],
                                                                    child: Text(
                                                                        "${tax['text']} (${tax['percent']})"),
                                                                    onTap: () {
                                                                      estimatedCtrl
                                                                              .selectedTaxRate =
                                                                          tax['percent'];
                                                                      estimatedCtrl
                                                                          .calculateTax();
                                                                    },
                                                                  );
                                                                }).toList(),
                                                                onChanged:
                                                                    (value) {
                                                                  estimatedCtrl
                                                                          .selectedTaxCategory =
                                                                      value
                                                                          as int?;
                                                                  estimatedCtrl
                                                                      .update();
                                                                  estimatedCtrl
                                                                      .updateEstimate(
                                                                    jobGridDetails!
                                                                        .jobUuid,
                                                                    jobGridDetails
                                                                        .jobOptionId
                                                                        .toString(),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 3,
                                                                child: Text(
                                                                  "(+) \$${estimatedCtrl.totalTaxAmount}",
                                                                  style: CustomTextStyle
                                                                      .mediumRegularStyleBlack,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ))
                                                          ],
                                                        ),

                                                        const Divider(
                                                          thickness: 2.0,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // const Expanded(flex: 2, child: Text('')),
                                                            const Expanded(
                                                                flex: 7,
                                                                child: Text(
                                                                  'FINAL BILL',
                                                                  style: CustomTextStyle
                                                                      .mediumBoldStyleBlack,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                )),
                                                            Expanded(
                                                                flex: 3,
                                                                child: Text(
                                                                  "\$${(estimatedCtrl.totalServicePrice + estimatedCtrl.totalMaterialPrice - estimatedCtrl.discount + estimatedCtrl.totalTaxAmount)}",
                                                                  style: CustomTextStyle
                                                                      .mediumBoldStyleBlack,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                ))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
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
