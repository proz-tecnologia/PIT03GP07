class Profile {
  String fullName = "";

  Profile({this.fullName = ""});

  String get firstName => fullName.split(' ').first;

  Profile.fromFirestore(Map<String, dynamic> map) {
    fullName = map["full_name"] ?? "";
  }

  Map<String, dynamic> toMap() {
    return {"full_name": fullName};
  }

  bool get isValid => fullName.isNotEmpty;
}
