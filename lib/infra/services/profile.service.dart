import 'package:cloud_firestore/cloud_firestore.dart';
import '/stores/user.store.dart';
import 'package:get_it/get_it.dart';

class ProfileService {
  Future<DocumentSnapshot> get() async {
    final userStore = GetIt.instance.get<UserStore>();

    final db = FirebaseFirestore.instance;

    final documentSnapshot =
        await db.collection("profiles").doc(userStore.uid).get();

    return documentSnapshot;
  }

  Future<bool> update(Map<String, dynamic> map) async {
    final userStore = GetIt.instance.get<UserStore>();

    final db = FirebaseFirestore.instance;

    await db.collection("profiles").doc(userStore.uid).set(map);

    return true;
  }
}
