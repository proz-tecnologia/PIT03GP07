class Category {
  String? uid;
  String name = "";
  String typeTransaction = "";

   Category({this.uid, this.name = "", this.typeTransaction = ""});

  Category copyWith(
      {String? newUid,
      String? newName,
      String? newTypeTransaction}) {
    return Category(
      uid: newUid ?? uid,
      name: newName ?? name,
      typeTransaction: newTypeTransaction ?? typeTransaction
    );
  }

  Category.fromFirestore(Map<String, dynamic> map) {
    name = map["name"] ?? "";
    typeTransaction = map["typeTransaction"] ?? "";
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "typeTransaction": typeTransaction,
    };
  }

  bool get isValid => name.isNotEmpty;
}