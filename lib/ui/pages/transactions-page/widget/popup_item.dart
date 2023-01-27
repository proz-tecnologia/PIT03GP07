import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemPopup extends StatelessWidget {
  ItemPopup(this.title,this.color,{super.key});

  String title;
  Color color;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.lens, size: 15, color:color),
        const SizedBox(width: 10),
        Text(title),
      ],
    );
  }
}
