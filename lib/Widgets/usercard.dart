import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trustique/Screens/chatscreen.dart';
import 'package:trustique/api/api.dart';
import 'package:trustique/helper/date_util.dart';
import 'package:trustique/main.dart';
import 'package:trustique/models/chat_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trustique/models/message.dart';

class Carduser extends StatefulWidget {
  final ChatUser user;
  const Carduser({super.key, required this.user});
  @override
  State<Carduser> createState() => _CarduserState();
}

class _CarduserState extends State<Carduser> {
  Message? _message;
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 10,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(
                          user: widget.user,
                        )));
          },
          child: StreamBuilder(
            stream: APIs.getLastMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) {
                _message = list[0];
              }
              return ListTile(
                shape: StadiumBorder(side: BorderSide(width: 2)),
                leading: InkWell(
                  // onTap: () {
                  //   showDialog(
                  //       context: context,
                  //       builder: (_) => ProfileDialog(user: widget.user));
                  // },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(sz.height * .03),
                    child: CachedNetworkImage(
                      width: sz.height * .055,
                      height: sz.height * .055,
                      imageUrl: widget.user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),
                ),
                // leading: ClipRRect(
                //   borderRadius: BorderRadius.circular(30),
                //   child: CachedNetworkImage(
                //     // width: sz.height * 0.55,
                //     // height: sz.height * 0.55,
                //     imageUrl: widget.user.image,
                //     //placeholder: (context, url) => CircularProgressIndicator(),
                //     errorWidget: (context, url, error) => const CircleAvatar(
                //       child: Icon(CupertinoIcons.person),
                //     ),
                //   ),
                // ),
                title: Text(
                  widget.user.name,
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                subtitle: Text(
                  _message != null
                      ? _message!.type == Type.image
                          ? 'Image📸'
                          : _message!.msg
                      : '',
                  maxLines: 1,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                trailing: _message == null
                    ? null //show nothing when no message is sent
                    : _message!.read.isEmpty &&
                            _message!.fromid != APIs.user.uid
                        ? Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 2, 100, 53),
                                borderRadius: BorderRadius.circular(10)),
                          )
                        :
                        //message sent time
                        Text(
                            Mydateutil.getLastMessageTime(
                                context: context, time: _message!.sent),
                            style: const TextStyle(color: Colors.black54),
                          ),
              );
            },
          ),
        ));
  }
}
