
// ignore_for_file: non_constant_identifier_names
import 'email_validator.dart';

class ValidationUtils {
  static RegExp ALPHA = RegExp(r'[a-zA-Z]');
  static RegExp ALPHA_WITH_SPACE = RegExp(r'[a-zA-Z\s]+');
  static RegExp ALPHANUMERIC = RegExp(r'[a-zA-Z0-9]');
  static RegExp ALPHANUMERIC_WITH_SPACE = RegExp(r'[a-zA-Z0-9\s]+');
  static RegExp ALPHANUMERIC_SPECIAL_CHAR = RegExp(r"[A-Za-z0-9_@.,*%$(){}?<>=/#&+-]+");
  static RegExp ALPHANUMERIC_SPECIAL_CHAR_WITH_SPACE = RegExp(r"[A-Za-z0-9_*(){}<>=@.:;%$,?/#&+-\s]+");
  static RegExp NUMERIC = RegExp(r'-?[0-9]');
  static RegExp INT = RegExp(r'(^\-?\d*)');
  static RegExp FLOAT = RegExp(r'(^\-?\d*\.?\d*)');
  static RegExp FLOAT_POSITIVE = RegExp(r'(^\d*\.?\d*)');
  static RegExp PAN = RegExp(r"^[A-Z]{5}[0-9]{4}[A-Z]");
  static RegExp MOBILE_NUMBER = RegExp(r"^[6789][0-9]{9}");
  static RegExp PIN_CODE = RegExp(r"^[1-9][0-9]{5}");
  static RegExp GST_NUMBER = RegExp(r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}");
  static RegExp DIGITS = RegExp(r'[0-9]');
  //static RegExp VEHICLE_NUMBER = RegExp(r'(?:[A-Za-z]+|\d+)');
  //static RegExp VEHICLE_NUMBER = RegExp(r'[A-Z]{2}[\\ -]{0,1}[0-9]{2}[\\ -]{0,1}[A-Z]{1,2}[\\ -]{0,1}[0-9]{4}'); //TN99AB1234
  //static RegExp VEHICLE_NUMBER_NO_SECOND_ALPHABET = RegExp(r'[A-Z]{2}[\\ -]{0,1}[0-9]{2}[\\ -]{0,1}[0-9]{4}'); //TN991234
  static RegExp VEHICLE_NUMBER_ALPHABET_1 = RegExp(r"^[A-Z]{2}[0-9]{1}[1-9]{1}[A-Z]{1}[0-9]{4}"); //TN99A1234
  static RegExp VEHICLE_NUMBER_ALPHABET_2 = RegExp(r"^[A-Z]{2}[0-9]{1}[1-9]{1}[A-Z]{2}[0-9]{4}"); //TN99AB1234
  static RegExp VEHICLE_NUMBER_NO_SECOND_ALPHABET = RegExp(r"^[A-Z]{2}[0-9]{1}[1-9]{1}[0-9]{4}"); //TN991234
  static RegExp VEHICLE_NUMBER_ALPHABET_1_0000 = RegExp(r"^[A-Z]{2}[0-9]{1}[1-9]{1}[A-Z]{1}[0]{4}"); //TN99A0000
  static RegExp VEHICLE_NUMBER_ALPHABET_2_0000 = RegExp(r"^[A-Z]{2}[0-9]{1}[1-9]{1}[A-Z]{2}[0]{4}"); //TN99AB0000
  static RegExp VEHICLE_NUMBER_NO_SECOND_ALPHABET_0000 = RegExp(r"^[A-Z]{2}[0-9]{1}[1-9]{1}[0]{4}"); //TN990000

  // 8-16 characters password with at least one digit,
  // at least one lowercase letter at least one uppercase letter,
  // at least one special character with no whitespaces
  static RegExp PASSWORD = RegExp(r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,16}");

