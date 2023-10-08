import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trustique/Screens/auth/auth.dart';
import 'package:trustique/Screens/splash_screen.dart';
import 'package:trustique/Screens/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trustique/firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Color.fromARGB(255, 34, 119, 255),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
late Size sz;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
      home: SplashScreen(),
    );
  }
}

_initalizeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
