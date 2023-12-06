import 'dart:async';

import 'package:calaclator_app/Calculator/Calculator.dart';
import 'package:flutter/material.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: SplashScreen()));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int timerCount = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    // ignore: prefer_const_constructors
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      // ignore: avoid_print

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const CalculatorScreen(),
        ),
      );
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://img.freepik.com/premium-photo/top-view-blue-calculator-notepad-color-background_260672-4055.jpg",
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: const Center(
            child: Text(
              'Calculator',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          )),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
