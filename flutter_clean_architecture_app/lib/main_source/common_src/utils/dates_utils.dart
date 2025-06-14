import 'package:flearn/main_source/common_src/constants/date_constants.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'print_utils.dart';
import 'validation_utils.dart';

class DatesUtils {

  static String? convertToHumanDate(String? date, {String dateFormat = 'yyyy-MM-dd HH:mm:ss'}) {
    String serverFormat = "";
    initializeDateFormatting(Intl.systemLocale, null);
    if (date != null && !ValidationUtils.isEmpty(date)) {
      try {
        DateTime dateTime = DateTime.parse(date);
        //Print.debug("Datetime: "+dateTime.toLocal().toString() + " year: ${dateTime.year.toString()}"+ " month: ${dateTime.month.toString()}"+" date: ${dateTime.day.toString()}" + " hour: ${dateTime.hour.toString()}" +" minute: ${dateTime.minute.toString()}" + " second: ${dateTime.second.toString()}");

        //Print.debug("${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()} ${dateTime.hour.toString()}-${dateTime.minute.toString()}-${dateTime.second.toString()}");
        serverFormat = DateFormat(dateFormat).format(dateTime);
        return serverFormat;
      } on FormatException catch (e) {
        Print.debug(e.toString());
        return null;
      }
    }
    return null;
  }

  static String? convertToServerDate(String? date) {
    String serverFormat = "";
    initializeDateFormatting(Intl.systemLocale, null);
    if (date != null && !ValidationUtils.isEmpty(date)) {
      try {
        DateTime dateTime = DateTime.parse(date);
        //Print.debug("Datetime: "+dateTime.toLocal().toString() + " year: ${dateTime.year.toString()}"+ " month: ${dateTime.month.toString()}"+" date: ${dateTime.day.toString()}" + " hour: ${dateTime.hour.toString()}" +" minute: ${dateTime.minute.toString()}" + " second: ${dateTime.second.toString()}");

        //Print.debug("${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()} ${dateTime.hour.toString()}-${dateTime.minute.toString()}-${dateTime.second.toString()}");
        serverFormat = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
        return serverFormat;
      } on FormatException catch (e) {
        Print.debug(e.toString());
        return null;
      }
    }
    return null;
  }

  // "EEE, MMM dd yyyy, hh:mm a"


  static String? formatDate(String? date, String? dateFormat) {
    initializeDateFormatting(Intl.systemLocale, null);

    if (!ValidationUtils.isEmpty(date) && !ValidationUtils.isEmpty(dateFormat)) {
      try {
        if (!ValidationUtils.isEmpty(detectDateFormat(date))) {
          // Define the input format matching your date string
          DateFormat inputFormat = DateFormat(detectDateFormat(date), "en_US");
          DateTime dateTime = inputFormat.parse(date!);

          // Define the desired output format
          DateFormat outputFormat = DateFormat(dateFormat);

          return outputFormat.format(dateTime);
        } else {
          DateTime dateTime = DateTime.parse(date!);
          return DateFormat(dateFormat).format(dateTime);
        }
      } on FormatException catch (e) {
        Print.debug(e.toString());
        return null;
      }
    } else {
      return null;
    }
  }

  static String detectDateFormat(String? dateString) {
    if (!ValidationUtils.isEmpty(dateString)) {
      List<String> formatsToCheck = [
        DateConstants.DDMMYYYY,
        DateConstants.DDMMYYYY_HHMMA,
        DateConstants.DDMMYYYY_HHMMSS,
        DateConstants.YYYYMMDDHHMMSS,
        DateConstants.EEEMMMDDYYYHHMMA,
        DateConstants.YYYY_MM_DD_HH_MM_SS,
        DateConstants.YYYY_MM_DD,
        DateConstants.SERVICE,
        DateConstants.SERVICE_Z,
        DateConstants.DDMMYYYY_SLASH,
        DateConstants.ddMMMyyy
      ];

      for (String format in formatsToCheck) {
        try {
          DateTime parsedDate = DateFormat(format).parseStrict(dateString!);
          if (parsedDate != null) {
            return format;
          }
        } catch (e) {
          // Parsing failed for the current format, try the next one
        }
      }
    }
    // If no format matches, return an empty string or a default format
    return "";
  }
  static String secondsToHhMmSs(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = (hours < 10) ? '0$hours' : '$hours';
    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr = (remainingSeconds < 10) ? '0$remainingSeconds' : '$remainingSeconds';

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}