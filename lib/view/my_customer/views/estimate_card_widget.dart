import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../model/estimate_grid_model.dart';
import '../../variables/colors_variable.dart';
import '../../variables/text_style.dart';
import '../../widgets/custom_company_button_with_icon.dart';

class EstimateCardWidget extends StatelessWidget {
  // final bool hasDetailButton;
  final void Function()? seeDetailsPressed;
  final EstimateGridModel? estimatedetails;

  const EstimateCardWidget({
    super.key,
    this.estimatedetails,
    // this.hasDetailButton = false,
    this.seeDetailsPressed,
  });

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
                  estimatedetails!.billingCustomerDisplayName ?? "",
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
                        child: Text(
                          "${estimatedetails!.jobSystemNo}",
                          style: CustomTextStyle.normalBoldStyleDarkGrey,
                        )),
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
                estimatedetails!.jobScheduleStartDate != null
                    ? Text(
                        "${DateFormat.yMEd('en').format(
                          DateTime.parse(
                              estimatedetails!.jobScheduleStartDate!),
                        )} ${DateFormat.Hm('en').format(
                          DateTime.parse(
                              estimatedetails!.jobScheduleStartDate!),
                        )}",
                        style: CustomTextStyle.normalRegularStyleDarkGrey,
                      )
                    : Container()
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
                    estimatedetails!.jobAddress ?? "",
                    style: CustomTextStyle.normalRegularStyleDarkGrey,
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
                  estimatedetails!.statusName ?? "",
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
                  Icons.attach_money_outlined,
                  color: CustomColors.darkGrey,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    estimatedetails!.jobFinalBillAmount ?? "",
                    style: CustomTextStyle.normalRegularStyleDarkGrey,
                  ),
                )
              ],
            ),
            // !hasDetailButton
            //     ? Container()
            //     : const Divider(
            //         height: 20,
            //       ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCompanyButtonWithIcon(
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
                  onPressed: seeDetailsPressed,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
