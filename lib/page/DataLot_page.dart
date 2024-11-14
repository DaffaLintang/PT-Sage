import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/invoice_controller.dart';
import 'package:pt_sage/controllers/keluahanPelanggan_controller.dart';
import 'package:pt_sage/controllers/payment_controller.dart';
import 'package:pt_sage/page/feedback_page.dart';
import 'package:pt_sage/page/invoice_page.dart';
import 'package:pt_sage/page/payment_page.dart';
import '../controllers/productLot_controller.dart';
import '../models/dataProductLot.dart';
import '../models/invoice.dart';
import '../models/keluhanCustomer.dart';
import '../models/payment.dart';
import 'detail_keluhan_page.dart';
import 'home_page.dart';

class DataGoodTurnOvrSlip extends StatefulWidget {
  const DataGoodTurnOvrSlip({Key? key}) : super(key: key);

  @override
  State<DataGoodTurnOvrSlip> createState() => _DataGoodTurnOvrSlipState();
}

class _DataGoodTurnOvrSlipState extends State<DataGoodTurnOvrSlip> {
  List<InventoryItem>? dataLots;

  @override
  void initState() {
    super.initState();
    fetchDataLot();
  }

  void fetchDataLot() async {
    List<InventoryItem>? fetchDataLot =
        await DataProductLotController().getDataLot();
    setState(() {
      dataLots = fetchDataLot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Data Food Good Turn Over Slip",
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
        body: dataLots == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: dataLots!.length,
                itemBuilder: (context, index) {
                  final dataLot = dataLots![index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xff9E0507),
                      child: Text("${index + 1}"),
                    ),
                    title: Text(dataLot.product.productName),
                    subtitle: Text(dataLot.lotNumber),
                    trailing: Text(dataLot.quantity),
                    // onTap: () {
                    //   Get.to(() => PaymentPage(), arguments: payment);
                    // },
                  );
                }));
  }
}
