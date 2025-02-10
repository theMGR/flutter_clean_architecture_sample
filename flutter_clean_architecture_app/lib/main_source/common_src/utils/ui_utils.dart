import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flearn/main_source/common_src/constants/color_constant.dart';
import 'package:flearn/main_source/common_src/constants/date_constants.dart';
import 'package:flearn/main_source/common_src/constants/value_constant.dart';
import 'package:flearn/main_source/common_src/widget_utils/faddingprogress.dart';
import 'package:flearn/main_source/common_src/widget_utils/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import 'dates_utils.dart';
import 'input_type_utils.dart';
import 'validation_utils.dart';

class UIUtils {
  static const Color blue_1 = Color(0xFF004E8C);
  static const Color blue_2 = Color(0xFF074980);
  static const Color blue_3 = Color(0xFF4D77AF);
  static const Color blue_4 = Color(0xFF608ABE);
  static const Color yellow_1 = Color(0xFFBDB818);
  static const Color yellow_2 = Color(0xFFCBBE00);
  static const Color yellow_3 = Color(0xFFFEF104);
  static const Color yellow_4 = Color(0xFFD9CF0F);

  static Widget datePickerWithText(
      {Key? key,
      required String uiKey,
      required TextEditingController textEditingController,
     // String title = "",
      String? hintText,
      String? labelText,
      String selectedDate = "",
      bool firstDateIsCurrentTime = false,
      bool lastDateIsCurrentTime = false,
      Function(String?)? onYYYYMMDD,
      Function(String?)? onServerDate,
      Function(String?)? onYYYYMMDDHHMMSS,
      Function(String?)? onDDMMYYYYSlash,
      Color? textColor = Colors.black,
      Color? hintTextColor = ColorConstant.COLOR_LIGHT_GREY,
      Color? labelTextColor = ColorConstant.LITE_BLACK,
      double borderRadius = 0,
      bool isEditable = true,
      FocusNode? focusNode,
      FocusNode? requestFocusNode,
      bool isMandatory = false,
      String mandatoryChar = "*",
      Color mandatoryCharColor = Colors.red,
      Function()? onResetClicked,
      Color borderColor = Colors.grey,
      Color focusedBorderColor = Colors.grey,
      Color enabledBorderColor = Colors.grey,
      Color disabledBorderColor = Colors.grey,
      Color errorBorderColor = Colors.grey,
      Color focusedErrorBorderColor = Colors.grey,
      TextStyle? textStyle,
      TextStyle? hintTextStyle,
      TextStyle? labelTextStyle,
      bool isColorFilled = true,
      Color fillColor = Colors.transparent,
      String? fontFamily,
      double textSize = 14,
      EdgeInsetsGeometry textFieldContentPadding = const EdgeInsets.all(5),
      FloatingLabelBehavior? floatingLabelBehavior}) {
    if (focusNode == null) {
      focusNode = FocusNode();
    }

    initializeDateFormatting(Intl.systemLocale, null);

    hintText = hintText ?? "Select Date";

    DateTime _selectedDateTime = DateTime.now();
    String _selectedDate = "";

    try {
      _selectedDateTime = ValidationUtils.isEmpty(selectedDate) ? DateTime.now() : DateTime.parse(selectedDate);
      _selectedDate = DateFormat(DateConstants.YYYY_MM_DD).format(_selectedDateTime);
    } catch (e) {
      _selectedDateTime = DateTime.now();
      _selectedDate = "";
    }

    fontFamily = fontFamily ?? ValueConstant.Montserrat;
    labelTextStyle = labelTextStyle ?? TextStyle(color: labelTextColor, fontSize: textSize, fontFamily: fontFamily, fontWeight: FontWeight.w500);
    textStyle = textStyle ?? TextStyle(color: textColor, fontSize: textSize, fontFamily: fontFamily);
    hintTextStyle = hintTextStyle ?? TextStyle(color: hintTextColor, fontSize: textSize, fontFamily: fontFamily);

    InputDecoration inputDecoration = InputDecoration(
      contentPadding: textFieldContentPadding,
      floatingLabelBehavior: floatingLabelBehavior,
      label: !ValidationUtils.isEmpty(labelText)
          ? RichText(
              text: TextSpan(children: [
              TextSpan(text: labelText, style: labelTextStyle),
              isMandatory ? TextSpan(text: " $mandatoryChar", style: TextStyle(color: mandatoryCharColor, fontSize: textSize, fontWeight: FontWeight.bold, fontFamily: fontFamily)) : TextSpan(),
            ]))
          : null,
      //prefixStyle: prefixTextStyle ?? TextStyle(color: textColor, fontSize: textSize, fontFamily: fontFamily),
      //prefixText: prefixText,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focusedBorderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: enabledBorderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: disabledBorderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: errorBorderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focusedErrorBorderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      hintText: hintText,
      //labelText: labelText,
      hintStyle: hintTextStyle,
      //labelStyle: labelTextStyle,
      fillColor: fillColor,
      filled: isColorFilled,
      suffixIcon: Icon(FontAwesomeIcons.calendarAlt),
    );

    return AbsorbPointer(
      absorbing: !isEditable,
      child: StatefulBuilder(
        key: key,
        builder: (context, setState) {
          //FocusScope.of(context).requestFocus(FocusNode());//to remove focus
          setState(() {
            if (!ValidationUtils.isEmpty(selectedDate) && selectedDate.contains("/")) {
              textEditingController.text = selectedDate;
            }
            if (_selectedDate.trim().length > 0 && selectedDate.trim().length > 0) {
              //textEditingController.text = _selectedDate;
              textEditingController.text = DatesUtils.formatDate(_selectedDate, DateConstants.DDMMYYYY_SLASH) ?? "";
            }
          });

          return InkWell(
            onTap: () async {
              UIUtils.hideKeyboard();

              DateTime? pickedDateTime = await showDatePicker(
                context: context,
                initialDate: firstDateIsCurrentTime ? DateTime.now() : _selectedDateTime,
                firstDate: firstDateIsCurrentTime ? DateTime.now() : DateTime(1950),
                lastDate: lastDateIsCurrentTime ? DateTime.now() : DateTime(3000),
                helpText: labelText,
                cancelText: 'Cancel',
                confirmText: 'Ok',
              );

              if (pickedDateTime != null && pickedDateTime != _selectedDateTime) {
                setState(() {
                  _selectedDateTime = pickedDateTime;
                  _selectedDate = DateFormat(DateConstants.YYYY_MM_DD).format(_selectedDateTime);

                  textEditingController.text = DatesUtils.formatDate(_selectedDate, DateConstants.DDMMYYYY_SLASH) ?? "";

                  if (onYYYYMMDD != null) {
                    onYYYYMMDD(DatesUtils.formatDate(_selectedDate, DateConstants.YYYY_MM_DD));
                  }

                  if (onServerDate != null) {
                    onServerDate(DatesUtils.formatDate(_selectedDate, DateConstants.SERVICE_Z));
                  }

                  if (onYYYYMMDDHHMMSS != null) {
                    onYYYYMMDDHHMMSS(DatesUtils.formatDate(_selectedDate, DateConstants.YYYYMMDDHHMMSS));
                  }

                  if (onDDMMYYYYSlash != null) {
                    onDDMMYYYYSlash(DatesUtils.formatDate(_selectedDate, DateConstants.DDMMYYYY_SLASH));
                  }

                  if (focusNode != null) {
                    focusNode.unfocus();
                  }
                  if (requestFocusNode != null) {
                    requestFocusNode.requestFocus();
                  }
                });
              }
            },
            child: Focus(
              focusNode: focusNode,
              canRequestFocus: true,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      key: ValueKey(uiKey),
                      controller: textEditingController,
                      keyboardType: TextInputType.text,
                      enabled: false,
                      style: TextStyle(color: textColor, fontSize: textSize, fontFamily: fontFamily),
                      decoration: inputDecoration,
                    ),
                  ),
                  onResetClicked != null
                      ? IconButton(
                          splashRadius: 20,
                          icon: Icon(Icons.refresh_sharp),
                          onPressed: () {
                            UIUtils.hideKeyboard();
                            setState(() {
                              textEditingController.text = "";
                            });
                            onResetClicked();
                          })
                      : Container()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static void showToast({required BuildContext? context, required String message}) {
    if (context != null) {
      FToast fToast = FToast();
      fToast.init(context);

      Widget toast = Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Colors.grey[500]!, width: 0.2),
          color: Colors.grey[100],
        ),
        child: Text(message, style: TextStyle(color: Colors.black)),
      );

      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
      );
    }
  }

