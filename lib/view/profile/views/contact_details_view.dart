import 'package:flutter/material.dart';

import '../../variables/text_style.dart';
import '../../widgets/custom_company_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/profile_Image_widget.dart';

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
                child: CustomCompanyButton(
                    buttonName: "Next Step",
                    //  textStyle: CustomTextStyle.mediumBoldStylePrimary,
                    isFitted: true,
                    onPressed: () {}))
          ],
        ),
      ),
    );
  }
}