  /// Driving license format
  /*
  Total number of input characters should be exactly 16 (including space or '-').

  SS-RRYYYYNNNNNNN OR SSRR YYYYNNNNNNN OR SSRRZYYYYNNNNNNN

  SS - Two character State Code (like RJ for Rajasthan, TN for Tamil Nadu etc)
  RR - Two digit RTO Code
  YYYY - 4-digit Year of Issue
  NNNNNNN - Rest of the numbers are to be given in 7 digits

  example:
  TN33Z20110001540
  TN33 20110001540
  TN-3320110001540
  */
  static RegExp DRIVING_LICENSE_DASH = RegExp(r'^[A-Z]{2}[\-]{1}[0-9]{1}[1-9]{1}[1-9]{1}[0-9]{3}[0-9]{7}'); // TN-3320110001540
  static RegExp DRIVING_LICENSE_SPACE = RegExp(r'^[A-Z]{2}[0-9]{1}[1-9]{1}[\s][1-9]{1}[0-9]{3}[0-9]{7}'); // TN33 20110001540
  static RegExp DRIVING_LICENSE_SPACE2 = RegExp(r'^[A-Z]{2}[0-9]{1}[1-9]{1}[\s][1-9]{1}[0-9]{3}[\s][0-9]{7}'); // TN33 2011 0001540
  static RegExp DRIVING_LICENSE_AZ = RegExp(r'^[A-Z]{2}[0-9]{1}[1-9]{1}[A-Z]{1}[1-9]{1}[0-9]{3}[0-9]{7}'); // TN33Z20110001540
  // for 0 validation
  static RegExp DRIVING_LICENSE_DASH_0 = RegExp(r'^[A-Z]{2}[\-]{1}[0]{2}[0]{4}[0]{7}'); // TN-0000000000000
  static RegExp DRIVING_LICENSE_SPACE_0 = RegExp(r'^[A-Z]{2}[0]{2}[\s][0]{4}[0]{7}'); // TN33 00000000000
  static RegExp DRIVING_LICENSE_SPACE2_0 = RegExp(r'^[A-Z]{2}[0]{2}[\s][0]{4}[\s][0]{7}'); // TN00 0000 0000000
  static RegExp DRIVING_LICENSE_AZ_0 = RegExp(r'^[A-Z]{2}[0]{2}[A-Z]{1}[0]{4}[0]{7}'); // TN00Z00000000000

  static RegExp DRIVING_LICENSE = RegExp(r"[A-Z0-9\s\-]+");
  static RegExp VEHICLE_REGISTRATION_NUMBER = RegExp(r'[A-Z0-9]');


  static bool isValidPAN({required String pan}) {
    return PAN.hasMatch(pan.trim());
  }

  static bool isValidMobileNumber({required String mobileNumber}) {
    return MOBILE_NUMBER.hasMatch(mobileNumber.trim());
  }

  static bool isValidPinCode({required String pin}) {
    return PIN_CODE.hasMatch(pin.trim());
  }

  static bool isValidEmail({required String email}) {
    return EmailValidator.validate(email);
  }

  static bool isValidGSTIN({required String gstNumber}) {
    return GST_NUMBER.hasMatch(gstNumber.trim());
  }

  static bool isValidVehicleNumber({required String vehicleNumber}) {
    vehicleNumber = vehicleNumber.trim();
    int length = vehicleNumber.length;

    if (length == 9 && vehicleNumber.substring(5, 9) != "0000" && !VEHICLE_NUMBER_ALPHABET_1_0000.hasMatch(vehicleNumber) && VEHICLE_NUMBER_ALPHABET_1.hasMatch(vehicleNumber)) { //TN99A1234
      return true;
    } else if (length == 10 && vehicleNumber.substring(6, 10) != "0000"  && !VEHICLE_NUMBER_ALPHABET_2_0000.hasMatch(vehicleNumber) && VEHICLE_NUMBER_ALPHABET_2.hasMatch(vehicleNumber)) { //TN99AB1234
      return true;
    } else if (length == 8 && vehicleNumber.substring(4, 8) != "0000"  && !VEHICLE_NUMBER_NO_SECOND_ALPHABET_0000.hasMatch(vehicleNumber) && VEHICLE_NUMBER_NO_SECOND_ALPHABET.hasMatch(vehicleNumber)) { //TN991234
      return true;
    } else {
      return false;
    }
  }

