import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/page/Pengiriman_barang.dart';
import 'package:pt_sage/page/Purchase_page.dart';
import 'package:pt_sage/page/feedback_page.dart';
import 'package:pt_sage/page/invc_approvel_page.dart';
import 'package:pt_sage/page/list_invoice_page.dart';
import 'package:pt_sage/page/po_approvel_page.dart';
import 'package:pt_sage/utils/menu.dart';
import 'package:sp_util/sp_util.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? username;
  int? roles;

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
      roles = SpUtil.getInt('roles');
    });
  }

  @override
  Widget build(BuildContext context) {
    String roleText = roles != null ? getRole(roles!) : "Role not set";
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: -320,
            child: Container(
              width: 1000,
              height: 1000,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/bgDhs.png'),
              )),
            ),
          ),
          ListView(
            children: [
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
                            color: Colors.black,
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
                          color: Color(0xff9E0507),
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
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            height: 110,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Selamat Datang',
                                  style: GoogleFonts.rubik(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '$username',
                                  style: GoogleFonts.rubik(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            width: double.infinity,
                            height: 87,
                            decoration: BoxDecoration(
                              // gradient: LinearGradient(
                              //     colors: [Color(0xFF9E0507), Color(0xFFF29607)],
                              //     begin: Alignment.centerLeft,
                              //     end: Alignment.centerRight),
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Roles: " + roleText,
                                  style: TextStyle(
                                      color: Color(0xff9E0507),
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
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Menu(
                                onTap: () {
                                  Get.offAll(() => ListPOApprovel());
                                },
                                title: 'Purchase Order Approvel',
                                imageAsset: 'assets/Done_ring_round.png'),
                            Menu(
                                onTap: () {
                                  Get.offAll(() => ListInvcApprovePage());
                                },
                                title: 'Invoice Approvel',
                                imageAsset: 'assets/Done_ring_round.png'),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Menu(
                                onTap: () {
                                  Get.offAll(() => PurchasePage());
                                },
                                title: 'Purchase Order',
                                imageAsset: 'assets/Basket_alt_3.png'),
                            Menu(
                                onTap: () {
                                  Get.offAll(() => PengirimanBarangPage());
                                },
                                title: 'Pengiriman Barang',
                                imageAsset: 'assets/package_car.png'),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Menu(
                                onTap: () {
                                  Get.offAll(() => FeedBackPage());
                                },
                                title: 'Feedback',
                                imageAsset: 'assets/Chat_alt_3.png'),
                            Menu(
                                onTap: () {
                                  Get.offAll(() => ListInvoicePage());
                                },
                                title: 'Invoice',
                                imageAsset: 'assets/File_dock.png'),
                          ],
                        )
                      ]),
                    )
                  ],
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}
