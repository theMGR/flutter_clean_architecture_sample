import 'package:flearn/main_source/common_src/constants/color_constant.dart';
import 'package:flearn/main_source/common_src/constants/value_constant.dart';
import 'package:flearn/main_source/common_src/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class UIConfig {
  static void hideKeyboard({required BuildContext context, Function? setState}) {
    if (setState != null) {
      setState(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  static void showBlankDialogX({required String title, required Widget child, double height = 100}) {
    UIUtils.blankDialogX(title: title, height: height, titleColor: ColorConstant.blue_1, titleFontFamily: ValueConstant.Montserrat, titleFontSize: 15, child: child);
  }

  static void showBlankDialogOkCancel({String message = "", Widget? child, Function()? okFunction, bool isCancelButtonNeed = false, String okText = "OK", String cancelText = "CANCEL", bool isCenterMessage = true, Function()? cancelFunction}) {
    UIUtils.blankDialogOKCancel(
        text: message,
        child: child,
        //height: height,
        okFunction: okFunction,
        isCancelButtonNeed: isCancelButtonNeed,
        buttonFontFamily: ValueConstant.Prosto,
        textFontFamily: ValueConstant.Montserrat,
        okButtonFillColor: ColorConstant.buttonColor,
        oKButtonTextColor: ColorConstant.COLOR_WHITE,
        okText: okText,
        cancelText: cancelText,
        isCenterMessage: isCenterMessage,
        cancelFunction: cancelFunction);
  }

  TextStyle getDefaultTextStyle({FontWeight? fontWeight}) {
    return TextStyle(color: ColorConstant.COLOR_LIGHT_GREY, fontSize: 14, fontFamily: ValueConstant.Montserrat, fontWeight: fontWeight);
  }
}
