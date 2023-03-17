import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:service/view/widgets/custom_company_button_with_icon.dart';
import 'package:service/view/widgets/custom_submit_button.dart';
import 'package:service/view/widgets/custom_text_field.dart';
import 'package:service/view/widgets/profile_image_widget.dart';

import '../../variables/text_style.dart';

class ContactDetailsView extends StatelessWidget {
  const ContactDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: ProfileImageWidget(
                  imageUrl: "",
                  radius: 36,
                  isEditable: true,
                  onEdit: () {},
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              "Personal Contact".toUpperCase(),
              style: CustomTextStyle.mediumBoldStyleDarkGrey,
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    labelText: "First Name",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextField(
                    labelText: "Last Name",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ],
            ),
            CustomTextField(
              labelText: "Email",
              prefixIcon: const Icon(Icons.email),
            ),
            CustomTextField(
              labelText: "Phone",
              prefixIcon: const Icon(Icons.call),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Emergency Contact".toUpperCase(),
              style: CustomTextStyle.mediumBoldStyleDarkGrey,
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    labelText: "First Name",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextField(
                    labelText: "Last Name",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ],
            ),
            CustomTextField(
              labelText: "Email",
              prefixIcon: const Icon(Icons.email),
            ),
            CustomTextField(
              labelText: "Phone",
              prefixIcon: const Icon(Icons.call),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: CustomCompanyButtonWithIcon(
                    icon: Icons.arrow_forward_sharp,
                    buttonName: "Next",
                    textStyle: CustomTextStyle.mediumBoldStylePrimary,
                    isFitted: true,
                    onPressed: () {}))
          ],
        ),
      ),
    );
  }
}
