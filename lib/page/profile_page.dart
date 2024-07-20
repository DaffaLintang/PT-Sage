import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/page/login_page.dart';

import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
              color: Color(0xff9E0507),
              fontFamily: GoogleFonts.rubik().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Group 942.png"))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "PT. SAGE MASHLAHAT INDONESIA",
                  //   style: TextStyle(
                  //     color: Color(0xff9E0507),
                  //     fontWeight: FontWeight.w900,
                  //     fontSize: 18,
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Username",
                            style: TextStyle(
                                fontFamily: GoogleFonts.rubik().fontFamily)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black.withOpacity(0.05)),
                          child: TextField(
                            // controller: RegisterController.emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Daffa Lintang',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email",
                            style: TextStyle(
                                fontFamily: GoogleFonts.rubik().fontFamily)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black.withOpacity(0.05)),
                          child: TextField(
                            // controller: RegisterController.emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Daffalintang@gmail.com',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Role",
                            style: TextStyle(
                                fontFamily: GoogleFonts.rubik().fontFamily)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black.withOpacity(0.05)),
                          child: TextField(
                            // controller: RegisterController.emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Marketting',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: SizedBox(
                              width: 200,
                              height: 50,
                              child: ElevatedButton(
                                child: Text('Keluar'),
                                onPressed: () {
                                  Get.offAll(() => LoginPage());
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  primary: Color(0xffF51E1E),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
