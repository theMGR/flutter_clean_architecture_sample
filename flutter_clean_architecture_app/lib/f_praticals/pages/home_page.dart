import 'package:flearn/f_praticals/main.dart';
import 'package:flearn/f_praticals/pages/future_builder_practical.dart';
import 'package:flearn/f_praticals/pages/stream_builder_practical.dart';
import 'package:flearn/f_praticals/pages/value_listenable_builder_practical.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(padding: const EdgeInsets.all(10), children: [
      button("Future Builder", const FutureBuilderPractical()),
      button("Stream Builder", const StreamBuilderPractical()),
      button("Value Listenable Builder", const ValueListenableBuilderPractical())
    ]));
  }

  Widget button(String text, Widget page) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            NavigationService.pushPage(page);
          },
          child: Text(text)),
    );
  }
}