  static Widget labelWithText(
      {TextEditingController? textEditingController,
      String title = "",
      String hintText = "",
      bool isEditable = true,
      INPUT_TYPE inputType = INPUT_TYPE.ALPHA_NUMERIC_SPECIAL_CHAR,
      int length = 100,
      int maxLines = 1,
      bool isCounterTextEnabled = false,
      Color fillColor = Colors.white,
      bool isColorFilled = false,
      Function(String)? onTextChanged,
      double titleSize = 18,
      double textSize = 16,
      TextStyle? titleTextStyle,
      TextStyle? textStyle,
      TextStyle? hintTextStyle,
      Color titleColor = Colors.black45,
      Color textColor = Colors.black,
      Color hintTextColor = Colors.grey,
      double borderRadius = 5,
      Color borderColor = ColorConstant.COLOR_LIGHT_GREY,
      Widget? prefixIcon,
      Widget? suffixIcon,
      bool obscureText = false,
      String obscuringCharacter = "."}) {
    hintText = ValidationUtils.isEmpty(hintText)
        ? ValidationUtils.isEmpty(title)
            ? "Enter Text"
            : "Enter $title"
        : hintText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !ValidationUtils.isEmpty(title)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: titleTextStyle == null ? TextStyle(color: titleColor, fontSize: titleSize, fontWeight: FontWeight.bold) : titleTextStyle),
                  SizedBox(height: 5),
                ],
              )
            : Container(),
        TextField(
          obscureText: obscureText,
          obscuringCharacter: obscuringCharacter,
          buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
            return isCounterTextEnabled
                ? Container(padding: EdgeInsets.only(left: 5, right: 5), alignment: Alignment.centerRight, child: Text(currentLength.toString() + "/" + maxLength.toString()))
                : Container();
          },
          maxLength: length,
          maxLines: maxLines,
          onChanged: (text) {
            if (onTextChanged != null) {
              onTextChanged(text);
            }
          },
          controller: textEditingController != null ? textEditingController : TextEditingController(),
          keyboardType: InputTypeUtils.getTextInputType(inputType),
          inputFormatters: InputTypeUtils.getTextInputFormatter(inputType),
          enabled: isEditable,
          style: textStyle == null ? TextStyle(color: textColor, fontSize: textSize) : textStyle,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            hintText: hintText,
            hintStyle: hintTextStyle == null ? TextStyle(color: hintTextColor) : hintTextStyle,
            fillColor: fillColor,
            filled: isColorFilled,
            prefixIcon: prefixIcon == null ? SizedBox() : prefixIcon,
            suffixIcon: suffixIcon == null ? SizedBox() : suffixIcon,
            prefixIconConstraints: BoxConstraints(
              minHeight: prefixIcon == null ? 5 : 32,
              minWidth: prefixIcon == null ? 5 : 32,
            ),
            suffixIconConstraints: BoxConstraints(
              minHeight: suffixIcon == null ? 5 : 32,
              minWidth: suffixIcon == null ? 5 : 32,
            ),
          ),
        )
      ],
    );
  }

  static Widget gradientBarDefault({required BuildContext context, double height = 12}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(color: ColorConstant.Gradient_Dark_blue),
          height: height,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(color: ColorConstant.Gradient_Lite_blue),
          height: height,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(color: ColorConstant.Gradient_Dark_Yellow),
          height: height,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(color: ColorConstant.Gradient_Lite_Yellow),
          height: height,
        ),
      ],
    );
  }

  static Widget gradientBar({required double height}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [blue_1, blue_2],
/*            begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp*/
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [blue_3, blue_4],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [yellow_1, yellow_2],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [yellow_3, yellow_4],
              ),
            ),
          ),
        )
      ],
    );
  }

  static void showAlertDialog({required BuildContext? context, required String alertTitle, required String alertMessage, bool isBarrierDismissible = true}) {
    if (context != null) {
      // Create button
      Widget okButton = ElevatedButton(
        style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: ColorConstant.buttonColor),
        child: Text("OK",style: TextStyle(fontFamily: ValueConstant.Prosto)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // Create AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(alertTitle,),
        content: SingleChildScrollView(child: Text(alertMessage,style: TextStyle(fontFamily: ValueConstant.Montserrat),)),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        barrierDismissible: isBarrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  static void showAlertDialogOkFunction(
      {required BuildContext? context, required String alertTitle, required String alertMessage, required Function()? function, String okText = "OK", bool isBarrierDismissible = true}) {
    if (context != null) {
      // Create button
      Widget okButton = ElevatedButton(
        style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: ColorConstant.buttonColor),
        child: Text(okText),
        onPressed: function,
      );

      // Create AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(alertTitle),
        content: SingleChildScrollView(child: Text(alertMessage)),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        barrierDismissible: isBarrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  static void showAlertDialogOkCancel({required BuildContext context, required String alertTitle, required String alertMessage, required Function()? function, bool isBarrierDismissible = true}) {
    // Create button
    Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: ColorConstant.buttonColor),
      child: Text("OK"),
      onPressed: function,
    );

    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: ColorConstant.buttonColor),
      child: Text("CANCEL"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: SingleChildScrollView(child: Text(alertMessage)),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      barrierDismissible: isBarrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showLoadingDialog({required BuildContext context, required String text, bool isBarrierDismissible = false}) {
    AlertDialog alertDialog = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(40),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 30),
              Container(margin: EdgeInsets.only(left: 20), child: Text(text)),
            ],
          ),
        ));

    showDialog(
      barrierDismissible: isBarrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  static void showLoadingDialogFullScreen({required BuildContext context, required String text, bool isBarrierDismissible = false, Color? barrierColor = Colors.white}) {
    AlertDialog alertDialog = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(40),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 30),
              Container(margin: EdgeInsets.only(left: 20), child: Text(text)),
            ],
          ),
        ));

    showDialog(
      barrierColor: barrierColor,
      barrierDismissible: isBarrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  static void showRetryDialogFullScreen(
      {required BuildContext? context, String retryText = "Retry", Function()? retryFunction, String? message, bool isBarrierDismissible = false, Color? barrierColor = Colors.white}) {
    if (context != null) {
      AlertDialog alertDialog = AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: RetryWidget(
            message: message ?? "",
            retryFunction: retryFunction,
            retryText: retryText,
          ));

      showDialog(
        barrierColor: barrierColor,
        barrierDismissible: isBarrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: alertDialog);
        },
      );
    }
  }

  static onScreenPop({required BuildContext context, var result}) {
    return Navigator.pop(context, result);
  }

  /*static void hideKeyboard({required BuildContext context, Function? setState}) {
    if (setState != null) {
      setState(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }*/

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
    //Get.focusScope!.unfocus();
  }

  static Widget buttonWidthMatchParent(
      {required String uiKey,
      required String title,
      String? fontFamily,
      double height = 40,
      Color fillColor = Colors.white,
      Color borderColor = ColorConstant.COLOR_LIGHT_GREY,
      Color textColor = ColorConstant.COLOR_LIGHT_GREY,
      double fontSize = 14,
      double borderRadius = 8,
      EdgeInsetsGeometry padding = const EdgeInsets.all(5),
      EdgeInsetsGeometry margin = const EdgeInsets.all(0),
      required Function() onTap,
      IconData? prefixIcon,
      Color prefixIconColor = Colors.grey,
      double prefixIconSize = 16,
      IconData? suffixIcon,
      Color suffixIconColor = Colors.grey,
      double suffixIconSize = 16}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: margin,
          child: InkWell(
            key: ValueKey(uiKey),
            onTap: onTap,
            child: Container(
              padding: padding,
              height: height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  prefixIcon != null
                      ? Container(
                          width: 50,
                          //padding: EdgeInsets.only(left: 5, right: 5),
                          child: Icon(prefixIcon, color: prefixIconColor, size: prefixIconSize),
                        )
                      : Container(),
                  Expanded(
                    child: prefixIcon != null || suffixIcon != null
                        ? Text(title, style: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily))
                        : Center(child: Text(title, style: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily))),
                  ),
                  suffixIcon != null
                      ? Container(
                          width: 50,
                          //padding: EdgeInsets.only(left: 5, right: 5),
                          child: Icon(suffixIcon, color: suffixIconColor, size: suffixIconSize),
                        )
                      : Container()
                ],
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: fillColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget buttonWidthSize(
      {required String uiKey,
      required String title,
      String? fontFamily,
      double height = 40,
      double width = 150,
      Color fillColor = Colors.white,
      Color borderColor = ColorConstant.COLOR_LIGHT_GREY,
      Color textColor = ColorConstant.COLOR_LIGHT_GREY,
      double fontSize = 14,
      double borderRadius = 8,
      EdgeInsetsGeometry padding = const EdgeInsets.all(5),
      EdgeInsetsGeometry margin = const EdgeInsets.all(0),
      required Function() onTap,
      IconData? prefixIcon,
      Color prefixIconColor = Colors.grey,
      double prefixIconSize = 16,
      IconData? suffixIcon,
      Color suffixIconColor = Colors.grey,
      double suffixIconSize = 16}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          alignment: Alignment.center,
          margin: margin,
          child: InkWell(
            key: ValueKey(uiKey),
            onTap: onTap,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              padding: padding,
              height: height,
              width: width,
              /*child: Text(
                title,
                style: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily),
              ),*/
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  prefixIcon != null
                      ? Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Icon(prefixIcon, color: prefixIconColor, size: prefixIconSize),
                        )
                      : Container(),
                  Text(
                    title,
                    style: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily),
                  ),
                  suffixIcon != null
                      ? Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Icon(suffixIcon, color: suffixIconColor, size: suffixIconSize),
                        )
                      : Container(),
                ],
              ),
