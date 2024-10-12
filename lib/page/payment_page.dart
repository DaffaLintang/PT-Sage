import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pt_sage/controllers/payment_controller.dart';
import 'package:pt_sage/controllers/pengiriman.dart';
import 'package:pt_sage/page/list_payment_page.dart';
import 'package:pt_sage/page/list_penanganan-pelanggan_page.dart';
import 'package:pt_sage/page/list_po_page.dart';

import '../controllers/keluahanPelanggan_controller.dart';
import '../models/keluhanCustomer.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final payment = Get.arguments;
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
  );
  DateTime? pickedDate;
  // final KeluhanPelangganController controller =
  //     Get.put(KeluhanPelangganController());
  DetailKeluhan? detailKeluhan;
  List<String> items = [
    "Biasa",
    "Khusus",
  ];
  String? selectedValue;

  String getRawValue(String formattedValue) {
    String plainValue = formattedValue.replaceAll(RegExp(r'[^\d]'), '');
    if (formattedValue.contains('.')) {
      plainValue = plainValue.split('.')[0];
    }

    return plainValue;
  }

  @override
  void initState() {
    super.initState();
    PaymentController.bayarText.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Detail Pembayaran",
            style: TextStyle(
                color: Color(0xffBF1619),
                fontFamily: GoogleFonts.rubik().fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 22),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAll(() => ListPaymentPage());
              },
              icon: Image.asset('assets/LineRed.png')),
          backgroundColor: Colors.white,
          elevation: 5,
        ),
        body: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   '#${detailKeluhan.}',
                  //   style: TextStyle(
                  //       fontFamily: GoogleFonts.rubik().fontFamily,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.w600),
                  // ),
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
                          "Detail Pembayaran",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Kode Pengiriman",
                          style: TextStyle(
                              color: Color(0xff9E0507),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(payment.kodePengiriman),
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
                        Text(payment
                            .delivery.purchaseOrder.customer.customersName),
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
                        Text(currencyFormatter.format(num.tryParse(
                            payment.delivery.purchaseOrder.totalPrice))),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Kurang Bayar",
                          style: TextStyle(
                              color: Color(0xff9E0507),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(currencyFormatter.format(payment.kurangBayar)),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Jumlah Yang Telah Di Bayar",
                          style: TextStyle(
                              color: Color(0xff9E0507),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            currencyFormatter.format(payment.jumlahBayar ?? 0)),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Status Pembayaran",
                          style: TextStyle(
                              color: Color(0xff9E0507),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(payment.statusPembayaran),
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   itemCount:
                        //       detailKeluhan!.delivery.detailDelivery.length,
                        //   itemBuilder: (context, index) {
                        //     return Text(
                        //         "${index + 1}. ${detailKeluhan!.delivery.detailDelivery[index].productLot.lotNumber}");
                        //   },
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Jatuh Tempo",
                          style: TextStyle(
                              color: Color(0xff9E0507),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(payment.jatuhTempo.toString()),
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   itemCount: detailKeluhan!
                        //       .delivery.purchaseOrder.product.varietas.length,
                        //   itemBuilder: (context, index) {
                        //     return Text(
                        //         "${index + 1}. ${detailKeluhan!.delivery.purchaseOrder.product.varietas[index].varietasName}");
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  payment.statusPembayaran == 'lunas'
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bayar",
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.rubik().fontFamily)),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black.withOpacity(0.05)),
                              child: TextField(
                                inputFormatters: <TextInputFormatter>[
                                  CurrencyTextInputFormatter(
                                    locale: 'id',
                                    decimalDigits: 0,
                                    symbol: 'Rp',
                                  ),
                                ],
                                keyboardType: TextInputType.number,
                                controller: PaymentController.bayarText,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Bayar',
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    child: Text('Bayar'),
                                    onPressed: () {
                                      PaymentController().store(
                                          int.tryParse(getRawValue(
                                              PaymentController
                                                  .bayarText.text)),
                                          payment.kodePengiriman);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      primary: Color(0xff9E0507),
                                    ),
                                  )),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ],
        ));
  }
}
