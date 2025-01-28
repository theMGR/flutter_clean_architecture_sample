import 'package:flearn/main.dart';
import 'package:flearn/serverpod_ex/twilio_ex.dart';
import 'package:flutter/material.dart';

class ServerPodEx extends StatefulWidget {
  const ServerPodEx({
    super.key,
  });

  @override
  State<ServerPodEx> createState() => ServerPodExState();
}

class ServerPodExState extends State<ServerPodEx> {
  // These fields hold the last result or error message that we've received from
  // the server or null if no result exists yet.
  String? _resultMessage;
  String? _errorMessage;

  final _textEditingController = TextEditingController();

  // Calls the `hello` method of the `example` endpoint. Will set either the
  // `_resultMessage` or `_errorMessage` field, depending on if the call
  // is successful.
  void _callHello() async {
    try {
      final result = await client.example.hello(_textEditingController.text);
      setState(() {
        _errorMessage = null;
        _resultMessage = result;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('dsada'),),
      body: ListView(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        children: [
          SizedBox(height: 60),
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _callHello,
            child: const Text('Send to Server'),
          ),
          SizedBox(height: 10),
          _ResultDisplay(
            resultMessage: _resultMessage,
            errorMessage: _errorMessage,
          ),
          SizedBox(height: 30),
          TwilioEx()
        ],
      ),
    );





    return Scaffold(
      //appBar: AppBar(title: Text('data'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _callHello,
                child: const Text('Send to Server'),
              ),
              SizedBox(height: 10),
              _ResultDisplay(
                resultMessage: _resultMessage,
                errorMessage: _errorMessage,
              ),
              SizedBox(height: 30),
              //TwilioEx()
            ],
          ),
        ),
      ),
    );
  }
}

// _ResultDisplays shows the result of the call. Either the returned result from
// the `example.hello` endpoint method or an error message.
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
