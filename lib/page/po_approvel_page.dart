import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/approved_controller.dart';
import 'package:pt_sage/models/approvelPo.dart';
import 'package:pt_sage/models/purchase_order.dart';
import 'package:pt_sage/page/detail_po_approve_page.dart';
import 'package:pt_sage/page/invoice_page.dart';
import 'package:pt_sage/page/po_detail_page.dart';
import '../controllers/purchase_order_controller.dart';
import 'home_page.dart';

class ListPOApprovel extends StatefulWidget {
  const ListPOApprovel({Key? key}) : super(key: key);

  @override
  State<ListPOApprovel> createState() => _ListPOApprovelState();
}

class _ListPOApprovelState extends State<ListPOApprovel> {
  ApprovelPurchaseOrderList? orders;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    final poController = ApprovedController();
    ApprovelPurchaseOrderList? fetchedOrders =
        await poController.getAprovePoData();
    setState(() {
      orders = fetchedOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Purchase Order Approval",
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
        ),
        body: orders == null
            ? Center(child: Text("Tidak ada data"))
            : ListView.builder(
                itemCount: orders!.orders.length,
                itemBuilder: (context, index) {
                  final order = orders!.orders[index];
                  return order.status == 'pending'
                      ? ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black,
                                      BlendMode.srcATop,
                                    ),
                                    image:
                                        AssetImage('assets/Basket_alt_3.png'))),
                          ),
                          title: Text(order.kodePo),
                          subtitle: Text(order.status),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            Get.to(() => DetailPoApprovalPage(),
                                arguments: order);
                          },
                        )
                      : SizedBox();
                }));
  }
}
