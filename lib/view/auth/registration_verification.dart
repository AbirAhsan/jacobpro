// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:get/get.dart' hide Trans;

// import '../../controller/auth_controller.dart';
// import '../../generated/locale_keys.g.dart';

// class RegistrationOtpVerification extends StatelessWidget {
//   const RegistrationOtpVerification({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;
//     final AuthController authCtrl = Get.put(AuthController());
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Card(
//           child: Container(
//             padding: const EdgeInsets.all(10.0),
//             alignment: Alignment.center,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   LocaleKeys.otpVerification_otp.tr(),
//                   style: titleBoldStyle,
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   LocaleKeys.otpVerification_msg.tr(args: [
//                     authCtrl.selectedUserID.value == "E"
//                         ? "${authCtrl.merchantDetails.value!.merchantEmail}"
//                             .replaceRange(
//                                 0,
//                                 authCtrl.merchantDetails.value!.merchantEmail!
//                                         .indexOf("@") -
//                                     3,
//                                 " *****")
//                         : "${authCtrl.merchantDetails.value!.merchantContact}"
//                             .replaceRange(3, 8, "*****")
//                   ]),
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.black54,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 const CustomPinCode(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       "${LocaleKeys.otpVerification_dinotReceive.tr()} ",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     Flexible(
//                       child: ArgonTimerButton(
//                         initialTimer: 60, // Optional
//                         height: 35,
//                         width: 110,
//                         minWidth: 100,
//                         color: primaryBlueColor,
//                         borderRadius: 5.0,

//                         child: Text(
//                           LocaleKeys.otpVerification_resend.tr(),
//                           style: const TextStyle(
//                               color: white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700),
//                         ),
//                         loader: (timeLeft) {
//                           return Padding(
//                             padding: const EdgeInsets.all(3.0),
//                             child: Text(
//                               "$timeLeft ${LocaleKeys.otpVerification_wait.tr()}",
//                               style: const TextStyle(
//                                 color: white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           );
//                         },
//                         onTap: (startTimer, btnState) {
//                           if (btnState == ButtonState.Idle) {
//                             authCtrl.resendOTp().then((value) {
//                               if (value) {
//                                 startTimer(60);
//                               }
//                             });
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Obx(
//                   () => CustomElevatedButton(
//                     leftPadding: 30,
//                     rightPadding: 30.0,
//                     buttonName: LocaleKeys.otpVerification_button1.tr(),
//                     onPressed: authCtrl.currentOtpPin.value.length == 4
//                         ? () => authCtrl.otpCheck()
//                         : null,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
