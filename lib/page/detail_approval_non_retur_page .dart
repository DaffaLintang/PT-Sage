import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pt_sage/controllers/approved_controller.dart';
import 'package:pt_sage/controllers/keluahanPelanggan_controller.dart';
import 'package:pt_sage/page/list_keluhan.dart';
import 'package:pt_sage/page/list_po_page.dart';
import 'package:pt_sage/page/po_approvel_page.dart';

class DetailNonReturApprovalPage extends StatefulWidget {
  const DetailNonReturApprovalPage({Key? key}) : super(key: key);

  @override
  State<DetailNonReturApprovalPage> createState() =>
      _DetailNonReturApprovalPage();
}

class _DetailNonReturApprovalPage extends State<DetailNonReturApprovalPage> {
  DateTime? pickedDate;
  final keluhan = Get.arguments;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = keluhan.createdAt;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Detail Keluhan Pelanggan",
            style: TextStyle(
                color: Color(0xffBF1619),
                fontFamily: GoogleFonts.rubik().fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 22),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAll(() => ListKeluhanPage());
              },
              icon: Image.asset('assets/LineRed.png')),
          backgroundColor: Colors.white,
          elevation: 5,
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${keluhan.kodeInvoice}',
                  style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(18),
                  width: double.infinity,
                  // height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xff9E0507)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Detail Keluhan Pelanggan",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Nama Customer",
                        style: TextStyle(
                            color: Color(0xff9E0507),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(keluhan.customer.customersName),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Keluhan",
                        style: TextStyle(
                            color: Color(0xff9E0507),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(keluhan.complaint),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Tanggal",
                        style: TextStyle(
                            color: Color(0xff9E0507),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(DateFormat('yyyy-MM-dd').format(dateTime)),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: SizedBox(
                          width: 120,
                          height: 50,
                          child: ElevatedButton(
                            child: Text(
                              'Approv',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              KeluhanPelangganController()
                                  .approveNonRetur(keluhan.id);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              primary: Color(0xff008000),
                            ),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: SizedBox(
                          width: 120,
                          height: 50,
                          child: ElevatedButton(
                            child: Text('Reject'),
                            onPressed: () {
                              KeluhanPelangganController().reject(keluhan.id);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              primary: Color(0xffBF1619),
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          )
        ]));
  }
}
