import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trustique/Screens/auth/auth.dart';
import 'package:trustique/Screens/start.dart';
import 'package:trustique/main.dart';

//splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.secondary));
      if (FirebaseAuth.instance.currentUser != null) {
        log('\nUser: ${FirebaseAuth.instance.currentUser}');
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const start()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const authtr()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    sz = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      //body
      body: Stack(children: [
        //app logo
        Positioned(
            top: sz.height * .15,
            right: sz.width * .25,
            width: sz.width * .5,
            child: Image.asset('images/trust.png')),

        //google login button
        Positioned(
            bottom: sz.height * .15,
            width: sz.width,
            child: const Text('MADE FOR THE ❤️ OF FLUTTER',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    letterSpacing: .5))),
      ]),
    );
  }
}
