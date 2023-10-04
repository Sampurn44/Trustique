import 'package:flutter/material.dart';
import 'package:trustique/main.dart';

class authtr extends StatefulWidget {
  const authtr({super.key});

  @override
  State<authtr> createState() => _authtrState();
}

class _authtrState extends State<authtr> {
  @override
  Widget build(BuildContext context) {
    sz = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        elevation: 1,
        title: Text(
          "Welome to Trustique ",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            height: sz.height * 0.45,
            top: sz.height * 0.05,
            right: 0.5,
            left: 2,
            child: Image.asset('images/trust.png'),
          ),
          Positioned(
            height: sz.height * 0.045,
            bottom: sz.height * 0.20,
            right: 0.5,
            left: 2,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: OvalBorder(eccentricity: 0.55)),
              onPressed: () {},
              icon: Image.asset(
                'images/search.png',
                height: sz.height * 0.45,
              ),
              label: Text("Sign-in using Google"),
            ),
          ),
        ],
      ),
    );
  }
}
