import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:codestatsapp/widgets/animated_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TypewriterAnimatedTextKit(
              text: ["Code::Stats"],
              totalRepeatCount: 0,
              isRepeatingAnimation: false,
              repeatForever: false,
              speed: Duration(milliseconds: 300),
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "Rubik-Light",
                  fontSize: 30
              ),
            ),
            AnimatedBar(),
          ],
        ),
      ),
    );
  }
}