import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/screen_controller.dart';
import 'package:service/view/my_customer/views/customer_estimate_view.dart';
import 'package:service/view/my_customer/views/customer_info_view.dart';
import 'package:service/view/variables/text_style.dart';

import '../../controller/customer_controller.dart';
import '../../model/customer_details_model.dart';
import '../variables/colors_variable.dart';
import '../widgets/custom_shimmer_effect.dart';
import '../widgets/no_internet_widget.dart';
import '../widgets/profile_Image_widget.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? customerId = Get.arguments;
    return GetBuilder<CustomerController>(
        init: CustomerController(),
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.put(CustomerController()).getCustomerDetails(customerId);
          });
        },
        builder: (customerCtrl) {
          return FutureBuilder(
              future: customerCtrl.customerDetails.value,
              builder: (context, snapshot) {
                if (!snapshot.hasError) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const NoInternetWidget();
                    case ConnectionState.waiting:
                      return const Center(
                          child: CustomShimmerEffect(child: CircleAvatar()));

                    default:
                      CustomerDetailsModel? customerDetails = snapshot.data;
                      return Scaffold(
                        appBar: AppBar(
                          centerTitle: false,
                          titleTextStyle:
                              CustomTextStyle.normalRegularStyleGrey,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const ProfileImageWidget(
                                imageUrl: "",
                                radius: 26,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${customerDetails?.customerDto?.customerFirstName} ${customerDetails?.customerDto?.customerLastName}"
                                        .toUpperCase(),
                                    style:
                                        CustomTextStyle.mediumRegularStyleBlack,
                                  ),
                                  const Text(
                                    "Total Value :",
                                    style:
                                        CustomTextStyle.normalRegularStyleGrey,
                                  ),
                                  const Text(
                                    "Pending Balance :",
                                    style:
                                        CustomTextStyle.normalRegularStyleGrey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          actions: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit_note_sharp))
                          ],
                          bottom: PreferredSize(
                              preferredSize: const Size(double.infinity, 50),
                              child: GetBuilder<ScreenController>(
                                  init: ScreenController(),
                                  builder: (screenCtrl) {
                                    return TabBar(
                                      indicatorColor: CustomColors.primary,
                                      unselectedLabelColor: CustomColors.grey,
                                      controller:
                                          screenCtrl.customerTabController,
                                      labelStyle:
                                          CustomTextStyle.normalBoldStyleBlack,
                                      automaticIndicatorColorAdjustment: true,
                                      labelColor: CustomColors.primary,
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          return states.contains(
                                                  MaterialState.focused)
                                              ? null
                                              : Colors.white;
                                        },
                                      ),
                                      isScrollable: false,
                                      onTap: (value) {
                                        screenCtrl.changeCustomerTabbar(value);
                                      },
                                      tabs: const [
                                        Tab(
                                          text: 'INFO',
                                        ),
                                        Tab(
                                          text: 'ESTIMATES',
                                        ),
                                        Tab(
                                          text: 'JOBS',
                                        ),
                                        Tab(
                                          text: 'DOCS',
                                        ),
                                      ],
                                    );
                                  })),
                        ),
                        body: GetBuilder<ScreenController>(
                            init: ScreenController(),
                            builder: (screenCtrl) {
                              return TabBarView(
                                  controller: screenCtrl.customerTabController,
                                  children: [
                                    CustomerInfoView(
                                        customerDetails: customerDetails),
                                    CustomerEstimateView(
                                      customerDetails: customerDetails,
                                    ),
                                    CustomerEstimateView(
                                      customerDetails: customerDetails,
                                    ),
                                    CustomerEstimateView(
                                      customerDetails: customerDetails,
                                    ),
                                  ]);
                            }),
                      );
                  }
                } else if (snapshot.hasError) {
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.error
                          .toString()
                          .contains("Failed host lookup")) {
                    return const NoInternetWidget();
                  }
                  return Center(child: Text("${snapshot.error}"));
                } else {
                  return const Text("Something went to wrong");
                }
              });
        });
  }
}
