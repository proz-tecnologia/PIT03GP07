import 'package:cloud_firestore/cloud_firestore.dart';
import '/stores/user.store.dart';
import 'package:get_it/get_it.dart';

class CategoryService {

  Future<QuerySnapshot> getAllCatecorys() async {
    final userStore = GetIt.instance.get<UserStore>();

    final db = FirebaseFirestore.instance;


    final querySnapshot = await db
        .collection("profiles")
        .doc(userStore.uid)
        .collection("category")
        .get();

    return querySnapshot;
  }

  Future<DocumentReference> add(Map<String, dynamic> map) async {
    final userStore = GetIt.instance.get<UserStore>();

    final db = FirebaseFirestore.instance;

    final docRef = await db
        .collection("profiles")
        .doc(userStore.uid)
        .collection("category")
        .add(map);

    return docRef;
  }

  Future<bool> update(String uid, Map<String, dynamic> map) async {
    final userStore = GetIt.instance.get<UserStore>();

    final db = FirebaseFirestore.instance;

    await db
        .collection("profiles")
        .doc(userStore.uid)
        .collection("category")
        .doc(uid)
        .update(map);

    return true;
  }

  Future<bool> remove(String uid) async {
    final userStore = GetIt.instance.get<UserStore>();

    final db = FirebaseFirestore.instance;

    await db
        .collection("profiles")
        .doc(userStore.uid)
        .collection("category")
        .doc(uid)
        .delete();

    return true;
  }
}
