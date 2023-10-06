import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trustique/models/chat_user.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<bool> userExist() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Future<void> userCreate() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatuser = ChatUser(
        name: auth.currentUser!.displayName.toString(),
        id: auth.currentUser!.uid,
        about: "Hey I'm using trustique",
        email: auth.currentUser!.email.toString(),
        createdAt: time,
        image: auth.currentUser!.photoURL.toString(),
        isOnline: false,
        lastActive: time,
        pushToken: '');
    return await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(chatuser.toJson());
  }
//const Themeof =
//Theme.of(context).colorScheme.secondary;
}