/*              child: RichText(text: TextSpan(
                  style: TextStyle(color: textColor, fontSize: fontSize, fontFamily: fontFamily),
                children: [
                  prefixIcon != null ? WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(prefixIcon, color: prefixIconColor),
                    ),
                  ) : WidgetSpan(child: Container()),
                  TextSpan(text:  title),
                  suffixIcon != null ? WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(suffixIcon, color: suffixIconColor),
                    ),
                  ) : WidgetSpan(child: Container()),
                ],
              )
              ),*/
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: fillColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget button1(
      {required BuildContext context,
      required String title,
      double height = 50,
      double width = 100,
      Color fillColor = Colors.white,
      Color borderColor = ColorConstant.COLOR_LIGHT_GREY,
      Color textColor = ColorConstant.COLOR_LIGHT_GREY,
      double fontSize = 18,
      double borderRadius = 8,
      EdgeInsetsGeometry padding = const EdgeInsets.all(5),
      EdgeInsetsGeometry margin = const EdgeInsets.all(0),
      required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: margin,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: padding,
              height: height,
              width: width,
              child: Text(
                title,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: fillColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget imageWIthText_1(
      {required String title,
      IconData? faIcon,
      Color faIconColor = Colors.black,
      String imageAsset = "",
      Function()? function,
      double fontSize = 14,
      FontWeight fontWeight = FontWeight.normal,
      Color fontColor = Colors.black,
      double iconSize = 60}) {
    return InkWell(
      onTap: function,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageAsset.trim().length > 0
              ? Container(
                  height: iconSize,
                  width: iconSize,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : faIcon != null
                  ? Icon(
                      faIcon,
                      size: iconSize,
                      color: faIconColor,
                    )
                  : Icon(
                      Icons.circle,
                      size: iconSize,
                      color: faIconColor,
                    ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(1),
            child: Text(
              title,
              style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: fontColor),
            ),
          )
        ],
      ),
    );
  }

  static void blankDialogX(
      {double height = 100,
      double borderRadius = 10,
      double titleFontSize = 16,
      String title = "Alert",
      String? titleFontFamily,
      Color titleColor = Colors.black,
      Color closeButtonColor = Colors.black,
      Widget? child}) {
    Get.dialog(
        WillPopScope(
          onWillPop: () => Future.value(false),
          child: Container(
            alignment: Alignment.center,
            child: Wrap(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  child: Material(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(children: [
                          Expanded(child: Text(title, style: TextStyle(fontSize: titleFontSize, color: titleColor, fontFamily: titleFontFamily))),
                          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close, color: closeButtonColor))
                        ]),
                        Container(
                          height: height,
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(10),
                              child: child ?? Container(),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false);
  }

  static void blankDialogOKCancel(
      {double borderRadius = 10,
      double textFontSize = 14,
      String text = "Alert",
      String? textFontFamily,
      Color textColor = Colors.black,
      Color okButtonFillColor = Colors.blue,
      Color oKButtonTextColor = Colors.white,
      String? buttonFontFamily,
      Widget? child,
      bool isCancelButtonNeed = false,
      required Function()? okFunction,
      String okText = "OK",
      String cancelText = "CANCEL",
      bool isCenterMessage = true,
      Function()? cancelFunction}) {
    Widget textWidget = text.length < 30 && isCenterMessage
        ? Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: textFontSize, fontFamily: textFontFamily, color: textColor))
        : Text(text, style: TextStyle(fontSize: textFontSize, fontFamily: textFontFamily, color: textColor));

    Get.dialog(
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: WillPopScope(
              onWillPop: () => Future.value(false),
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      child ?? textWidget,
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buttonWidthSize(
                              uiKey: "button_" + okText,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 30,
                              title: okText,
                              fontFamily: buttonFontFamily,
                              borderRadius: 10,
                              width: 100,
                              fontSize: 12,
                              fillColor: okButtonFillColor,
                              borderColor: okButtonFillColor,
                              textColor: oKButtonTextColor,
                              onTap: okFunction ?? () => Get.back()),
                          isCancelButtonNeed
                              ? buttonWidthSize(
                                  uiKey: "button_" + cancelText,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  height: 30,
                                  title: cancelText,
                                  fontFamily: buttonFontFamily,
                                  borderRadius: 10,
                                  width: 100,
                                  fontSize: 12,
                                  fillColor: okButtonFillColor,
                                  borderColor: okButtonFillColor,
                                  textColor: oKButtonTextColor,
                                  onTap: cancelFunction ?? () => Get.back())
                              : Container()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false);
  }

  static Widget appProgress({String message = "", bool enableBorder = true}) {
    Widget progress = Container(
      padding: const EdgeInsets.all(24.0),
      width: Get.width / 1.5,
      height: Get.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadingCircleProgress(
            color: ColorConstant.buttonColor,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            message,
            style: TextStyle(fontFamily: ValueConstant.Montserrat),
          )
        ],
      ),
    );
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
      child: Center(
        child: enableBorder == true
            ? Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: progress,
              )
            : progress,
      ),
    );
  }

  static Widget titleSubtitle(
      {required String uiKey,
      bool isRow = false,
      String? fontFamily,
      double fontSize = 14,
      Color titleColor = Colors.grey,
      Color subtitleColor = Colors.black,
      String title = "",
      String subTitle = ""}) {
    Widget titleWidget = Text(title, style: TextStyle(fontSize: fontSize, fontFamily: fontFamily, color: titleColor));
    Widget subTitleWidget = Text(subTitle, key: ValueKey(uiKey), style: TextStyle(fontSize: fontSize, fontFamily: fontFamily, color: subtitleColor, fontWeight: FontWeight.bold));
    return isRow
        ? Row(children: [titleWidget, ValidationUtils.isEmpty(subTitle) ? Container() : Expanded(child: subTitleWidget)])
        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [titleWidget, ValidationUtils.isEmpty(subTitle) ? Container() : subTitleWidget]);
  }

  static void showFileImageInBottomSheet(File file) {
    Get.dialog(
        WillPopScope(
          onWillPop: () => Future.value(false),
          child: Container(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              //margin: EdgeInsets.all(20),
              //padding: EdgeInsets.all(20),
              child: Material(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(children: [
                      Expanded(child: Text("", style: TextStyle(fontSize: 16, color: ColorConstant.blue_1, fontFamily: ValueConstant.Montserrat))),
                      IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close, color: Colors.black))
                    ]),
                    Expanded(
                      child: Container(
                          color: Colors.black,
                          alignment: Alignment.center,
                          child: PhotoView(
                            imageProvider: FileImage(file),
                            loadingBuilder: (context, event) => Container(alignment: Alignment.center, height: 20, width: 20, child: CircularProgressIndicator(color: ColorConstant.color_grey)),
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported, size: 140, color: ColorConstant.grey_light),
                          )),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false);
    /*Get.bottomSheet(
        Container(
            height: double.infinity,
            color: Colors.black,
            child: PhotoView(
              imageProvider: FileImage(file),
              loadingBuilder: (context, event) => Container(alignment: Alignment.center, height: 20, width: 20, child: CircularProgressIndicator(color: ColorConstant.color_grey)),
              errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported, size: 140, color: ColorConstant.grey_light),
            )),
        isScrollControlled: true);*/
  }

  static void showNetworkImageInBottomSheet(String? imageUrl) {
    CachedNetworkImage.evictFromCache(imageUrl ?? "", cacheKey: imageUrl ?? "");
    DefaultCacheManager defaultCacheManager = DefaultCacheManager();
    defaultCacheManager.removeFile(imageUrl ?? "");
    defaultCacheManager.emptyCache();
    defaultCacheManager.store.emptyCache();

    Get.dialog(
        WillPopScope(
          onWillPop: () => Future.value(false),
          child: Container(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              //margin: EdgeInsets.all(20),
              //padding: EdgeInsets.all(20),
              child: Material(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(children: [
                      Expanded(child: Text("", style: TextStyle(fontSize: 16, color: ColorConstant.blue_1, fontFamily: ValueConstant.Montserrat))),
                      IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close, color: Colors.black))
                    ]),
                    Expanded(
                      child: Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        child: PhotoView(
                          imageProvider: CachedNetworkImageProvider(imageUrl ?? "", cacheKey: imageUrl ?? ""),
                          loadingBuilder: (context, event) => Container(alignment: Alignment.center, height: 20, width: 20, child: CircularProgressIndicator(color: ColorConstant.color_grey)),
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported, size: 140, color: ColorConstant.grey_light),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false);
/*    Get.bottomSheet(
        Container(
            height: double.infinity,
            color: Colors.black,
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(imageUrl ?? "", cacheKey: imageUrl ?? ""),
              loadingBuilder: (context, event) => Container(alignment: Alignment.center, height: 20, width: 20, child: CircularProgressIndicator(color: ColorConstant.color_grey)),
              errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported, size: 140, color: ColorConstant.grey_light),
            )),
        isScrollControlled: true);*/
  }

  static void showBase64ImageInBottomSheet(String imageBase64) {
    Get.dialog(
        WillPopScope(
          onWillPop: () => Future.value(false),
          child: Container(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              //margin: EdgeInsets.all(20),
              //padding: EdgeInsets.all(20),
              child: Material(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(children: [
                      Expanded(child: Text("", style: TextStyle(fontSize: 16, color: ColorConstant.blue_1, fontFamily: ValueConstant.Montserrat))),
                      IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close, color: Colors.black))
                    ]),
                    Expanded(
                      child: Container(
                          color: Colors.black,
                          alignment: Alignment.center,
                          child: PhotoView(
                            imageProvider: MemoryImage(base64Decode(imageBase64)),
                            loadingBuilder: (context, event) => Container(alignment: Alignment.center, height: 20, width: 20, child: CircularProgressIndicator(color: ColorConstant.color_grey)),
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported, size: 140, color: ColorConstant.grey_light),
                          )),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false);
    /*Get.bottomSheet(
        Container(
            height: double.infinity,
            color: Colors.black,
            child: PhotoView(
              imageProvider: FileImage(file),
              loadingBuilder: (context, event) => Container(alignment: Alignment.center, height: 20, width: 20, child: CircularProgressIndicator(color: ColorConstant.color_grey)),
              errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported, size: 140, color: ColorConstant.grey_light),
            )),
        isScrollControlled: true);*/
  }

  static Widget textFieldLabel(
      {required String uiKey,
      TextEditingController? textEditingController,
      String value = "",
      String hintText = "",
      String labelText = "",
      bool isEditable = true,
      INPUT_TYPE inputType = INPUT_TYPE.ALPHA_NUMERIC_SPECIAL_CHAR,
      int? length,
      int? maxLines = 1,
      bool isCounterTextEnabled = false,
      Color fillColor = Colors.transparent,
      bool isColorFilled = true,
      Function(String)? onTextChanged,
      double textSize = 14,
      TextStyle? textStyle,
      TextStyle? hintTextStyle,
      TextStyle? labelTextStyle,
      Color? textColor = Colors.black,
      Color? hintTextColor = ColorConstant.COLOR_LIGHT_GREY,
      Color? labelTextColor = ColorConstant.LITE_BLACK,
      double borderRadius = 0,
      Color borderColor = Colors.grey,
      Color focusedBorderColor = Colors.grey,
      Color enabledBorderColor = Colors.grey,
      Color disabledBorderColor = Colors.grey,
      Color errorBorderColor = Colors.grey,
      Color focusedErrorBorderColor = Colors.grey,
      Widget? prefixIcon,
      Widget? suffixIcon,
      bool obscureText = false,
      bool readOnly = false,
      String obscuringCharacter = ".",
      EdgeInsetsGeometry textFieldContentPadding = const EdgeInsets.all(5),
      //BuildContext? context,
      FocusNode? focusNode,
      FocusNode? requestFocusNode,
      TextInputAction? textInputAction = TextInputAction.done,
      String? fontFamily,
      TextCapitalization textCapitalization = TextCapitalization.words,
      bool enableSuggestions = false,
      bool autoCorrect = false,
      Function()? onTap,
      bool isMandatory = false,
      String mandatoryChar = "*",
      Color mandatoryCharColor = Colors.red,
      TextStyle? prefixTextStyle,
      String? prefixText,
      String? Function(String?)? validator,
      AutovalidateMode? autoValidateMode = AutovalidateMode.always,
      FloatingLabelBehavior? floatingLabelBehavior,
      Function(String)? onFieldSubmitted}) {
    TextEditingController tec = textEditingController ?? TextEditingController();
    tec.text = value;
    if (focusNode == null) {
      focusNode = FocusNode();
    }
    if (focusNode != null && requestFocusNode != null) {
      textInputAction = TextInputAction.next;
    }

    fontFamily = fontFamily ?? ValueConstant.Montserrat;
    labelTextStyle = labelTextStyle ?? TextStyle(color: labelTextColor, fontSize: textSize, fontFamily: fontFamily, fontWeight: FontWeight.w500);
    textStyle = textStyle ?? TextStyle(color: textColor, fontSize: textSize, fontFamily: fontFamily);
    hintTextStyle = hintTextStyle ?? TextStyle(color: hintTextColor, fontSize: textSize, fontFamily: fontFamily);

    return TextFormField(
      onTap: onTap != null ? onTap : null,
      readOnly: readOnly != null ? readOnly : false,
      //autofocus: true,
      key: ValueKey(uiKey),
      autovalidateMode: autoValidateMode,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      focusNode: focusNode,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      enableSuggestions: enableSuggestions,
      autocorrect: autoCorrect,
      buildCounter: isCounterTextEnabled ? (context, {required currentLength, required isFocused, maxLength}) {
        return Container(padding: EdgeInsets.only(left: 5, right: 5), alignment: Alignment.centerRight, child: Text(currentLength.toString() + "/" + maxLength.toString()));
      } : null,
      maxLength: length,
      maxLines: maxLines,
      onChanged: (text) {
        if (onTextChanged != null) {
          onTextChanged(text);
        }
      },
      onEditingComplete: () {
        tec.text = tec.text;
        if (focusNode != null) {
          focusNode.unfocus();
        }
        if (requestFocusNode != null) {
          requestFocusNode.requestFocus();
        }
      },
      onFieldSubmitted: (String value) {
        tec.text = value;
        if (focusNode != null) {
          focusNode.unfocus();
        }
        if (requestFocusNode != null) {
          requestFocusNode.requestFocus();
        }
        if(onFieldSubmitted != null) {
          onFieldSubmitted(value);
        }
      },
      validator: (String? value) {
        if(validator != null) {
          return validator(value);
        } else {
          return null;
        }
      },
      controller: tec,
      keyboardType: InputTypeUtils.getTextInputType(inputType),
      inputFormatters: InputTypeUtils.getTextInputFormatter(inputType),
      enabled: isEditable,
      style: textStyle,
      decoration: InputDecoration(
        contentPadding: textFieldContentPadding,
        counterText:  !isCounterTextEnabled ? "" : null,
        floatingLabelBehavior: floatingLabelBehavior,
        label: !ValidationUtils.isEmpty(labelText)
            ? RichText(
            text: TextSpan(children: [
              TextSpan(text: labelText, style: labelTextStyle),
              isMandatory ? TextSpan(text: " $mandatoryChar", style: TextStyle(color: mandatoryCharColor, fontSize: textSize, fontWeight: FontWeight.bold, fontFamily: fontFamily)) : TextSpan(),
            ]))
            : null,
        //prefixStyle: prefixTextStyle ?? TextStyle(color: textColor, fontSize: textSize, fontFamily: fontFamily),
        //prefixText: prefixText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusedBorderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: enabledBorderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: disabledBorderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorBorderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusedErrorBorderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        hintText: hintText,
        //labelText: labelText,
        hintStyle: hintTextStyle,
        //labelStyle: labelTextStyle,
        fillColor: fillColor,
        filled: isColorFilled,
        prefixIcon: prefixIcon == null ? SizedBox() : prefixIcon,
        suffixIcon: suffixIcon == null ? SizedBox() : suffixIcon,
        prefixIconConstraints: BoxConstraints(
          minHeight: prefixIcon == null ? 5 : 38,
          minWidth: prefixIcon == null ? 5 : 38,
        ),
        suffixIconConstraints: BoxConstraints(
          minHeight: suffixIcon == null ? 5 : 38,
          minWidth: suffixIcon == null ? 5 : 38,
        ),
      ),
    );
  }

  static KeyboardVisibilityBuilder keyboardVisibilityBuilder(Widget? child) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      //return AnimatedOpacity(opacity: isKeyboardVisible ? 0 : 1, duration: Duration(milliseconds: 500), child: child ?? SizedBox());
      return AnimatedContainer(height: isKeyboardVisible ? 0 : null, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn, child: child ?? SizedBox.shrink());
      //return isKeyboardVisible ? SizedBox(height: 0) : child ?? SizedBox();
    });
  }

  static void getPdfRenderFromUrl(String? pathUrl) {
    Widget pdfRender;
    if (pathUrl!.contains('https') || pathUrl.contains('www')) {
      pdfRender = PDF().cachedFromUrl(
        pathUrl,
        //placeholder: (progress) => Center(child: Text('$progress %')),
        //errorWidget: (error) => Center(child: Text(error.toString())),
        placeholder: (progress) => Container(alignment: Alignment.center, height: 20, width: 20, child: CircularProgressIndicator(color: ColorConstant.color_grey)),
        errorWidget: (error) => Icon(Icons.broken_image, size: 140, color: ColorConstant.grey_light),
      );
    } else {
      pdfRender = PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
        onPageChanged: (page, total) {
          print('page change: $page/$total');
        },
      ).fromAsset(pathUrl);
    }
    Get.dialog(
        WillPopScope(
          onWillPop: () => Future.value(false),
          child: Container(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              //margin: EdgeInsets.all(20),
              //padding: EdgeInsets.all(20),
              child: Material(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(children: [
                      Expanded(child: Text("", style: TextStyle(fontSize: 16, color: ColorConstant.blue_1, fontFamily: ValueConstant.Montserrat))),
                      IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close, color: Colors.black))
                    ]),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: pdfRender,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false);
  }
}
