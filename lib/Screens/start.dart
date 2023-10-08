import 'dart:convert';
import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trustique/Screens/auth/auth.dart';
import 'package:trustique/Widgets/usercard.dart';
import 'package:trustique/api/api.dart';
import 'package:trustique/models/chat_user.dart';

class start extends StatefulWidget {
  const start({super.key});

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  List<ChatUser> _list = [];
  final List<ChatUser> _searchlist = [];
  bool _isSearching = false;
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              centerTitle: true,
              elevation: 1,
              leading: const Icon(
                Icons.home_filled,
                color: Colors.white,
              ),
              title: _isSearching
                  ? TextField(
                      decoration:
                          InputDecoration(hintText: "Name , Email , . . . . "),
                      autofocus: true,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (val) {
                        _searchlist.clear();
                        for (var i in _list) {
                          if (i.name.toLowerCase().contains(val) ||
                              i.email.toLowerCase().contains(val)) {
                            _searchlist.add(i);
                          }
                          setState(() {
                            _searchlist;
                          });
                        }
                      },
                    )
                  : Text(
                      "MY HOMEPAGE",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(
                    _isSearching ? Icons.cancel : Icons.search,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await APIs.auth.signOut();
                    await GoogleSignIn().signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => authtr()));
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _addChatUserDialog();
              },
              child: const Icon(Icons.add_circle_outline, color: Colors.white),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            body: StreamBuilder(
                stream: APIs.getMyUsersId(),

                //get id of only known users
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());

                    //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      return StreamBuilder(
                          stream: APIs.getallusers(
                              snapshot.data?.docs.map((e) => e.id).toList() ??
                                  []),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                              case ConnectionState.none:
                                return const Center(
                                    child: CircularProgressIndicator());

                              //if some or all data is loaded then show it
                              case ConnectionState.active:
                              case ConnectionState.done:
                                final data = snapshot.data?.docs;
                                _list = data!
                                    .map((e) => ChatUser.fromJson(e.data()))
                                    .toList();
                                if (_list.isNotEmpty) {
                                  return ListView.builder(
                                      itemCount: _isSearching
                                          ? _searchlist.length
                                          : _list.length,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        // return Text('Name:${list[index]}');
                                        return Carduser(
                                          user: _isSearching
                                              ? _searchlist[index]
                                              : _list[index],
                                        );
                                      });
                                } else {
                                  return SizedBox(
                                    child: Center(
                                      child: TextLiquidFill(
                                        text: 'No user added yet',
                                        waveDuration: Duration(seconds: 5),
                                        waveColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        boxBackgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                        textStyle: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            }
                          });
                  }
                })),
      ),
    );
  }

  void _addChatUserDialog() {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: Row(
                children: const [
                  Icon(
                    Icons.person_add,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text('  Add User')
                ],
              ),

              //content
              content: TextFormField(
                maxLines: null,
                style: TextStyle(color: Colors.white),
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: 'Email Id',
                    prefixIcon: const Icon(Icons.email, color: Colors.blue),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.blue, fontSize: 16))),

                //add button
                MaterialButton(
                    onPressed: () async {
                      //hide alert dialog
                      Navigator.pop(context);
                      if (email.isNotEmpty) {
                        await APIs.addChatUser(email).then((value) {
                          if (!value) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar1);
                          } else {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar2);
                          }
                        });
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ))
              ],
            ));
  }
}

final snackBar1 = SnackBar(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'User not found!',
    message: 'The user does not exist!',

    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
    contentType: ContentType.failure,
  ),
);
final snackBar2 = SnackBar(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    color: Color.fromARGB(255, 47, 0, 255),
    title: 'Congratulations',
    message: 'User added!',

    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
    contentType: ContentType.failure,
  ),
);
