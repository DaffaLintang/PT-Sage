import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/models/purchase_order.dart';
import 'package:pt_sage/page/list_po_page.dart';

import '../controllers/purchase_order_controller.dart';
import 'home_page.dart';

class PoDetailPage extends StatefulWidget {
  const PoDetailPage({Key? key}) : super(key: key);

  @override
  State<PoDetailPage> createState() => _PoDetailPageState();
}

class _PoDetailPageState extends State<PoDetailPage> {
  Orders? orders;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    final poController = PoController();
    Orders? fetchedOrders = await poController.getPoData();
    setState(() {
      orders = fetchedOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feedback",
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
    );
  }
}
