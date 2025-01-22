import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'validation_utils.dart';

enum INPUT_TYPE {
  ALPHA,
  ALPHA_WITH_SPACE,
  ALPHA_NUMERIC,
  ALPHA_NUMERIC_WITH_SPACE,
  ALPHA_NUMERIC_SPECIAL_CHAR,
  ALPHANUMERIC_SPECIAL_CHAR_WITH_SPACE,
  NUMERIC,
  NUMERIC_FLOAT,
  NUMERIC_FLOAT_POSITIVE,
  NUMERIC_INT,
  EMAIL,
  MOBILE,
  DIGITS,
  DRIVING_LICENSE,
  VEHICLE_REGISTRATION_NUMBER
}

class InputTypeUtils {
  static TextInputType getTextInputType(INPUT_TYPE inputType) {
    if (inputType != null) {
      if (inputType == INPUT_TYPE.ALPHA) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.ALPHA_WITH_SPACE) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC_WITH_SPACE) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC_SPECIAL_CHAR) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.ALPHANUMERIC_SPECIAL_CHAR_WITH_SPACE) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.NUMERIC) {
        return TextInputType.number;
      } else if (inputType == INPUT_TYPE.NUMERIC_FLOAT) {
        return TextInputType.number;
      } else if (inputType == INPUT_TYPE.NUMERIC_FLOAT_POSITIVE) {
        return TextInputType.number;
      } else if (inputType == INPUT_TYPE.NUMERIC_INT) {
        return TextInputType.number;
      } else if (inputType == INPUT_TYPE.MOBILE) {
        return TextInputType.phone;
      } else if (inputType == INPUT_TYPE.EMAIL) {
        return TextInputType.emailAddress;
      } else if (inputType == INPUT_TYPE.DIGITS) {
        //return TextInputType.phone;
        return TextInputType.numberWithOptions(decimal: false, signed: true);
      } else if (inputType == INPUT_TYPE.DRIVING_LICENSE) {
        return TextInputType.text;
      } else if (inputType == INPUT_TYPE.VEHICLE_REGISTRATION_NUMBER) {
        return TextInputType.text;
      } else {
        return TextInputType.text;
      }
    } else {
      return TextInputType.text;
    }
  }

  static List<TextInputFormatter> getTextInputFormatter(INPUT_TYPE inputType) {
    //return <TextInputFormatter>[FilteringTextInputFormatter(getRegExp(inputType), allow: true)];
    bool isCaps = inputType == INPUT_TYPE.DRIVING_LICENSE || inputType == INPUT_TYPE.VEHICLE_REGISTRATION_NUMBER;
    return <TextInputFormatter>[CustomTextInputFormatter(getRegExp(inputType), isCaps: isCaps)];
  }

  static RegExp getRegExp(INPUT_TYPE inputType) {
    RegExp regExp = ValidationUtils.ALPHANUMERIC;
    if (inputType != null) {
      if (inputType == INPUT_TYPE.ALPHA) {
        regExp = ValidationUtils.ALPHA;
      } else if (inputType == INPUT_TYPE.ALPHA_WITH_SPACE) {
        regExp = ValidationUtils.ALPHA_WITH_SPACE;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC) {
        regExp = ValidationUtils.ALPHANUMERIC;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC_WITH_SPACE) {
        regExp = ValidationUtils.ALPHANUMERIC_WITH_SPACE;
      } else if (inputType == INPUT_TYPE.ALPHA_NUMERIC_SPECIAL_CHAR) {
        regExp = ValidationUtils.ALPHANUMERIC_SPECIAL_CHAR;
      } else if (inputType == INPUT_TYPE.ALPHANUMERIC_SPECIAL_CHAR_WITH_SPACE) {
        regExp = ValidationUtils.ALPHANUMERIC_SPECIAL_CHAR_WITH_SPACE;
      } else if (inputType == INPUT_TYPE.NUMERIC) {
        regExp = ValidationUtils.NUMERIC;
      } else if (inputType == INPUT_TYPE.NUMERIC_FLOAT) {
        regExp = ValidationUtils.FLOAT;
      } else if (inputType == INPUT_TYPE.NUMERIC_FLOAT_POSITIVE) {
        regExp = ValidationUtils.FLOAT_POSITIVE;
      } else if (inputType == INPUT_TYPE.NUMERIC_INT) {
        regExp = ValidationUtils.INT;
      } else if (inputType == INPUT_TYPE.MOBILE) {
        regExp = ValidationUtils.MOBILE_NUMBER;
      } else if (inputType == INPUT_TYPE.EMAIL) {
        regExp = ValidationUtils.ALPHANUMERIC_SPECIAL_CHAR;
      } else if (inputType == INPUT_TYPE.DIGITS) {
        regExp = ValidationUtils.DIGITS;
      } else if (inputType == INPUT_TYPE.DRIVING_LICENSE) {
        regExp = ValidationUtils.DRIVING_LICENSE;
      } else if (inputType == INPUT_TYPE.VEHICLE_REGISTRATION_NUMBER) {
        regExp = ValidationUtils.VEHICLE_REGISTRATION_NUMBER;
      } else {
        regExp = ValidationUtils.ALPHANUMERIC_SPECIAL_CHAR;
      }
    } else {
      regExp = ValidationUtils.ALPHANUMERIC_SPECIAL_CHAR;
    }

    return regExp;
  }
}

