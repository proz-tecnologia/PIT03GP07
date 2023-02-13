class Wishes {
  String? uid;
  DateTime? dateInitial = DateTime.now();
  DateTime? dateExpectedt = DateTime.now();
  String description = "";
  double value = 0.0;
  bool isConquered = false;
  

  Wishes({this.uid, this.dateInitial,this.dateExpectedt, this.description = "", this.value = 0.0, this.isConquered = false});

  Wishes copyWith(
      {String? newUid,
      DateTime? newDateInitial,
      DateTime? newDateExpected,
      String? newDescription,
      double? newValue,
      String? newTypeTransaction,
      bool? newIsConquered}) {
    return Wishes(
      uid: newUid ?? uid,
      dateInitial: newDateInitial ?? dateInitial,
      dateExpectedt: newDateExpected ?? dateExpectedt,
      description: newDescription ?? description,
      value: newValue ?? value,
      isConquered: newIsConquered ?? isConquered
    );
  }

  Wishes.fromFirestore(Map<String, dynamic> map) {
    dateInitial = map["dateInital"].toDate();
    dateExpectedt = map["dateExpected"].toDate();
    description = map["description"] ?? "";
    value = map["value"] ?? 0.0;
    isConquered = map["isConquered"] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {
      "dateInital": dateInitial,
      "dateExpected": dateExpectedt,
      "description": description,
      "value": value,
      "isConquered": isConquered,
    };
  }
}