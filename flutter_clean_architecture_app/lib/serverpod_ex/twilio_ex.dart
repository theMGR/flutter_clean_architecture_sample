import 'package:flearn/main.dart';
import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class TwilioEx extends StatefulWidget {
  const TwilioEx({
    super.key,
  });

  @override
  _TwilioExState createState() => _TwilioExState();
}

class _TwilioExState extends State<TwilioEx> {
  String accountSid = 'ACf984d44380439d93a2e3a65f25557e78', authToken = '17b13ef97719666f498e31e86255f57e', twilioNumber = '+16203028456', messagingServiceSid = 'MG7af6cc09dec12002710b0224d98e4d86';

  late TwilioFlutter twilioFlutter;
  late TwilioMessagingService twilioMessagingService;

  String? _resultMessage;
  String? _errorMessage;

  final _tecPhone = TextEditingController();
  final _tecOtp = TextEditingController();
  final _tecMessage = TextEditingController();
  bool isOtpSend = false;

  @override
  void initState() {
    twilioFlutter = TwilioFlutter(accountSid: accountSid, authToken: authToken, twilioNumber: twilioNumber);
    twilioMessagingService = TwilioMessagingService(accountSid: accountSid, authToken: authToken, messagingServiceSid: messagingServiceSid);
    super.initState();
  }

  void sendSms(String phone, [String message = 'hello world']) async {
    try {
      TwilioResponse twilioResponse = await twilioFlutter.sendSMS(toNumber: "+91$phone", messageBody: message);

      print('****> sendSMS twilioResponse: ${twilioResponse.toString()}');

      setState(() {
        if (twilioResponse.responseState == ResponseState.SUCCESS) {
          _errorMessage = null;
          _resultMessage = 'SMS sent';
        } else {
          _errorMessage = 'Failed to send SMS';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  Future<void> sendWhatsApp(String phone, [String message = 'hello world']) async {
    try {
      TwilioResponse twilioResponse = await twilioFlutter.sendWhatsApp(toNumber: '+91$phone', messageBody: message);

      print('****> sendWhatsapp twilioResponse: ${twilioResponse.toString()}');

      setState(() {
        if (twilioResponse.responseState == ResponseState.SUCCESS) {
          _errorMessage = null;
          _resultMessage = 'Whatsapp message sent';
        } else {
          _errorMessage = 'Failed to send Whatsapp message';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  void getSms() async {
    TwilioResponse twilioResponse = await twilioFlutter.getSmsList();

    await twilioFlutter.getSMS('');
  }

  void sendScheduledSms() async {
    await twilioMessagingService.sendScheduledSms(toNumber: '', messageBody: 'hello world', sendAt: '2024-03-18T16:18:55Z');
  }

  void cancelScheduledSMS() async {
    TwilioResponse twilioResponse = await twilioMessagingService.cancelScheduledSms(messageSid: '');
  }

  void sendOTP(String phone) async {
    try {
      final otp = await client.mobileAuthEndPoint.generateOTP("+91$phone");

      setState(() {
        if (otp != null) {
          isOtpSend = true;

          _errorMessage = null;
          _resultMessage = 'OTP sent to $phone';
        } else {
          _errorMessage = 'Failed to send OTP';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  void verifyOTP(String phone, String otp) async {
    try {
      final isVerified = await client.mobileAuthEndPoint.verifyOTP("+91$phone", otp);

      setState(() {
        if (isVerified) {
          _errorMessage = null;
          _resultMessage = 'OTP verified successfully';
        } else {
          _errorMessage = 'Failed to verify OTP';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Twilio Ex', style: TextStyle(fontSize: 20)),
        SizedBox(height: 10),
        TextField(
          controller: _tecPhone,
          decoration: const InputDecoration(
            hintText: 'Enter your phone number',
          ),
        ),
        SizedBox(height: 10),
        if (isOtpSend) ...[
          TextField(
            controller: _tecOtp,
            decoration: const InputDecoration(
              hintText: 'Enter OTP',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => verifyOTP(_tecPhone.text, _tecOtp.text),
            child: const Text('Verify OTP'),
          ),
        ] else ...[
          ElevatedButton(
            onPressed: () => sendOTP(_tecPhone.text),
            child: const Text('Send OTP'),
          ),
        ],
        SizedBox(height: 10),
        TextField(
          controller: _tecMessage,
          decoration: const InputDecoration(
            hintText: 'Enter message',
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => sendSms(_tecPhone.text, _tecMessage.text),
              child: const Text('Send SMS'),
            ),
            ElevatedButton(
              onPressed: () => sendWhatsApp(_tecPhone.text, _tecMessage.text),
              child: const Text('Send Whatsapp'),
            ),
          ],
        ),
        SizedBox(height: 10),
        _ResultDisplay(
          resultMessage: _resultMessage,
          errorMessage: _errorMessage,
        ),
      ],
    );
  }
}

class _ResultDisplay extends StatelessWidget {
  final String? resultMessage;
  final String? errorMessage;

  const _ResultDisplay({
    this.resultMessage,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    String text;
    Color backgroundColor;
    if (errorMessage != null) {
      backgroundColor = Colors.red[300]!;
      text = errorMessage!;
    } else if (resultMessage != null) {
      backgroundColor = Colors.green[300]!;
      text = resultMessage!;
    } else {
      backgroundColor = Colors.grey[300]!;
      text = 'No server response yet.';
    }

    return Container(
      height: 50,
      color: backgroundColor,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
