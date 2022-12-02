import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContainerWidget extends StatelessWidget {
  ContainerWidget(this.widget,{super.key});

  Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 218, 218, 218), width: 1))),
      child: widget,
    );
  }
}