import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proz_project_finance/mock/users_mock.dart';
import 'package:proz_project_finance/model/user_credential.dart';
import 'package:proz_project_finance/extension/extension_string.dart';
import 'package:proz_project_finance/ui/pages/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  UserCredential? _userCredential;

  bool _canShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffe8f5ff),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffe8f5ff),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                "REGISTRAR",
                style: TextStyle(
                    color: Colors.grey[700], fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset('assets/image/moneybelth.png'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Bem-Vindo!!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(labelText: "E-mail"),
                  validator: (value) {
                    if (!value!.isValidEmail) {
                      return 'Informe um email válido!';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _email = newValue!,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: !_canShowPassword,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _canShowPassword = !_canShowPassword;
                        });
                      },
                      icon: Icon(_canShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (!value!.isValidPassword) {
                      return "Mín. 6 e máx. 20 caracteres!";
                    }
                    return null;
                  },
                  onSaved: (newValue) => _password = newValue!,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              _userCredential = MockUsers.getUsers().firstWhereOrNull(
                  (element) =>
                      element.email == _email &&
                      element.passoword == _password);

              if (_userCredential != null) {
                navigateToHome();
              } else {
                showLoginFailedDialog();
              }
            }
          },
          child: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }

  void showLoginFailedDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text("Ops! Algo deu errado!"),
              content: const Text("Email/Senha está(ão) inválido(s)!"),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Entendi"))
              ],
            ));
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacementNamed('/');
  }
}
