import 'dart:async';

import 'package:service/view/variables/colors_variable.dart';

import '../../controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCode extends StatefulWidget {
  const CustomPinCode({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomPinCode> createState() => _CustomPinCodeState();
}

class _CustomPinCodeState extends State<CustomPinCode> {
  // ignore: close_sinks
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authCtrl) {
          return Center(
            child: SizedBox(
              // width: 250,

              child: PinCodeTextField(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  //  fieldOuterPadding: EdgeInsets.all(10),
                  activeFillColor: Colors.white,
                  inactiveColor: CustomColors.grey,
                  selectedColor: CustomColors.primary,
                  selectedFillColor: CustomColors.primary.withOpacity(0.1),
                  inactiveFillColor: CustomColors.lightgrey,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.white,
                cursorColor: Colors.black,
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                onCompleted: (v) {
                  debugPrint("Completed");
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+(?:\.\d+)?$')),
                ],
                onChanged: (value) {
                  debugPrint(value);

                  authCtrl.currentOtpPin = value;
                  authCtrl.update();
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),
          );
        });
  }
}
