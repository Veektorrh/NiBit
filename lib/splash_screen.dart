import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nibit/pages/navpage.dart';
import 'package:nibit/reusables/stylings.dart';

import 'dart:async';

// import 'package:nibit/utils/reusables/stylings.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Start fade-in after 500ms
    Timer(const Duration(milliseconds: 5), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Navigate after 3 seconds (optional)
    Timer(const Duration(seconds: 7), () {
      Get.offAll(() => NavPage());
      // Navigator.pushReplacement(...);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.jpeg', height: 100),
              const SizedBox(height: 20),
              Text(
                'NIBIT',
                style: TextStyle(
                  color: Stylings.yellow,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







