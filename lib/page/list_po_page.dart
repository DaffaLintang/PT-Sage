import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/purchase_order_controller.dart';
import 'package:pt_sage/models/purchase_order.dart';
import 'package:pt_sage/page/Purchase_page.dart';
import 'package:pt_sage/page/po_detail_page.dart';
import 'home_page.dart';

class listPoPage extends StatefulWidget {
  const listPoPage({Key? key}) : super(key: key);

  @override
  State<listPoPage> createState() => _listPoPageState();
}

class _listPoPageState extends State<listPoPage> {
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
            "List Purchase Order",
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
          backgroundColor: Colors.white,
          elevation: 5,
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAll(() => PurchasePage());
                  PoController.hargaController.text = '0';
                  PoController.jumlahConroller.text = '1';
                },
                icon: Icon(
                  Icons.add,
                  color: Color(0xffBF1619),
                )),
          ],
        ),
        body: orders == null
            ? Center(child: Text("Tidak ada data"))
            : ListView.builder(
                itemCount: orders!.orders.length,
                itemBuilder: (context, index) {
                  final order = orders!.orders[index];
                  return ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.black,
                                BlendMode.srcATop,
                              ),
                              image: AssetImage('assets/Basket_alt_3.png'))),
                    ),
                    title: Text(order.kodePo),
                    subtitle: Text(order.status),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Get.offAll(() => PoDetailPage(), arguments: order);
                    },
                  );
                }));
  }
}
