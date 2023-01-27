import 'package:animated_card/animated_card.dart';
import '/controllers/splash.controller.dart';
import '/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _controller = GetIt.instance.get<SplashController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    await Future.delayed(const Duration(seconds: 3));
    if (_controller.checkIfUserLogged()) {
      final response = await _controller.login();
      if (response.isSuccess) {
        if (response.data!) {
          Navigator.pushReplacementNamed(navigatorKey.currentContext!, "/content");
        } else {
          Navigator.pushReplacementNamed(
              navigatorKey.currentContext!, "/login");
        }
      } else {
        Navigator.pushReplacementNamed(navigatorKey.currentContext!, "/login");
      }
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
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
