import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proz_project_finance/strings.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(" Usuário"),
                  ),
                ],
              ),
            ),
            ListTile(
              selected: true,
              leading: const Icon(Icons.dashboard),
              title: const Text(Strings.APP_HOME),
              onTap: () => null,
            ),
            ListTile(
              selected: false,
              leading: const Icon(Icons.account_balance, color: Colors.blue,),
              title: const Text(Strings.APP_ACCOUNT),
              onTap: () => null,
            ),
            ListTile(
              selected: false,
              leading: const Icon(Icons.attach_money, color: Colors.blue,),
              title: const Text(Strings.APP_TRANSACTIONS),
              onTap: () => null,
            ),
          ],
        ),
      ),
    );
  }
}