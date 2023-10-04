import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trustique/Visuals/start.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 238, 131, 9),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const Intro());
}

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trustique',
      theme: theme,
      home: start(),
    );
  }
}
