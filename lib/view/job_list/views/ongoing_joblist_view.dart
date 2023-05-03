import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/job_controller.dart';

import '../job_card_widget.dart';

class OngoingJobView extends StatelessWidget {
  const OngoingJobView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobController>(
        init: JobController(),
        initState: (state) {
          Get.put(JobController()).fetchOngoingJobList();
        },
        builder: (jobCtrl) {
          return RefreshIndicator(
            onRefresh: () async {
              await jobCtrl.fetchJobCount();

              await jobCtrl.fetchOngoingJobList();
            },
            child: ListView.builder(
                itemCount: jobCtrl.ongoingJobList.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (BuildContext buildContext, index) {
                  return JobCardWidget(
                    hasDetailButton: true,
                    jobdetails: jobCtrl.ongoingJobList[index],
                  );
                }),
          );
        });
  }
}


// class AssignedTabView extends StatelessWidget {
//   const AssignedTabView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 10,
//         padding: const EdgeInsets.all(15.0),
//         itemBuilder: (BuildContext buildContext, index) {
//           return Card(
//             elevation: 5,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Mon, 14, Mar",
//                         style: CustomTextStyle.mediumRegularStyleDarkGrey,
//                       ),
//                       IconButton(
//                           onPressed: () {}, icon: Icon(Icons.more_horiz_sharp))
//                     ],
//                   ),
//                 ),
//                 IntrinsicHeight(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                           flex: 4,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Padding(
//                                 padding:
//                                     EdgeInsets.only(left: 10, bottom: 10.0),
//                                 child: Text(
//                                   "9:00",
//                                   style: CustomTextStyle.mediumBoldStyleBlack,
//                                 ),
//                               ),
//                               const Padding(
//                                 padding:
//                                     EdgeInsets.only(left: 10, bottom: 10.0),
//                                 child: Text(
//                                   "5.0736 miles",
//                                   style: CustomTextStyle
//                                       .normalRegularStyleDarkGrey,
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   PageNavigationService.generalNavigation(
//                                       "/JobDetailsScreen",
//                                       arguments: "1");
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: const BoxDecoration(
//                                     color: CustomColors.primary,
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(10),
//                                       bottomRight: Radius.circular(10),
//                                     ),
//                                   ),
//                                   child: const Text(
//                                     "Assessment",
//                                     style: CustomTextStyle.mediumBoldStyleWhite,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               )
//                             ],
//                           )),
//                       const VerticalDivider(
//                         color: Colors.amber,
//                         thickness: 2,
//                       ),
//                       Expanded(
//                           flex: 4,
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 10, left: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 5.0),
//                                   child: Row(
//                                     children: const [
//                                       Icon(Icons.insert_drive_file_outlined),
//                                       Text(
//                                         "Jack ",
//                                         style: CustomTextStyle
//                                             .normalBoldStyleBlack,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 5.0),
//                                   child: Row(
//                                     children: const [
//                                       Icon(Icons.location_on_outlined),
//                                       Text(
//                                         "Dhaka, Bangladesh",
//                                         style: CustomTextStyle
//                                             .normalRegularStyleDarkGrey,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 5.0),
//                                   child: Row(
//                                     children: const [
//                                       Icon(Icons.document_scanner_outlined),
//                                       Text(
//                                         "Something Here",
//                                         style: CustomTextStyle
//                                             .normalRegularStyleDarkGrey,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 CustomCompanyButtonWithIcon(
//                                     fizedSize: Size(100, 20),
//                                     buttonName: "Details",
//                                     onPressed: () {}),
//                                 const SizedBox(
//                                   height: 10,
//                                 )
//                               ],
//                             ),
//                           )),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   }
// }
