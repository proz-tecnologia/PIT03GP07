import '/controllers/register.controller.dart';
import '/navigator_key.dart';
import '/ui/components/custom_alert_dialog.component.dart';
import '/ui/components/progress_dialog.component.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatelessWidget {
  final _controller = GetIt.instance.get<RegisterController>();

  RegisterPage({super.key});

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Nome"),
              onChanged: _controller.changeName,
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
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: "Repita a senha"),
              onChanged: _controller.changeRepeatPassword,
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.maxFinite,
              height: 48,
              child: ElevatedButton(
                onPressed: _doRegister,
                child: const Text("Registrar"),
              ),
            )
          ],
        ),
      ),
    );
  }

  _doRegister() async {
    _progressDialog.show("Cadastrando...");
    final response = await _controller.doRegister();
    if (response.isSuccess) {
      Navigator.pushReplacementNamed(navigatorKey.currentContext!, "/home");
    } else {
      _progressDialog.hide();
      _alertDialog.showInfo(title: "Ops!", message: response.message!);
    }
  }
}
