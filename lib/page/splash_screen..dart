import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stroke_text/stroke_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/Logo(1).png'))),
              ),
              SizedBox(
                height: 20,
              ),
              StrokeText(
                text: "PT. SAGE MASHLAHAT INDONESIA",
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
                strokeColor: Colors.white,
                strokeWidth: 3,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xff9E0507),
    );
  }
}
