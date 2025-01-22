import 'dart:async';

import 'package:flearn/f_praticals/dto/albums_dto.dart';
import 'package:flearn/f_praticals/dto/api_response_dto.dart';
import 'package:flearn/f_praticals/repositories/repo_impl.dart';
import 'package:flutter/material.dart';

class StreamBuilderPractical extends StatefulWidget {
  const StreamBuilderPractical({super.key});

  @override
  State<StreamBuilderPractical> createState() => _StreamBuilderPracticalState();
}

class _StreamBuilderPracticalState extends State<StreamBuilderPractical> {
  StreamController<ApiResponseDTO> streamController = StreamController<ApiResponseDTO>();

  @override
  void initState() {
    RepoImpl.fetchPhotos().then((value) {
      streamController.add(value);
    }).catchError((e) {
      streamController.addError(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Stream Builder Practical")),
        body: StreamBuilder<ApiResponseDTO>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data?.data is List<PhotoDTO> == true) {
              List<PhotoDTO> listData = snapshot.data?.data;
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
                                return const Placeholder();
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
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
