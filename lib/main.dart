import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trustique/Screens/auth/auth.dart';
import 'package:trustique/Screens/splash_screen.dart';
import 'package:trustique/Screens/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 238, 131, 9),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
late Size sz;
void main() {
  _initalizeFirebase();
  runApp(const Intro());
}

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trustique',
      theme: theme,
      home: authtr(),
    );
  }
}

_initalizeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
