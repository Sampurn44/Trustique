import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trustique/Widgets/usercard.dart';
import 'package:trustique/api/api.dart';

class start extends StatefulWidget {
  const start({super.key});

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
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
              onPressed: () {},
              icon: const Icon(
                Icons.list,
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
              final list = [];
              if (snapshot.hasData) {
                final data = snapshot.data?.docs;
                for (var i in data!) {
                  log('Data that exist ${jsonEncode(i.data())}');
                  list.add(i.data()['name']);
                }
              }
              return ListView.builder(
                  itemCount: list.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Text('Name:${list[index]}');
                    //return Carduser();
                  });
            }));
  }
}
