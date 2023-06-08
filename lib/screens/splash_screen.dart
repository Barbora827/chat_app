import 'package:chat_app/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

final _firebase = FirebaseAuth.instance;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double turns = 0.0;

  void _changeRotation() {
    setState(
      () {
        turns += 16.0 / 8.0;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _changeRotation();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffFF6A88),
            Color(0xffFF9A8B),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Center(
            child: AnimatedRotation(
          duration: const Duration(seconds: 10),
          turns: turns,
          child: const Icon(
            Icons.chat_rounded,
            size: 250,
            color: bbWhite,
          ),
        )),
      ),
    );
  }
}
