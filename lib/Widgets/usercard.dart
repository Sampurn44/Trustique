import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Carduser extends StatefulWidget {
  const Carduser({super.key});

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
            leading: Icon(
              CupertinoIcons.person,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: Text(
              'User Name',
              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            subtitle: Text(
              'Last send message',
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              maxLines: 1,
            ),
            trailing: Text(
              "Time of last sent message",
              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
              maxLines: 1,
            ),
          ),
        ));
  }
}
