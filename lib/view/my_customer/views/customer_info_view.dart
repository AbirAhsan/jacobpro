import 'package:flutter/material.dart';
import 'package:service/view/variables/text_style.dart';

import '../../../model/customer_details_model.dart';

class CustomerInfoView extends StatelessWidget {
  final CustomerDetailsModel? customerDetails;
  const CustomerInfoView({super.key, this.customerDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 10,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "First Name",
                        style: CustomTextStyle.mediumBoldStyleGrey,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${customerDetails!.customerDto!.customerFirstName}",
                        style: CustomTextStyle.mediumRegularStyleDarkGrey,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Last Name",
                        style: CustomTextStyle.mediumBoldStyleGrey,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${customerDetails!.customerDto!.customerLastName}",
                        style: CustomTextStyle.mediumRegularStyleDarkGrey,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                //<============== Email
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Email",
                        style: CustomTextStyle.mediumBoldStyleGrey,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${customerDetails!.customerEmails?.first.customerEmail}",
                        style: CustomTextStyle.mediumRegularStyleDarkGrey,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                //<============== Phone
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Phone",
                        style: CustomTextStyle.mediumBoldStyleGrey,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${customerDetails!.customerContacts?.first.customerContactNo}",
                        style: CustomTextStyle.mediumRegularStyleDarkGrey,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                //<============== Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Location",
                        style: CustomTextStyle.mediumBoldStyleGrey,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${customerDetails!.customerAddresses?.first.customerAddressStreet}, ${customerDetails!.customerAddresses?.first.customerAddressCity}",
                        style: CustomTextStyle.mediumRegularStyleDarkGrey,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
