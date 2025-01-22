import 'package:flearn/f_praticals/source/constants/color_constants.dart';
import 'package:flearn/f_praticals/source/constants/release_constant.dart';
import 'package:flearn/f_praticals/source/core/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordTextField extends StatefulWidget {
  String? text;
  //String? title;
  String? hint;
  String validationMessage;
  TextEditingController controller;
  TextInputType? inputType;

  //BaseViewModel? viewModel;
  Function(String?)? onSaved;
  Function(String)? onChanged;
  Function? validateFunction;
  InputBorder? border;
  int id;
  int? maxLength;
  bool obscureText;
  int maxLines;
  Icon? prefixIcon;
  Icon? suffixIcon;
  List<TextInputFormatter>? inputFormatters;
  String? textMatchString;
  bool? textmatch;
  bool? textFilled;
  FocusNode? focusNode;
  bool showtooltip;
  Function? tooltip;
  double borderRadius = 0;
  Color? borderColor = Colors.grey;
  Color? focusedBorderColor = Colors.grey;
  Color? enabledBorderColor = Colors.grey;
  Color? disabledBorderColor = Colors.grey;
  Color? errorBorderColor = Colors.grey;
  Color? focusedErrorBorderColor = Colors.grey;
  String? fontFamily;
  EdgeInsetsGeometry? textFieldContentPadding;
  double? textSize;
  //double titleSize;
  //Color? titleColor = ColorConstant.COLOR_LIGHT_GREY;
  Color? textColor = Colors.black;
  Color? hintTextColor = ColorConstant.COLOR_LIGHT_GREY;
  Color? labelTextColor = ColorConstant.COLOR_LIGHT_GREY;
  TextStyle? titleTextStyle;
  TextStyle? textStyle;
  TextStyle? hintTextStyle;
  TextStyle? labelTextStyle;
  Color fillColor;
  bool isColorFilled;
  String uiKey;
  String labelText;
  bool isMandatory;
  String mandatoryChar;
  Color mandatoryCharColor;

  PasswordTextField(
      {required this.uiKey,
      this.id = -9999,
      this.text,
      //this.title,
      this.hint,
      this.validationMessage = "Developer Please pass the Validation Message",
      this.prefixIcon,
      this.obscureText = false,
      this.suffixIcon,
      this.maxLength,
      this.textFilled,
      this.maxLines = 1,
      required this.controller,
      this.inputType,
      this.onSaved,
      this.onChanged,
      this.inputFormatters,
      this.textMatchString,
      this.border,
      this.textmatch,
      this.focusNode,
      this.validateFunction,
      this.showtooltip = false,
      this.tooltip,
      this.borderRadius = 0,
      this.borderColor = Colors.grey,
      this.focusedBorderColor = Colors.grey,
      this.enabledBorderColor = Colors.grey,
      this.disabledBorderColor = Colors.grey,
      this.errorBorderColor = Colors.grey,
      this.focusedErrorBorderColor = Colors.grey,
      this.textFieldContentPadding = const EdgeInsets.all(5),
      this.textSize = 14,
      //this.titleSize = 14,
      //this.titleColor = ColorConstant.COLOR_LIGHT_GREY,
      this.textColor = Colors.black,
      this.hintTextColor = ColorConstant.COLOR_LIGHT_GREY,
      this.labelTextColor = ColorConstant.LITE_BLACK,
      this.titleTextStyle,
      this.textStyle,
      this.hintTextStyle,
      this.labelTextStyle,
      this.fillColor = Colors.transparent,
      this.isColorFilled = true,
      this.labelText = "",
      this.isMandatory = false,
      this.mandatoryChar = "*",
      this.mandatoryCharColor = Colors.red,
      this.fontFamily}) {
    fontFamily = fontFamily ?? ReleaseConstant.Montserrat;
    labelTextStyle = labelTextStyle ?? TextStyle(color: labelTextColor, fontSize: textSize, fontFamily: fontFamily, fontWeight: FontWeight.w500);
    textStyle = textStyle ?? TextStyle(color: textColor, fontSize: textSize, fontFamily: fontFamily);
    hintTextStyle = hintTextStyle ?? TextStyle(color: hintTextColor, fontSize: textSize, fontFamily: fontFamily);
  }

  bool passwordVisible = true;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    if (widget.text != null && widget.text!.isNotEmpty) {
      String texts = widget.text!;
      widget.controller.text = texts;
    }
    widget.controller.selection = TextSelection.fromPosition(TextPosition(offset: widget.controller.text.length));

    return TextFormField(
      key: ValueKey(widget.uiKey),
      style: widget.textStyle == null ? TextStyle(color: widget.textColor, fontSize: widget.textSize, fontFamily: widget.fontFamily) : widget.textStyle,
      maxLength: widget.maxLength ?? null,
      maxLines: widget.maxLines,
      obscureText: !widget.obscureText,
      focusNode: widget.focusNode ?? null,
      autocorrect: false,
      autofocus: false,
      controller: widget.controller,
      onTap: widget.showtooltip ? widget.tooltip as void Function()? : () {},
      keyboardType: widget.inputType != null ? widget.inputType : null,
      textInputAction: TextInputAction.done,
      inputFormatters: widget.inputFormatters != null ? widget.inputFormatters : null,
      decoration: InputDecoration(
        counterText: '',
        label: !ValidationUtils.isEmpty(widget.labelText)
            ? RichText(
            text: TextSpan(children: [
              TextSpan(text: widget.labelText, style: widget.labelTextStyle),
              widget.isMandatory ? TextSpan(text: " ${widget.mandatoryChar}", style: TextStyle(color: widget.mandatoryCharColor, fontSize: widget.textSize, fontWeight: FontWeight.bold, fontFamily: widget.fontFamily)) : TextSpan(),
            ]))
            : null,
        fillColor: widget.fillColor,
        filled: widget.isColorFilled,
        contentPadding: widget.textFieldContentPadding,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.grey,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusedBorderColor ?? Colors.grey,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.enabledBorderColor ?? Colors.grey,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.disabledBorderColor ?? Colors.grey,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.errorBorderColor ?? Colors.grey,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusedErrorBorderColor ?? Colors.grey,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        prefixIcon: widget.prefixIcon ?? null,
        suffixIcon: InkWell(
          child: Icon(
            !widget.obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
            size: 18.0,
          ),
          onTap: () {
            getPasswordVisible();
          },
        ),
        hintText: widget.hint,
        hintStyle: widget.hintTextStyle == null ? TextStyle(color: widget.hintTextColor, fontFamily: widget.fontFamily) : widget.hintTextStyle,
        //labelStyle: widget.labelTextStyle == null ? TextStyle(color: widget.labelTextColor, fontFamily: widget.fontFamily) : widget.labelTextStyle,
        prefixIconConstraints: BoxConstraints(
          minHeight: widget.prefixIcon == null ? 5 : 38,
          minWidth: widget.prefixIcon == null ? 5 : 38,
        ),
        suffixIconConstraints: BoxConstraints(
          minHeight: 38,
          minWidth: 38,
        ),
      ),
      validator: (val) => widget.validateFunction!(val, widget.validationMessage),
      onSaved: (val) {
        if (widget.onSaved != null) {
          widget.onSaved!(val);
        }
      },
      onChanged: (val) {
        if (widget.onChanged != null) {
          widget.onChanged!(val);
        }
      },
    );
  }

  void getPasswordVisible() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }
}
