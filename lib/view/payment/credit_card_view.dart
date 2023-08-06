import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:service/services/card_service.dart';
import 'package:service/services/validator_service.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/cupertino_bottom_sheet.dart';
import 'package:service/view/widgets/custom_submit_button.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../controller/payment_controller.dart';
import '../../model/job_report_model.dart';
import '../../services/page_navigation_service.dart';
import '../widgets/custom_company_button.dart';

class CreditCardView extends StatelessWidget {
  final JobReportModel? jobReport;

  const CreditCardView({super.key, this.jobReport});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: GetBuilder<PaymentController>(
          init: PaymentController(),
          builder: (paymentCtrl) {
            return Form(
              key: paymentCtrl.cardPayFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: "Name On Card",
                    controller: paymentCtrl.cardHolderNameCtrl,
                    onChanged: (name) {
                      paymentCtrl.cardDetails.cardHolderName = name;
                      paymentCtrl.update();
                    },
                    validator: ValidatorService.validateSimpleFiled2,
                    suffixIcon: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (buildContext) {
                                return MyCupertinoBottomSheet(
                                  onConfirm: () {},
                                  onCancel: null,
                                  title: const Text(
                                    "Saved Cards",
                                    style: CustomTextStyle.mediumBoldStyleBlack,
                                  ),
                                  child: Column(
                                    children: paymentCtrl.savedCardList
                                        .map((savedCard) {
                                      return Card(
                                        child: ListTile(
                                          leading: Image.asset(
                                              CardServices.getCardCompanyName(
                                                  savedCard.cardNo ?? "")),
                                          title:
                                              Text(savedCard.cardHolderName!),
                                          subtitle: Text(savedCard.cardNo!),
                                          onTap: () {
                                            paymentCtrl
                                                .assignCardData(savedCard);
                                            PageNavigationService.backScreen();
                                          },
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              });
                        },
                        child: Icon(Icons.cases_rounded)),
                  ),
                  CustomTextField(
                    labelText: "Card Number",
                    keyboardType: TextInputType.number,
                    controller: paymentCtrl.cardNumberCtrl,
                    suffixIcon: SizedBox(
                      height: 40,
                      width: 60,
                      child: Image.asset(
                        CardServices.getCardCompanyName(
                            paymentCtrl.cardDetails.cardNo ?? ""),
                        fit: BoxFit.contain,
                      ),
                    ),
                    validator: ValidatorService.validateSimpleFiled,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    onChanged: (value) {
                      paymentCtrl.cardDetails.cardNo = value;
                      paymentCtrl.update();
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: CustomTextField(
                            marginRight: 5,
                            labelText: "Expiry Month",
                            hintText: "mm",
                            keyboardType: TextInputType.number,
                            validator: ValidatorService.validateMonth,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            controller: paymentCtrl.cardExpiryMonthCtrl,
                            onChanged: (month) {
                              paymentCtrl.cardDetails.cardExpiryMonth =
                                  int.parse(month);
                              paymentCtrl.update();
                            },
                          )),
                      Expanded(
                          flex: 1,
                          child: CustomTextField(
                            marginLeft: 5,
                            marginRight: 5,
                            labelText: "Expiry Year",
                            hintText: "yy",
                            keyboardType: TextInputType.number,
                            validator: ValidatorService.validateYear,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            controller: paymentCtrl.cardExpiryYearCtrl,
                            onChanged: (year) {
                              paymentCtrl.cardDetails.cardExpiryYear =
                                  int.parse(year);
                              paymentCtrl.update();
                            },
                          )),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          marginLeft: 5,
                          labelText: "CVC",
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          validator: ValidatorService.validateSimpleFiled,
                          keyboardType: TextInputType.number,
                          controller: paymentCtrl.cardCVCCtrl,
                          onChanged: (cvc) {
                            paymentCtrl.cardDetails.cardCvc = int.parse(cvc);
                            paymentCtrl.update();
                          },
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    readOnly: true,
                    labelText: "Street",
                    validator: ValidatorService.validateSimpleFiled,
                    controller: paymentCtrl.cardStreetCtrl,
                    onTap: () {
                      searchCardAddress();
                    },
                    onChanged: (value) {
                      paymentCtrl.cardDetails.cardBillingStreet = value;
                      paymentCtrl.update();
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          marginRight: 5,
                          labelText: "City",
                          readOnly: true,
                          controller: paymentCtrl.cardCityCtrl,
                          onTap: () {
                            searchCardAddress();
                          },
                          onChanged: (value) {
                            paymentCtrl.cardDetails.cardBillingCity = value;
                            paymentCtrl.update();
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          marginLeft: 5,
                          marginRight: 5,
                          labelText: "State",
                          controller: paymentCtrl.cardStateCtrl,
                          onTap: () {
                            searchCardAddress();
                          },
                          onChanged: (value) {
                            paymentCtrl.cardDetails.cardBillingState = value;
                            paymentCtrl.update();
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          marginLeft: 5,
                          labelText: "Postal Code",
                          controller: paymentCtrl.cardPostCtrl,
                          onTap: () {
                            searchCardAddress();
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          onChanged: (value) {
                            paymentCtrl.cardDetails.cardBillingZip = value;
                            paymentCtrl.update();
                          },
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    labelText: "Payment Note",
                    initialValue: paymentCtrl.paymentDetails.paymentNote ?? "",
                    onChanged: (value) {
                      paymentCtrl.paymentDetails.paymentNote = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              //fillColor: CustomColors.primary,
                              value: paymentCtrl.cardDetails.cardIsSaved,
                              onChanged: (value) {
                                paymentCtrl.cardDetails.cardIsSaved = value!;
                                paymentCtrl.update();
                              }),
                          const Text(
                            "save card info",
                            style: CustomTextStyle.normalRegularStyleBlack,
                          )
                        ],
                      ),
                      CustomSubmitButton(
                          buttonName: "CONFIRM PAYMENT",
                          leftMargin: 5,
                          rightMargin: 5,
                          bottomRightBorderRadius: 0,
                          bottomLeftBorderRadius: 0,
                          topLeftBorderRadius: 0,
                          topRightBorderRadius: 0,
                          fizedSize: const Size(double.infinity, 30),
                          onPressed: () async {
                            await paymentCtrl
                                .submitCardPayment(jobReport!.jobUuid);
                            // .then((value) async {
                            // if (value) {
                            // await paymentCtrl.fetchJobPaymentSummery(
                            //     jobReport!.jobSystemId);
                            // await Get.put(JobController())
                            //     .fetchJobLifeCycle(jobReport!.jobUuid,
                            //         jobReport!.jobOptionId.toString());
                            // await Get.put(JobController())
                            //     .fetchJobReportDetails(jobReport!.jobUuid,
                            //         jobReport!.jobOptionId.toString());
                            //   }
                            // });
                          }),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}

searchCardAddress() {
  return showModalBottomSheet<void>(
      context: Get.context!,
      enableDrag: false,
      isDismissible: false,
      builder: (BuildContext context) {
        return GetBuilder<PaymentController>(
            init: PaymentController(),
            builder: (paymentCtrl) {
              return SizedBox(
                height: Get.height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton.icon(
                            onPressed: () {
                              PageNavigationService.backScreen();
                            },
                            icon: const Icon(Icons.close),
                            label: const Text("Close")),
                      ),
                      CustomTextField(
                        labelText: "Search Address Here",
                        controller: paymentCtrl.searchTextCtrl,
                        suffixIcon: IconButton(
                          onPressed: () {
                            paymentCtrl.getSuggestedAddressList();
                          },
                          icon: const Icon(
                            Icons.search_sharp,
                            size: 36,
                          ),
                        ),
                        onChanged: (value) {
                          paymentCtrl.debouncer.run(() {
                            paymentCtrl.getSuggestedAddressList();
                            //perform search here
                          });
                        },
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            paymentCtrl.suggestedAddressList.isNotEmpty
                                ? SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(10),
                                        itemCount: paymentCtrl
                                            .suggestedAddressList.length,
                                        itemBuilder: (buildContext, index) {
                                          return Card(
                                            child: ListTile(
                                              title: Text(paymentCtrl
                                                      .suggestedAddressList[
                                                  index]!),
                                              onTap: () {
                                                paymentCtrl.searchTextCtrl
                                                    .text = paymentCtrl
                                                        .suggestedAddressList[
                                                    index]!;

                                                paymentCtrl.getAddressDetails();
                                              },
                                            ),
                                          );
                                        }),
                                  )
                                : Container(),
                            paymentCtrl.addressLat != null ||
                                    paymentCtrl.addressLong != null
                                ? Image(
                                    image: StaticMapController(
                                    googleApiKey:
                                        "AIzaSyDfVYnKtLaoJJSFXxCQZ54U4udtIwv4ahk",
                                    width: Get.width.toInt(),
                                    height: (Get.width ~/ 2).toInt(),
                                    zoom: 8,
                                    language: "EN",
                                    visible: [
                                      // Location(
                                      //     double.parse(topicDetails
                                      //             .locationLat!.isNotEmpty
                                      //         ? topicDetails.locationLat!
                                      //         : "0.0"),
                                      //     double.parse(topicDetails
                                      //             .locationLong!.isNotEmpty
                                      //         ? topicDetails.locationLong!
                                      //         : "0.0")),
                                    ],
                                    // maptype: StaticMapType.satellite,
                                    markers: [
                                      Marker(locations: [
                                        Location(
                                          paymentCtrl.addressLat ?? 0.0,
                                          paymentCtrl.addressLong ?? 0.0,
                                        )
                                      ]),
                                    ],
                                    scale: MapScale.scale1,
                                    center: Location(
                                      paymentCtrl.addressLat ?? 0.0,
                                      paymentCtrl.addressLong ?? 0.0,
                                    ),
                                  ).image)
                                : Container(),
                            Align(
                              alignment: Alignment.topRight,
                              child: CustomCompanyButton(
                                  fizedSize: Size(100, 50),
                                  buttonName: "Confirm",
                                  onPressed: () {
                                    PageNavigationService.backScreen();
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      });
}
