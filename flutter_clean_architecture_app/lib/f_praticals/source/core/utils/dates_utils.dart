
import 'package:flearn/f_praticals/source/core/utils/print_utils.dart';
import 'package:flearn/f_praticals/source/core/utils/validation_utils.dart';
import 'package:flearn/f_praticals/source/constants/ui_constants.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DatesUtils {

  static String? convertToHumanDate(String? date, {String dateFormat = 'yyyy-MM-dd HH:mm:ss'}) {
    String serverFormat = "";
    initializeDateFormatting(Intl.systemLocale, null);
    if (date != null && !ValidationUtils.isEmpty(date)) {
      try {
        DateTime dateTime = DateTime.parse(date);
        //Print.Debug("Datetime: "+dateTime.toLocal().toString() + " year: ${dateTime.year.toString()}"+ " month: ${dateTime.month.toString()}"+" date: ${dateTime.day.toString()}" + " hour: ${dateTime.hour.toString()}" +" minute: ${dateTime.minute.toString()}" + " second: ${dateTime.second.toString()}");

        //Print.Debug("${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()} ${dateTime.hour.toString()}-${dateTime.minute.toString()}-${dateTime.second.toString()}");
        serverFormat = DateFormat(dateFormat).format(dateTime);
        return serverFormat;
      } on FormatException catch (e) {
        Print.Debug(e.toString());
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
        //Print.Debug("Datetime: "+dateTime.toLocal().toString() + " year: ${dateTime.year.toString()}"+ " month: ${dateTime.month.toString()}"+" date: ${dateTime.day.toString()}" + " hour: ${dateTime.hour.toString()}" +" minute: ${dateTime.minute.toString()}" + " second: ${dateTime.second.toString()}");

        //Print.Debug("${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()} ${dateTime.hour.toString()}-${dateTime.minute.toString()}-${dateTime.second.toString()}");
        serverFormat = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
        return serverFormat;
      } on FormatException catch (e) {
        Print.Debug(e.toString());
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
        Print.Debug(e.toString());
        return null;
      }
    } else {
      return null;
    }
  }

  static String detectDateFormat(String? dateString) {
    if (!ValidationUtils.isEmpty(dateString)) {
      List<String> formatsToCheck = [
        UIConstants.DATE_FORMAT_YYYYMMDD,
        UIConstants.DATE_FORMAT_DDMMYYYY,
        UIConstants.DATE_FORMAT_DDMMYYYY_HHMMA,
        UIConstants.DATE_FORMAT_DDMMYYYY_HHMMSS,
        UIConstants.DATE_FORMAT_YYYYMMDDHHMMSS,
        UIConstants.DATE_FORMAT_EEEMMMDDYYYHHMMA,
        UIConstants.DATE_FORMAT_YYYY_MM_DD_HH_MM_SS,
        UIConstants.DATE_FORMAT_YYYY_MM_DD,
        UIConstants.DATE_FORMAT_SERVICE,
        UIConstants.DATE_FORMAT_SERVICE_Z,
        UIConstants.DATE_FORMAT_DDMMYYYY_SLASH,
        UIConstants.DATE_FORMAT_ddMMMyyy
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
}