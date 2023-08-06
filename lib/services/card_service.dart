import 'package:service/view/variables/icon_variables.dart';

class CardServices {
  static String getCardCompanyName(String cardNumber) {
    // Regular expressions for different card companies
    final amexRegex = RegExp(r'^3[47][0-9]{13}$');
    final visaRegex = RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$');
    final mastercardRegex = RegExp(r'^5[1-5][0-9]{14}$');

    // Remove any non-digit characters from the input
    final cleanCardNumber = cardNumber.replaceAll(RegExp(r'[^0-9]'), '');

    if (amexRegex.hasMatch(cleanCardNumber)) {
      return CustomIcons.amex;
    } else if (visaRegex.hasMatch(cleanCardNumber)) {
      return CustomIcons.visa;
    } else if (mastercardRegex.hasMatch(cleanCardNumber)) {
      return CustomIcons.master;
    } else {
      return '';
    }
  }
}
