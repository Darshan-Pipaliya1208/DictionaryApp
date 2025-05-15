import 'package:dictionary/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return Homepage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 500,
              width: double.infinity,
              child: Lottie.asset("Animation/Dictionary.json"),
            ),
          ),
          Spacer(),
          Text(
            'Please Waiting....',
            style: TextStyle(fontSize: 35, fontFamily: 'SuperShiny'),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
