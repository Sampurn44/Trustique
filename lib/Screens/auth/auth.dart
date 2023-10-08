import 'dart:developer';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:trustique/Screens/start.dart';
import 'package:trustique/api/api.dart';
import 'package:trustique/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authtr extends StatefulWidget {
  const authtr({super.key});

  @override
  State<authtr> createState() => _authtrState();
}

class _authtrState extends State<authtr> {
  _handlegooglebtn() {
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        if ((await APIs.userExist())) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const start(),
              ));
        } else {
          await APIs.userCreate().then(
            (value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => start(),
                ),
              );
            },
          );
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e ');
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    sz = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
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
                // backgroundColor: Theme.of(context).colorScheme.primary,
                shape: StadiumBorder(
                    side: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).colorScheme.secondary)),
                // shadowColor: const Color.fromARGB(255, 0, 0, 0),
                // elevation: 15
              ),

              // StadiumBorder(
              //   //<-- 3. SEE HERE
              //   side: BorderSide(
              //     color: Colors.greenAccent,
              //     width: 2.0,
              //   ),
              // ),
              // child: Container(
              //   padding: EdgeInsets.all(16),
              //   child: Text(
              //     'Product Name',
              //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //   ),
              // ),
              onPressed: () {
                _handlegooglebtn();
              },
              icon: Image.asset(
                'images/search.png',
                height: sz.height * 0.45,
              ),
              label: Text(
                "Sign-in using Google",
                style: TextStyle(color: Color.fromARGB(255, 8, 25, 255)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final snackBar = SnackBar(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'On Snap!',
    message:
        'This is an example error message that will be shown in the body of snackbar!',

    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
    contentType: ContentType.failure,
  ),
);

                // ScaffoldMessenger.of(context)
                //   ..hideCurrentSnackBar()
                //   ..showSnackBar(snackBar);