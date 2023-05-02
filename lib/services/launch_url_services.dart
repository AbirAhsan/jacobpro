import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  UrlLauncherService._();
  //<============================== Launch Url
  static Future<void> urlLaunch(String? url) async {
    if (await canLaunchUrl(Uri.parse(url!))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "Could not launch $url";
    }
  }

  //<============================== Make Phone call
  static Future<void> openDialer(String phoneNumber) async {
    Uri callUrl = Uri.parse('tel:=$phoneNumber');
    if (await canLaunchUrl(callUrl)) {
      await launchUrl(callUrl);
    } else {
      throw 'Could not open the dialler.';
    }
  }

  //<=============================== Launch Mail
  static Future<void> launchEmail(String email) async {
    Uri mailUrl = Uri.parse('mailto:$email');
    if (await canLaunchUrl(mailUrl)) {
      await launchUrl(mailUrl);
    } else {
      throw 'Could not launch';
    }
  }

  //<============================== Launch Message
  static Future<void> launchMessage(String phoneNumber) async {
    Uri sms = Uri.parse('sms:$phoneNumber?body=');
    if (await canLaunchUrl(sms)) {
      await launchUrl(sms);
    } else {
      throw 'Could not launch';
    }
  }
}
