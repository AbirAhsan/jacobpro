import 'package:flutter/material.dart';
import 'package:service/view/widgets/custom_company_button.dart';
import 'package:service/view/widgets/custom_company_button_with_icon.dart';

import '../widgets/custom_submit_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text("Login Screen"),
          ),
          SizedBox(
            height: 100,
          ),
          //
          CustomSubmitButton(buttonName: "Submit", onPressed: () {}),
          CustomCompanyButton(buttonName: "Submit", onPressed: () {}),
          CustomCompanyButtonWithIcon(buttonName: "Submit", onPressed: () {}),
        ],
      ),
    );
  }
}
