import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void init()async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: AnimatedCard(
          curve: Curves.bounceInOut,
          direction: AnimatedCardDirection.right,
          duration: const Duration(seconds: 2),
          child: Center(child: Image.asset('../assets/image/logo.png', height: 250, width: 250,))
        ),
      ),
    );
  }
}