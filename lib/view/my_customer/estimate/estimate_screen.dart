import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/estimate_controller.dart';
import '../../variables/text_style.dart';

class EstimateScreen extends StatelessWidget {
  const EstimateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? jobUuid = Get.arguments;

    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<EstimatedController>(
            init: EstimatedController(),
            initState: (state) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.put(EstimatedController()).fetchEstimationDetails(jobUuid);
              });
            },
            builder: (estimatedCtrl) {
              return Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "SERVICES",
                      style: CustomTextStyle.mediumBoldStyleDarkGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Divider(),
                ],
              );
            }),
      ),
    );
  }
}
