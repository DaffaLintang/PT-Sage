import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/page/home_page.dart';

import 'dashboard_page.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  var _bottomNavIndex = 0;

  final List<String> items = [
    'Daffa',
    'Lintang',
    'Firzo',
    'Firdaus',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Purchase Order",
          style: TextStyle(
              color: Color(0xffBF1619),
              fontFamily: GoogleFonts.rubik().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => HomePage());
            },
            icon: Image.asset('assets/LineRed.png')),
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
                      Text("Nama Customer",
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Pilih Customer',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: items
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                // Container(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text("Kode Purcher Order",
                //           style: TextStyle(
                //               fontFamily: GoogleFonts.rubik().fontFamily)),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Container(
                //         padding:
                //             EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(12),
                //             color: Colors.black.withOpacity(0.05)),
                //         child: TextField(
                //           // controller: RegisterController.emailController,
                //           decoration: InputDecoration(
                //             border: InputBorder.none,
                //             hintText: 'Kode Purcher Order',
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 20,
                //       ),
                //     ],
                //   ),
                // ),
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
                                primary: Color(0xffBF1619),
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
