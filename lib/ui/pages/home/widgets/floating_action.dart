import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingButtonAnimate extends StatefulWidget {
  const FloatingButtonAnimate({super.key});

  @override
  State<FloatingButtonAnimate> createState() => _FloatingButtonAnimateState();
}

class _FloatingButtonAnimateState extends State<FloatingButtonAnimate> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      curve: Curves.fastLinearToSlowEaseIn,
      icon: Icons.add,
      activeIcon: Icons.close,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.trending_down),
            labelBackgroundColor: Colors.red,
            foregroundColor: Colors.red,
            label: "Nova Despesa",
            onTap: () {
              Navigator.of(context).pushNamed('/new-expense');
            }),
        SpeedDialChild(
            child: const Icon(Icons.trending_up),
            labelBackgroundColor: Colors.green,
            foregroundColor: Colors.green,
            label: "Nova Receita",
            onTap: () {
              Navigator.of(context).pushNamed('/new-income');
            }),
      ],
    );
  }
}
