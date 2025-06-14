import 'package:flutter/material.dart';
import 'package:flearn/trello_app_clone_serverpod/utils/config.dart';
import '../../../main.dart';

class BoardBackground extends StatefulWidget {
  static const routeName = '/boardbackground';
  const BoardBackground({super.key});

  @override
  State<BoardBackground> createState() => _BoardBackgroundState();
}

class _BoardBackgroundState extends State<BoardBackground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Board background"),
        centerTitle: false,
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 3,
              mainAxisSpacing: 20),
          itemCount: backgrounds.length,
          itemBuilder: (BuildContext cxt, index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    trello.setSelectedBg(backgrounds[index]);
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(int.parse(
                                  backgrounds[index].substring(1, 7),
                                  radix: 16) +
                              0xff000000),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    (backgrounds[index] == trello.selectedBackground)
                        ? const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 50,
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ));
          }),
    );
  }
}
