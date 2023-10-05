import 'package:flutter/material.dart';
import 'package:trustique/Widgets/usercard.dart';

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
        body: ListView.builder(
            itemCount: 10,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Carduser();
            }));
  }
}
