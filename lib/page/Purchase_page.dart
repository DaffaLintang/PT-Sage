import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  var _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Purchase Order",
          style: TextStyle(
              color: Color(0xff309E00),
              fontFamily: GoogleFonts.rubik().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
        centerTitle: true,
        leading:
            IconButton(onPressed: () {}, icon: Image.asset('assets/Line.png')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Detail Purchase Order",
                      style: TextStyle(
                          fontFamily: GoogleFonts.rubik().fontFamily,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    )),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kode Customer",
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
                            hintText: 'Kode Customer',
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
                      Text("Kode Purcher Order",
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
                            hintText: 'Kode Purcher Order',
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
                      Text("Tempo",
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
                            hintText: 'Tempo',
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
                      Text("Tanggal",
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
                            hintText: 'Tanggal',
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
                      Text("Diskon (opsional)",
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
                            hintText: 'Diskon',
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
                      Text("Jumlah",
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
                            hintText: 'Jumlah',
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
                      Text("Total Bayar",
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
                            hintText: 'Total Bayar',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              child: Text('Kirim'),
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                primary: Color(0xff309E00),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
