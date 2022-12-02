import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContainerCard extends StatelessWidget {
  ContainerCard({required this.child,super.key});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(-2, 3),
                  spreadRadius: -10,
                  blurRadius: 12,
                  color: Color.fromRGBO(0, 0, 0, 1),
                )
              ]),
          child: child,
        ),
      ],
    );
  }
}
