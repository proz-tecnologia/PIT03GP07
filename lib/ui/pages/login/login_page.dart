import 'dart:async';

import 'package:belt/components/alert_dialog.dart';
import 'package:belt/components/progress_dialog.component.dart';
import 'package:belt/controller/login.controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = LoginController();

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

  StreamSubscription? _streamSubscription;

  bool _canShowPassword = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        await _streamSubscription!.cancel();
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Bem-Vindo!!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: "E-mail"),
              onChanged: _controller.changeEmail,
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
              onChanged: _controller.changePassword,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _doLogin,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  _doLogin() async {
    final response = await _controller.doLogin();
    if (response.isSuccess) {
    } else {
      print("deu erro!!");
    }
  }
}