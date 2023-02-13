import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../stores/user.store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _userStore = GetIt.instance.get<UserStore>();

    return Scaffold(
        appBar: AppBar(title: const Text("Meu perfil")),
        body: Observer(
          builder: (context) => SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue,
                    child: Image.asset("assets/image/moneybelth.png"),
                  ),
                ),
                const SizedBox(height: 30),
              Text(_userStore.profile!.fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
              const SizedBox(height: 10),
              TextButton(onPressed: _logout, child: const Text("Sair", style: TextStyle(color: Colors.red),))
              ],
            ),
          ),
        ));
  }

  _logout() async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, "/login");
  }
}
