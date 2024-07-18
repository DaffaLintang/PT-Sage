import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/page/Pengiriman_barang.dart';
import 'package:pt_sage/page/Purchase_page.dart';
import 'package:pt_sage/page/feedback_page.dart';
import 'package:pt_sage/page/invoice_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double getCircleDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: -getCircleDiameter(context) / 3,
            top: 230,
            child: Container(
              width: getCircleDiameter(context),
              height: getCircleDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffF29607)),
            ),
          ),
          Positioned(
            left: -70
            // -getCircleDiameter(context) / 2.5
            ,
            top: 500
            // -getCircleDiameter(context) / -0.58
            ,
            child: Container(
              width: getCircleDiameter(context),
              height: getCircleDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffE86016)),
            ),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/Logo(1).png'))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "PT. SAGE MASHLAHAT INDONESIA",
                      style: TextStyle(
                        color: Color(0xffBF1619),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  width: 327,
                  height: 197,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 252, 252, 252),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(4, 5),
                        )
                      ]),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        height: 110,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Selamat Datang',
                              style: GoogleFonts.rubik(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Daffa Lintang',
                              style: GoogleFonts.rubik(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        width: double.infinity,
                        height: 87,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF9E0507), Color(0xFFF29607)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Roles: " + "Martketing",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Fitur Tersedia",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offAll(PengirimanBarangPage());
                          },
                          child: Container(
                            height: 127,
                            width: 150,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(4, 5),
                                  )
                                ],
                                color: Color(0xffF29607),
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/package_car.png'))),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Pengiriman Barang",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAll(PurchasePage());
                          },
                          child: Container(
                            height: 127,
                            width: 150,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(4, 5),
                                  )
                                ],
                                color: Color(0xffE86016),
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/Basket_alt_3.png'))),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Purchase Order ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (() {
                            Get.offAll(FeedBackPage());
                          }),
                          child: Container(
                            height: 127,
                            width: 150,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(4, 5),
                                  )
                                ],
                                color: Color(0xffE86016),
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/Chat_alt_3.png'))),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Feedback",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Get.offAll(InvoicePage());
                          }),
                          child: Container(
                            height: 127,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color(0xffF29607),
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/File_dock.png'))),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Invoice",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