class CustomTextInputFormatter extends TextInputFormatter {
  final RegExp filterPattern;
  final bool allow;
  final String replacementString;
  final bool isCaps;

  CustomTextInputFormatter(this.filterPattern, {this.allow = true, this.replacementString = '', this.isCaps = false});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue,) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();
      return TextEditingValue(
        text: trimedText,
        //selection: TextSelection(baseOffset: trimedText.length, extentOffset: trimedText.length), // this will set cursor to last position
      );
    } else {
      return _selectionAwareTextManipulation( //taken from text_formatter -> FilteringTextInputFormatter
        newValue,
        isCaps,
        (String substring) {
          return substring.splitMapJoin(
            filterPattern,
            onMatch: !allow ? (Match match) => replacementString : null,
            onNonMatch: allow ? (String nonMatch) => nonMatch.isNotEmpty ? replacementString : '' : null,
          );
        },
      );
    }
  }

  TextEditingValue _selectionAwareTextManipulation(TextEditingValue value, bool isCaps, String Function(String substring) substringManipulation) {
    final int selectionStartIndex = value.selection.start;
    final int selectionEndIndex = value.selection.end;
    String manipulatedText;
    TextSelection? manipulatedSelection;

    if (selectionStartIndex < 0 || selectionEndIndex < 0) {
      manipulatedText = substringManipulation(value.text);
    } else {
      final String beforeSelection = substringManipulation(
        value.text.substring(0, selectionStartIndex),
      );
      final String inSelection = substringManipulation(
        value.text.substring(selectionStartIndex, selectionEndIndex),
      );
      final String afterSelection = substringManipulation(
        value.text.substring(selectionEndIndex),
      );
      manipulatedText = beforeSelection + inSelection + afterSelection;
      if (value.selection.baseOffset > value.selection.extentOffset) {
        manipulatedSelection = value.selection.copyWith(
          baseOffset: beforeSelection.length + inSelection.length,
          extentOffset: beforeSelection.length,
        );
      } else {
        manipulatedSelection = value.selection.copyWith(
          baseOffset: beforeSelection.length,
          extentOffset: beforeSelection.length + inSelection.length,
        );
      }
    }

    return TextEditingValue(
      text: isCaps ? manipulatedText.toUpperCase() : manipulatedText,
      selection: manipulatedSelection ?? const TextSelection.collapsed(offset: -1),
      composing: manipulatedText == value.text ? value.composing : TextRange.empty,
    );
  }
}