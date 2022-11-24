import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:proz_project_finance/strings.dart';

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
            label: Strings.HOME_NEWEXPENSES,
            onTap: () {
              Navigator.of(context).pushNamed(Strings.HOME_NEWEXPENSES);
            }),
        SpeedDialChild(
            child: const Icon(Icons.trending_up),
            labelBackgroundColor: Colors.green,
            foregroundColor: Colors.green,
            label: Strings.HOME_NEWINCOME,
            onTap: () {
              Navigator.of(context).pushNamed(Strings.HOME_NEWREVENUES);
            }),
      ],
    );
  }
}
