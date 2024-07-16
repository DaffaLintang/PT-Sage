import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pt_sage/page/Purchase_page.dart';
import 'package:pt_sage/page/home_page.dart';
import 'package:stroke_text/stroke_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget build(BuildContext context) {
    double getCircleDiameter(BuildContext context) =>
        MediaQuery.of(context).size.width * 8 / 2;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              width: getCircleDiameter(context),
              height: getCircleDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff7CD154)),
            ),
            top: -getCircleDiameter(context) / 1.2,
            left: -getCircleDiameter(context) / 2.7,
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/Logo(1).png'))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // StrokeText(
                          //   text: "PT. SAGE MASHLAHAT INDONESIA",
                          //   textStyle: TextStyle(
                          //     color: Color(0xff7CD154),
                          //     fontWeight: FontWeight.w900,
                          //     fontSize: 18,
                          //   ),
                          //   strokeColor: Colors.white,
                          //   strokeWidth: 3,
                          // )
                          Text(
                            "PT. SAGE MASHLAHAT INDONESIA",
                            style: TextStyle(
                              color: Color(0xff319F01),
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                            // strokeColor: Colors.white,
                            // strokeWidth: 3,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: TextField(
                        // controller: LoginController.phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            border: InputBorder.none,
                            hintText: 'Nomor HP'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        obscureText: _obscureText,
                        // controller: LoginController.passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_open),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            child: Text('Masuk Sekarang'),
                            onPressed: () {
                              Get.offAll(HomePage());
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              primary: Color(0xff7CD154),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