  static bool isValidDrivingLicense({required String drivingLicense}) {
    drivingLicense = drivingLicense.toUpperCase().trim();
    int length = drivingLicense.length;

    if (length == 16 && drivingLicense.substring(9, 16) != "0000000" && !DRIVING_LICENSE_DASH_0.hasMatch(drivingLicense) && DRIVING_LICENSE_DASH.hasMatch(drivingLicense)) {  // TN-3320110001540
      return true;
    } else if (length == 16 && drivingLicense.substring(9, 16) != "0000000" && !DRIVING_LICENSE_SPACE_0.hasMatch(drivingLicense) && DRIVING_LICENSE_SPACE.hasMatch(drivingLicense)) { // TN33 20110001540
      return true;
    } else if (length == 17 && drivingLicense.substring(10, 17) != "0000000" && !DRIVING_LICENSE_SPACE2_0.hasMatch(drivingLicense) && DRIVING_LICENSE_SPACE2.hasMatch(drivingLicense)) { // TN33 2011 0001540
      return true;
    } else if (length == 16 && drivingLicense.substring(9, 16) != "0000000" && !DRIVING_LICENSE_AZ_0.hasMatch(drivingLicense) && DRIVING_LICENSE_AZ.hasMatch(drivingLicense)) { // TN33Z20110001540
      return true;
    } else {
      return false;
    }
  }

  static bool isAlpha({required String text}) {
    return ALPHA.hasMatch(text.trim());
  }

  static bool isAlphaNumeric({required String text}) {
    return ALPHANUMERIC.hasMatch(text.trim());
  }

  static bool isNumeric({required String text}) {
    return NUMERIC.hasMatch(text.trim());
  }

  static bool isNumericInt({required String text}) {
    return INT.hasMatch(text.trim());
  }

  static bool isNumericFloat({required String text}) {
    return FLOAT.hasMatch(text.trim());
  }

  static bool isEmpty(String? val) {
    //return (val != null && val.isNotEmpty && !val.toLowerCase().contains("null") && val.trim().length > 0) ? false : true;
    try {
      return (val != null && val.isNotEmpty && !val.toLowerCase().contains("null") && val.trim().length > 0) ? false : true;
    } catch (e) {
      return true;
    }
  }

  static bool isValidPassword_Min8_Char_Caps_AlphaNumeric({required String password}) {
    return PASSWORD.hasMatch(password.trim());
  }

  static bool isNumericIntOrDouble(String val) {
    if (isEmpty(val)) {
      return false;
    }
    return double.tryParse(val) != null;
  }

  static int getInt(String s) {
    try {
      return int.parse(s);
    } catch (e) {
      return 0;
    }
  }

  static double getDouble(String? s) {
    if(s != null) {
      try {
        return double.parse(s);
      } catch (e) {
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }

  static num getNum(String s) {
    try {
      return num.parse(s);
    } catch (e) {
      return 0;
    }
  }

  static String getValueFromString(String val) {
    return isEmpty(val) ? "-" : val;
  }

  static String getValueFromInt(int val) {
    return getInt(val.toString()) > 0 ? "$val" : "-";
  }

  static String getValueFromDouble(double val) {
    return getDouble(val.toString()) > 0 ? "$val" : "-";
  }

  static String getValueFromNum(num val) {
    return getNum(val.toString()) > 0 ? "$val" : "-";
  }

  static String? removeMiddleSpace(String? text) {
    return text != null ? text.trim().replaceAll(RegExp(' +'), ' ') : null;
  }
}
