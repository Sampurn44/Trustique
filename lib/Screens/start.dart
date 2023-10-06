import 'dart:convert';
import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trustique/Widgets/usercard.dart';
import 'package:trustique/api/api.dart';
import 'package:trustique/models/chat_user.dart';

class start extends StatefulWidget {
  const start({super.key});

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[800],
          centerTitle: true,
          elevation: 1,
          leading: const Icon(Icons.home_filled),
          title: Text(
            "MY HOMEPAGE",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () async {
                await APIs.auth.signOut();
                await GoogleSignIn().signOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_circle_outline),
          backgroundColor: Colors.brown[800],
        ),
        body: StreamBuilder(
            stream: APIs.firestore.collection('users').snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());

                //if some or all data is loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  list = data!.map((e) => ChatUser.fromJson(e.data())).toList();
                  if (list.isNotEmpty) {
                    return ListView.builder(
                        itemCount: list.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          // return Text('Name:${list[index]}');
                          return Carduser(
                            user: list[index],
                          );
                        });
                  } else {
                    return SizedBox(
                      child: Center(
                        child: TextLiquidFill(
                          text: 'No user added yet',
                          waveDuration: Duration(seconds: 5),
                          waveColor: Colors.blue,
                          boxBackgroundColor: Theme.of(context).primaryColor,
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
            }));
  }
}
