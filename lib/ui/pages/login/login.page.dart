import '/controllers/login.controller.dart';
import '/navigator_key.dart';
import '/ui/components/custom_alert_dialog.component.dart';
import '/ui/components/progress_dialog.component.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatelessWidget {
  final _controller = GetIt.instance.get<LoginController>();

  LoginPage({super.key});

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset('assets/image/moneybelth.png'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text("Money Belt", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),)
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                onChanged: _controller.changeEmail,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: "Senha"),
                onChanged: _controller.changePassword,
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.maxFinite,
                height: 48,
                child: ElevatedButton(
                  onPressed: _doLogin,
                  child: const Text("Entrar"),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Center(child:Text("Ainda não tem uma conta?")),
              SizedBox(
                width: double.maxFinite,
                height: 48,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/register"),
                  child: const Text("Cadastre-se!"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _doLogin() async {
    _progressDialog.show("Autenticando...");
    final response = await _controller.doLogin();
    if (response.isSuccess) {
      Navigator.pushReplacementNamed(navigatorKey.currentContext!, "/content");
    } else {
      _progressDialog.hide();
      _alertDialog.showInfo(title: "Ops!", message: response.message!);
    }
  }
}
