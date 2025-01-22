import 'dart:async';

import 'package:flearn/f_praticals/dto/albums_dto.dart';
import 'package:flearn/f_praticals/dto/api_response_dto.dart';
import 'package:flearn/f_praticals/repositories/repo_impl.dart';
import 'package:flutter/material.dart';

class ValueListenableBuilderPractical extends StatefulWidget {
  const ValueListenableBuilderPractical({super.key});

  @override
  State<ValueListenableBuilderPractical> createState() => _ValueListenableBuilderPracticalState();
}

class _ValueListenableBuilderPracticalState extends State<ValueListenableBuilderPractical> {
  ValueNotifier<ApiResponseDTO> valueNotifier = ValueNotifier<ApiResponseDTO>(ApiResponseDTO());

  @override
  void initState() {
    RepoImpl.fetchPhotos().then((value) {
      valueNotifier.value = value;
    }).catchError((e) {
      valueNotifier.value = ApiResponseDTO(error: e.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const FittedBox(child: Text("Value Listenable Builder Practical"))),
        body: ValueListenableBuilder<ApiResponseDTO>(
          valueListenable: valueNotifier,
          builder: (BuildContext context, ApiResponseDTO value, Widget? child) {
            if (value.data is List<PhotoDTO> == true) {
              List<PhotoDTO> listData = value.data;

              return ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    PhotoDTO item = listData[index];

                    return InkWell(
                      onTap: () {},
                      hoverColor: Colors.blueGrey,
                      splashColor: Colors.green,
                      highlightColor: Colors.amber,
                      focusColor: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.network(item.thumbnailUrl!, width: 60, height: 60, fit: BoxFit.cover, alignment: Alignment.center, errorBuilder: (context, error, stackTrace) {
                                return const Placeholder(fallbackHeight: 60, fallbackWidth: 60);
                              }),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text("ID/Album ID: ${item.id}/${item.albumId}", style: const TextStyle(fontSize: 20)), Text("${item.title}")],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else if (value.error != null) {
              return Center(child: Text(value.error ?? "No data"));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
