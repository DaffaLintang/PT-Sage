import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pt_sage/page/list_po_page.dart';

class PoDetailPage extends StatefulWidget {
  const PoDetailPage({Key? key}) : super(key: key);

  @override
  State<PoDetailPage> createState() => _PoDetailPageState();
}

class _PoDetailPageState extends State<PoDetailPage> {
  final order = Get.arguments;
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Purchase Order",
          style: TextStyle(
              color: Color(0xffBF1619),
              fontFamily: GoogleFonts.rubik().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => listPoPage());
            },
            icon: Image.asset('assets/LineRed.png')),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#${order.kodePo}',
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
                    "Detail Purchase Order",
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
                  Text(order.customersName),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Nama Produk",
                    style: TextStyle(
                        color: Color(0xff9E0507),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(order.productName),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Quantity",
                    style: TextStyle(
                        color: Color(0xff9E0507),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(order.quantity),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Total Harga",
                    style: TextStyle(
                        color: Color(0xff9E0507),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(currencyFormatter.format(int.parse(order.totalPrice))),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Tempo",
                    style: TextStyle(
                        color: Color(0xff9E0507),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(order.paymentTerm),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "DP",
                    style: TextStyle(
                        color: Color(0xff9E0507),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(order.dp),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Total DP",
                    style: TextStyle(
                        color: Color(0xff9E0507),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(currencyFormatter.format(int.parse(order.dpAmount))),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Status",
                    style: TextStyle(
                        color: Color(0xff9E0507),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(order.status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
