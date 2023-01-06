import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  bool _canShowPassword = false;

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
                validator: (value) {},
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
                validator: (value) {},
                onSaved: (newValue) => _password = newValue!,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}