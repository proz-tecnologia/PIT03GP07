import 'dart:async';

import 'package:animated_card/animated_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  Future init()async {
    await Future.delayed(const Duration(seconds: 3));
    _streamSubscription = FirebaseAuth.instance.authStateChanges().listen((user) { 
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
    Navigator.of(context).pushReplacementNamed('/home');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             AnimatedCard(
              curve: Curves.elasticInOut,
              direction: AnimatedCardDirection.left,
              duration: const Duration(seconds: 2),
              child: const Center(child: Text("MoneyBelt",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
            ),
            AnimatedCard(
              curve: Curves.elasticInOut,
              direction: AnimatedCardDirection.right,
              duration: const Duration(seconds: 2),
              child: Center(child: Image.asset('assets/image/moneybelth.png', height: 250, width: 250,))
            ),
          ],
        ),
      ),
    );
  }
}