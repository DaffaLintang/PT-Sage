import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/invoice_controller.dart';
import 'package:pt_sage/controllers/keluahanPelanggan_controller.dart';
import 'package:pt_sage/controllers/payment_controller.dart';
import 'package:pt_sage/page/feedback_page.dart';
import 'package:pt_sage/page/invoice_page.dart';
import 'package:pt_sage/page/payment_page.dart';
import '../models/invoice.dart';
import '../models/keluhanCustomer.dart';
import '../models/payment.dart';
import 'detail_keluhan_page.dart';
import 'home_page.dart';

class ListPaymentPage extends StatefulWidget {
  const ListPaymentPage({Key? key}) : super(key: key);

  @override
  State<ListPaymentPage> createState() => _ListPaymentPageState();
}

class _ListPaymentPageState extends State<ListPaymentPage> {
  List<Payment>? payments;

  @override
  void initState() {
    super.initState();
    fetchPayment();
  }

  void fetchPayment() async {
    List<Payment>? fetchPayment = await PaymentController().getPayment();
    setState(() {
      payments = fetchPayment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "List Payment",
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
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Get.to(() => FeedBackPage());
          //         KeluhanPelangganController.keluhanController.text = '';
          //       },
          //       icon: Icon(
          //         Icons.add,
          //         color: Color(0xffBF1619),
          //       )),
          // ],
        ),
        body: payments == null
            ? Center(child: Text("Tidak ada data"))
            : ListView.builder(
                itemCount: payments!.length,
                itemBuilder: (context, index) {
                  final payment = payments![index];

                  return payment.statusPembayaran == 'belum lunas'
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
                                    image: AssetImage('assets/money.png'))),
                          ),
                          title: Text(payment.kodePengiriman),
                          subtitle: Text(payment.statusPembayaran),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            Get.to(() => PaymentPage(), arguments: payment);
                          },
                        )
                      : SizedBox();
                }));
  }
}
