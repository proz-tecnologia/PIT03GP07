import 'package:flutter/cupertino.dart';

class TitleBody extends StatelessWidget {
  TitleBody({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style:const TextStyle(
              color: Color(0xff5f95e7),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        );
  }
}