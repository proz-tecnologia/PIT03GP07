import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String?> createUser(
      String fullName, String email, String password) async {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final uid = userCredential.user!.uid;

    await FirebaseFirestore.instance.collection("profiles").doc(uid).set({
      "full_name": fullName,
      "created_at": FieldValue.serverTimestamp(),

    });

    return uid;
  }

  bool checkIfUserLogged() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<User?> doLogin(String email, String password) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user!;
  }

  Future<bool> logout() async {
    await FirebaseAuth.instance.signOut();

    return true;
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
