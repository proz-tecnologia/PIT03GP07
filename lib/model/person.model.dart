class Person {
  String fullName = "";
  String email = "";

  Person({this.fullName = "", this.email = ""});

  String get firstName => fullName.split(" ").first;

  Person.fromFirestore(Map<String, dynamic> map) {
    fullName = map["full_name"] ?? "";
    email = map["email"] ?? "";
  }

  Map<String, dynamic> toMap() {
    return {"full_name": fullName, "email": email};
  }
}
