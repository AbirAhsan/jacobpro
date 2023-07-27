import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:service/services/custom_dialog_class.dart';
import 'package:service/services/page_navigation_service.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_company_button.dart';
import 'package:service/view/widgets/custom_company_button_with_icon.dart';

import '../../controller/job_controller.dart';
import '../../model/job_grid_model.dart';
import '../../model/job_report_model.dart';

class JobCardWidget extends StatelessWidget {
  final GlobalKey<PaginationViewState>? paginateKey;
  final bool hasDetailButton;
  final bool hasRejectButton;
  final bool hasAcceptButton;
  final bool showInspection;
  final JobGridDetailsModel? jobdetails;
  const JobCardWidget(
      {super.key,
      this.jobdetails,
      this.paginateKey,
      this.hasDetailButton = false,
      this.hasRejectButton = false,
      this.hasAcceptButton = false,
      this.showInspection = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  jobdetails!.customerDisplayName ?? "",
                  style: CustomTextStyle.mediumBoldStyleDarkGrey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CustomColors.green.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: const Text(
                          "5 miles",
                          style: CustomTextStyle.normalBoldStyleDarkGrey,
                        )),
                    Visibility(
                      visible: showInspection,
                      child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: CustomColors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: const Text(
                            "inspection",
                            style: CustomTextStyle.normalBoldStyleWhite,
                          )),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              height: 20,
            ),

//Date

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: CustomColors.darkGrey,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  jobdetails!.jobScheduleStartDate != null
                      ? "${DateFormat.yMEd('en').format(
                          DateTime.parse(
                              jobdetails!.jobScheduleStartDate ?? ""),
                        )} ${DateFormat.Hm('en').format(
                          DateTime.parse(
                              jobdetails!.jobScheduleStartDate ?? ""),
                        )}"
                      : "",
                  style: CustomTextStyle.normalRegularStyleDarkGrey,
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // Location
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: CustomColors.darkGrey,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    jobdetails!.jobAddress ?? "",
                    style: CustomTextStyle.normalRegularStyleDarkGrey,
                    // overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.note_add_outlined,
                  color: CustomColors.darkGrey,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  jobdetails!.coreServiceName ?? "",
                  style: CustomTextStyle.normalRegularStyleDarkGrey,
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.add_chart,
                  color: CustomColors.darkGrey,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    jobdetails!.jobPrivateNote ?? "",
                    style: CustomTextStyle.normalRegularStyleDarkGrey,
                  ),
                )
              ],
            ),
            !hasAcceptButton && !hasRejectButton && !hasDetailButton
                ? Container()
                : const Divider(
                    height: 20,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: CustomColors.green.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Text(
                      jobdetails!.jobSystemNo ?? "",
                      style: CustomTextStyle.smallBoldStyleDarkGrey,
                    )),
                GetBuilder<JobController>(
                    init: JobController(),
                    builder: (jobCtrl) {
                      return Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: hasDetailButton,
                              child: CustomCompanyButtonWithIcon(
                                  leftMargin: 10,
                                  topPadding: 0,
                                  topMargin: 0,
                                  bottomMargin: 0,
                                  bottomPadding: 0,
                                  bottomLeftBorderRadius: 0,
                                  bottomRightBorderRadius: 0,
                                  topLeftBorderRadius: 0,
                                  topRightBorderRadius: 0,
                                  fizedSize: const Size(120, 30),
                                  buttonName: "SEE DETAIL",
                                  onPressed: () {
                                    jobCtrl.jobReportFutureDetails.value =
                                        JobReportModel();
                                    jobCtrl.jobLifeCycle.value = [];
                                    PageNavigationService.generalNavigation(
                                        '/JobDetailsScreen',
                                        arguments: jobdetails);
                                  }),
                            ),
                            Visibility(
                              visible: hasRejectButton,
                              child: CustomCompanyButton(
                                  leftMargin: 10,
                                  topPadding: 0,
                                  topMargin: 0,
                                  bottomMargin: 0,
                                  bottomPadding: 0,
                                  bottomLeftBorderRadius: 0,
                                  bottomRightBorderRadius: 0,
                                  topLeftBorderRadius: 0,
                                  topRightBorderRadius: 0,
                                  fizedSize: const Size(80, 30),
                                  primaryColor: CustomColors.error,
                                  borderColor: CustomColors.error,
                                  buttonName: "REJECT",
                                  onPressed: () {
                                    CustomDialogShow.showInfoDialog(
                                        title: "Warning!",
                                        description:
                                            "If you confirm, you'll no longer be able to work on this job.",
                                        cancelButtonName: "BACK",
                                        btnCancelOnPress: () {
                                          PageNavigationService.backScreen();
                                        },
                                        okayButtonName: "CONFIRM",
                                        btnOkOnPress: () async {
                                          await jobCtrl
                                              .acceptOrRejectPendingJob(
                                                  jobdetails!.jobSystemId, 0);
                                          await jobCtrl.fetchJobCount();
                                          paginateKey?.currentState!.refresh();
                                          PageNavigationService.backScreen();
                                        });
                                  }),
                            ),
                            Visibility(
                              visible: hasAcceptButton,
                              child: CustomCompanyButton(
                                  leftMargin: 10,
                                  topPadding: 0,
                                  topMargin: 0,
                                  bottomMargin: 0,
                                  bottomPadding: 0,
                                  fizedSize: const Size(80, 30),
                                  bottomLeftBorderRadius: 0,
                                  bottomRightBorderRadius: 0,
                                  topLeftBorderRadius: 0,
                                  topRightBorderRadius: 0,
                                  primaryColor: CustomColors.green,
                                  borderColor: CustomColors.green,
                                  buttonName: "ACCEPT",
                                  onPressed: () async {
                                    await jobCtrl.acceptOrRejectPendingJob(
                                        jobdetails!.jobSystemId, 1);
                                    await jobCtrl.fetchJobCount();
                                    paginateKey?.currentState!.refresh();
                                  }),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
