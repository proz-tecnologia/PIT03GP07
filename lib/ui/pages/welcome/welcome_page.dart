import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffe8f5ff),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Transforme suas finanças",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Image.asset('assets/image/welcome_image.png'),
                ),
              ),
              Text(
                "O Caminho está a sua frente. Você já deu seu primeiro passo rumo a transformação financeira e nós te guiaremos nessa jornada",
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(Size(300, 35)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  )
                ),
                onPressed: () {}, 
                child: Text('CADASTRAR'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                }, 
                child: Text("JÁ SOU CADASTRADO", style: TextStyle(fontWeight: FontWeight.w500),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
