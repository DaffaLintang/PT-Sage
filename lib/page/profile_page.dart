import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pt_sage/page/login_page.dart';
import 'package:sp_util/sp_util.dart';
import 'dart:io' as io;

import '../apiVar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;
  String? email;
  int? roles;
  String? avatar;

  String getRole(int i) {
    switch (i) {
      case 1:
        return "Super Admin";
        break;
      case 2:
        return "Admin";
        break;
      case 3:
        return "Direktur";
        break;
      case 4:
        return "manajer";
        break;
      case 5:
        return "Marketing";
        break;
      default:
        return "Unknown role";
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      username = SpUtil.getString('username') ?? "Username";
      email = SpUtil.getString('email') ?? "email";
      roles = SpUtil.getInt('roles');
      avatar = SpUtil.getString('avatar');
    });
  }

  io.File? _image;

  // Future<void> _pickImage(ImageSource source) async {
  //   final XFile? pickedFile = await _picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = io.File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    String roleText = roles != null ? getRole(roles!) : "Role not set";
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
          GestureDetector(
            child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                    child: avatar!.isNotEmpty
                        ? Image.network(
                            Uri.encodeFull('${MainUrl}/${avatar}'),
                            width: 70,
                            height: 70,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Text('Gagal memuat gambar');
                            },
                          )
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Color(0xff9E0507))),
                            padding: EdgeInsets.all(8),
                            width: 70,
                            height: 70,
                            child: Center(
                                child: Text(
                              "No Image",
                              textAlign: TextAlign.center,
                            )),
                          ))),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  // Container(
                  //   width: 70,
                  //   height: 70,
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //           image: AssetImage("assets/Group 942.png"))),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
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
                            enabled: false,
                            // controller: RegisterController.emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: username,
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
                            enabled: false,
                            // controller: RegisterController.emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: email,
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
                            enabled: false,
                            // controller: RegisterController.emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: roleText,
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
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                      child: Text(
                    "© 2024 PT. SAGE Mashlahat Indonesia \nDesign & Develop by LAB KSI Politeknik Negeri Jember",
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
