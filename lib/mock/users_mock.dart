import 'package:proz_project_finance/model/user_credential.dart';

abstract class MockUsers {
  static List<UserCredential> getUsers() {
    return [
      UserCredential(email: "osito@gmail.com", passoword: "123456789"),
      UserCredential(email: "leticia@gmail.com", passoword: "123456789"),
      UserCredential(email: "mariane@gmail.com", passoword: "123456789"),
      UserCredential(email: "usuario@gmail.com", passoword: "123456789"),
    ];
  }
}