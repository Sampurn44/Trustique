import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trustique/models/chat_user.dart';

class APIs {
  // for authentication
  static late ChatUser me;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<bool> userExist() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Future<void> getSelfInfo() async {
    return (await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((user) {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
      } else {
        userCreate().then((value) => getSelfInfo());
      }
    }));
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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getallusers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: auth.currentUser!.uid)
        .snapshots();
  }
//const Themeof =
//Theme.of(context).colorScheme.secondary;
}
