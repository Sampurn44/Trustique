import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trustique/main.dart';
import 'package:trustique/models/chat_user.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Carduser extends StatefulWidget {
  final ChatUser user;
  const Carduser({super.key, required this.user});
  @override
  State<Carduser> createState() => _CarduserState();
}

class _CarduserState extends State<Carduser> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 10,
        child: InkWell(
          child: ListTile(
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
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(CupertinoIcons.person)),
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
                widget.user.about,
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                maxLines: 1,
              ),
              trailing: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 2, 100, 53),
                    borderRadius: BorderRadius.circular(10)),
              )),
        ));
  }
}
