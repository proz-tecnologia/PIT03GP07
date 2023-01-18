import '/models/category.model.dart';

class Transaction {
  String? uid;
  DateTime? date = DateTime.now();
  String description = "";
  double value = 0.0;
  Category? category;
  String? typeTransaction;

  Transaction({this.uid, this.date, this.description = "", this.value = 0.0, this.category, this.typeTransaction});

  Transaction copyWith(
      {String? newUid,
      DateTime? newDate,
      String? newDescription,
      double? newValue,
      Category? newCategorty,
      String? newTypeTransaction}) {
    return Transaction(
      uid: newUid ?? uid,
      date: newDate ?? date,
      description: newDescription ?? description,
      value: newValue ?? value,
      category: newCategorty ?? category,
      typeTransaction: newTypeTransaction ?? typeTransaction
    );
  }

  Transaction.fromFirestore(Map<String, dynamic> map) {
    date = map["date"].toDate();
    description = map["description"] ?? "";
    value = map["value"] ?? 0.0;
    category = Category.fromFirestore(map["category"] ?? " ");
    typeTransaction = map["typeTransaction"] ?? "";
  }

  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "description": description,
      "value": value,
      "category": category!.toMap(),
      "typeTransaction": typeTransaction
    };
  }

  bool get isValid => date != null && description.isNotEmpty;
}

