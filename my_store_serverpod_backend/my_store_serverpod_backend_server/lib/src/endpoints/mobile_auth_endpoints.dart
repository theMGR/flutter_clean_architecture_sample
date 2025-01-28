import 'package:my_store_serverpod_backend_server/src/generated/mobile_auth_model.dart';
import 'package:serverpod/server.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class MobileAuthEndPoint extends Endpoint {
  String accountSid = 'ACf984d44380439d93a2e3a65f25557e78', authToken = '17b13ef97719666f498e31e86255f57e', twilioNumber = '+16203028456';

  late TwilioFlutter twilioFlutter;

  MobileAuthEndPoint() {
    twilioFlutter = TwilioFlutter(accountSid: accountSid, authToken: authToken, twilioNumber: twilioNumber);
  }

  Future<MobileAuthModel?> addMobileAuth(Session session, MobileAuthModel input) async {
    try {
      var result = await MobileAuthModel.db.insertRow(session, input);
      return result;
    } catch (e) {
      session.log("Failed to insert auth model: $e");
      return null;
    }
  }

  Future<MobileAuthModel?> getMobileAuthByPhone(Session session, String phone) async {
    try {
      var result = await MobileAuthModel.db.findFirstRow(session, where: (p0) => p0.phone.equals(phone));
      session.log("****> getMobileAuthByPhone ($phone): ${result?.toJson().toString()}");
      return result;
    } catch (e) {
      session.log("Failed to get auth model by phone: $e");
      return null;
    }
  }

  Future<bool> updateToken(Session session, String phone, String token) async {
    try {
      var authEntry = await getMobileAuthByPhone(session, phone);

      if (authEntry != null) {
        authEntry.token = token;
        authEntry.updatedAt = DateTime.now().toUtc();
        await MobileAuthModel.db.insertRow(session, authEntry);
        return true;
      }

      return false;
    } catch (e) {
      session.log("Failed to update token: $e");
      return false;
    }
  }

  Future<bool> verifyOTP(Session session, String phone, String otp) async {
    try {
      var authEntry = await getMobileAuthByPhone(session, phone);

      session.log('****> verifyOTP : ${authEntry?.toJson().toString()} ');

      if (authEntry != null) {
        if (authEntry.otp == otp && authEntry.otpExpiration?.isAfter(DateTime.now()) == true) {
          return true;
        } else {
          return false;
        }
      }

      return false;
    } catch (e) {
      session.log("Failed to verify otp: $e");
      return false;
    }
  }

  Future<String?> generateOTP(Session session, String phone) async {
    try {
      var otp = _generateRandomOTP();
      session.log('Generate otp: $otp');

      var authEntry = await getMobileAuthByPhone(session, phone);

      if (authEntry != null) {
        authEntry.otp = otp;
        authEntry.otpExpiration = DateTime.now().add(Duration(minutes: 5));
        var update = await MobileAuthModel.db.updateRow(session, authEntry);
        session.log('****> generateOTP update: ${update.toJson().toString()}');
      } else {
        var authEntry = MobileAuthModel(
          phone: phone,
          otp: otp,
          token: '',
          otpExpiration: DateTime.now().add(Duration(minutes: 5)),
          createdAt: DateTime.now().toUtc(),
          updatedAt: DateTime.now().toUtc(),
        );

        var update = await addMobileAuth(session, authEntry);

        session.log('****> generateOTP update: ${update?.toJson().toString()}');

        await twilioFlutter.sendSMS(toNumber: phone, messageBody: 'Your OTP is $otp, it will expired in 5 minutes');
      }

      return otp;
    } catch (e) {
      session.log("Failed to generate otp: $e");
      return null;
    }
  }

  String _generateRandomOTP() {
    final random = DateTime.now().microsecondsSinceEpoch % 10000;
    return random.toString().padLeft(4, '0');
  }
}
