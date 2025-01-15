// ignore_for_file: unused_field

/*
Black:   \x1B[30m
Red:     \x1B[31m
Green:   \x1B[32m
Yellow:  \x1B[33m
Blue:    \x1B[34m
Magenta: \x1B[35m
Cyan:    \x1B[36m
White:   \x1B[37m
Reset:   \x1B[0m
*/

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

enum PrintType { defaultPrint, warning, error, success, info }

class Print {
  static const String _black = "\x1B[30m";
  static const String _red = "\x1B[31m";
  static const String _green = "\x1B[32m";
  static const String _yellow = "\x1B[33m";
  static const String _blue = "\x1B[34m";
  static const String _magenta = "\x1B[35m";
  static const String _cyan = "\x1B[36m";
  static const String _white = "\x1B[37m";
  static const String _reset = "\x1B[0m";
  static const String _purpleLight = "\x1B[38;2;153;0;153m"; //RGB
  static const String _navyLight = "\x1B[38;2;84;140;168m"; //RGB

  Print(Object text, {bool isPrint = true, bool isLog = false, PrintType printType = PrintType.defaultPrint}) {
    if (kDebugMode) {
      if (printType == PrintType.defaultPrint) {
        defaultPrint(text, isLog: isLog, isPrint: isPrint);
      } else if (printType == PrintType.error) {
        error(text, isLog: isLog, isPrint: isPrint);
      } else if (printType == PrintType.success) {
        success(text, isLog: isLog, isPrint: isPrint);
      } else if (printType == PrintType.info) {
        info(text, isLog: isLog, isPrint: isPrint);
      } else if (printType == PrintType.warning) {
        warning(text, isLog: isLog, isPrint: isPrint);
      }
    }
  }

  static void warning(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _yellow;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

  static void defaultPrint(Object? text, {bool isPrint = true, bool isLog = false}) {
    if (isPrint && text != null) {
      String message = text.toString();
      if (isLog) {
        log(message);
      } else {
        print(message);
      }
    }
  }

  static void error(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _red;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

  static void success(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _green;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

  static void info(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _blue;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

  static void debug(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _navyLight;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

  static void reference(Object? text, {bool isPrint = true, bool isLog = false}) {
    String color = _purpleLight;
    if (isPrint && text != null) {
      String message = color + text.toString() + _reset;
      if (isLog) {
        log(text.toString(), name: DateTime.now().toString());
      } else {
        print(message);
      }
    }
  }

  static String getPrettyJSONString(jsonObject) {
    var encoder = JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  static void jsonLog(jsonObject, String? name) {
    log(getPrettyJSONString(jsonObject), name: name ?? DateTime.now().toString());
  }

  static void print(String text) {
    _Print.print_(text);
  }
}

class _Print {
  static void print_(String text) {
    if (kDebugMode) {
      print(text);
    }
  }
}
