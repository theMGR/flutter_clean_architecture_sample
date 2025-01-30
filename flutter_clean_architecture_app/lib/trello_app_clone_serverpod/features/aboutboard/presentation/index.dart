import 'package:flutter/material.dart';
import 'package:flearn/trello_app_clone_serverpod/utils/constant.dart';

class AboutBoard extends StatefulWidget {
  static const routeName = '/aboutboard';
  const AboutBoard({super.key});

  @override
  State<AboutBoard> createState() => _AboutBoardState();
}

class _AboutBoardState extends State<AboutBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About this board"),
        centerTitle: false,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(children: [
          Text(
            "Made by",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          ListTile(
            leading: CircleAvatar(),
            title: Text("Jane Doe"),
            subtitle: Text("@janedoe"),
          ),
          Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(defaultDescription),
          )
        ]),
      ),
    );
  }
}
