import 'dart:convert';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trustique/main.dart';
import 'package:trustique/models/chat_user.dart';
import 'package:trustique/api/api.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appbar(),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: APIs.getallmessages(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                      //return const Center(child: CircularProgressIndicator());

                      //if some or all data is loaded then show it
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        log('Data: ${jsonEncode(data![0].data())}');
                        // _list = data!
                        //     .map((e) => ChatUser.fromJson(e.data()))
                        //     .toList();
                        final _list = [];
                        if (_list.isNotEmpty) {
                          return ListView.builder(
                              itemCount: _list.length,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Text('Message:${_list[index]}');
                              });
                        } else {
                          return SizedBox(
                            child: Center(
                              child: TextLiquidFill(
                                text: 'Say Hiii!!! 👋🏻',
                                waveDuration: Duration(seconds: 5),
                                waveColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                boxBackgroundColor:
                                    Theme.of(context).primaryColor,
                                textStyle: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                          ;
                        }
                    }
                  }),
            ),
            _chatInput()
          ],
        ),
      ),
    );
  }

  Widget _appbar() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(CupertinoIcons.back),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(sz.height * .03),
            child: CachedNetworkImage(
              width: sz.height * .045,
              height: sz.height * .045,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(CupertinoIcons.person)),
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                widget.user.isOnline.toString(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white54,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _chatInput() {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: sz.height * 0.01, horizontal: sz.width * 0.025),
    child: Row(
      children: [
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on,
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.image,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera,
                    )),
              ],
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {},
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
          shape: const CircleBorder(),
          color: Colors.black,
          minWidth: 1,
          child: const Icon(
            CupertinoIcons.paperplane,
            size: 20,
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}
