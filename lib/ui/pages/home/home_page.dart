import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proz_project_finance/ui/components/body_home.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/drawer_menu.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xff1E90FF),
        elevation: 0,
        centerTitle: true,
        title: const Text("Mês"),
      ),
      drawer: const DrawerMenu(),
      body: const BodyHome(),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 20,
        ),
      ),
    ));
  }
}
