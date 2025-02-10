import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'print_utils.dart';
import 'ui_utils.dart';
import 'validation_utils.dart';

enum CommunicationType { dialler, sms, email }

class CommunicationUtils {
  static void launchDialerOrMessageApp({required BuildContext context, required CommunicationType communicationType, required String contactID, bool isAlertAsDialog = true}) async {
    String alertMessage = "Something went wrong.";
    String alertType = "app";
    String launchUri;

    if (communicationType == CommunicationType.dialler) {
      launchUri = "tel:$contactID";
      alertType = "dialler";
    } else if (communicationType == CommunicationType.sms) {
      launchUri = "sms:$contactID";
      alertType = "message app";
    } else if (communicationType == CommunicationType.email) {
      launchUri = "mailto:$contactID";
      alertType = "email";
    } else {
      launchUri = "";
    }
    if (!ValidationUtils.isEmpty(launchUri) && !ValidationUtils.isEmpty(contactID)) {
      try {
        await canLaunchUrl(Uri.parse(launchUri));
      } catch (e) {
        Print.reference("${communicationType.toString()} : Exception :-> $e");
        alertMessage = "Could not open $alertType, Something went wrong.";
        if (context.mounted) {
          if (isAlertAsDialog) {
            UIUtils.showAlertDialog(context: context, alertTitle: "Alert", alertMessage: alertMessage);
          } else {
            UIUtils.showToast(context: context, message: alertMessage);
          }
        }
      }
    } else {
      alertMessage = "Contact information not available.";
      if (isAlertAsDialog) {
        UIUtils.showAlertDialog(context: context, alertTitle: "Alert", alertMessage: alertMessage);
      } else {
        UIUtils.showToast(context: context, message: alertMessage);
      }
    }
  }
}
