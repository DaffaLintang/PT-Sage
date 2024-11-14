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

  // String getRawValue(String formattedValue) {
  //   // Menghapus semua karakter non-numerik
  //   String plainValue = formattedValue.replaceAll(RegExp(r'[^\d]'), '');

  //   // Hanya potong dua karakter terakhir jika formattedValue memiliki titik desimal dan ada desimal yang sah
  //   if (formattedValue.contains('.') &&
  //       formattedValue.split('.').last.length == 2) {
  //     plainValue = plainValue.substring(0, plainValue.length - 2);
  //   }

  //   return plainValue;
  // }

  // String getRawValue(String formattedValue) {
  //   // Menghapus semua karakter non-numerik kecuali titik desimal
  //   String plainValue = formattedValue.replaceAll(RegExp(r'[^\d.]'), '');

  //   // Memeriksa apakah ada titik desimal
  //   if (plainValue.contains('.')) {
  //     // Pisahkan nilai sebelum dan sesudah titik desimal
  //     List<String> parts = plainValue.split('.');

  //     // Mengambil bagian sebelum titik desimal dan memastikan bagian desimal ada dan valid
  //     String integerPart = parts[0];
  //     String decimalPart = parts.length > 1 ? parts[1] : '';

  //     // Jika bagian desimal tidak valid (lebih dari dua digit), abaikan bagian desimal
  //     if (decimalPart.length > 2) {
  //       decimalPart = '';
  //     }

  //     // Gabungkan kembali bagian integer dan desimal
  //     plainValue = integerPart + decimalPart;
  //   }

  //   return plainValue;
  // }

  String getRawValue(String formattedValue) {
    // Menghapus semua karakter non-numerik kecuali angka
    String plainValue = formattedValue.replaceAll(RegExp(r'[^\d]'), '');

    // Jika ada titik desimal, abaikan angka desimal dengan mengambil substring dari awal hingga titik desimal
    if (formattedValue.contains('.')) {
      plainValue = plainValue.split('.')[0];
    }

    return plainValue;
  }

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
      body: ListView(
        children: [
          Padding(
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
                        "Nama Petugas",
                        style: TextStyle(
                            color: Color(0xff9E0507),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(order.petugas),
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
                      Text(order.quantity.toString()),
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
                      Text(currencyFormatter.format(order.totalPrice)),
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
                      Text(currencyFormatter.format(order.dpAmount)),
                      SizedBox(
                        height: 15,
                      ),
                      order.diskonType == "nominal"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Diskon",
                                  style: TextStyle(
                                      color: Color(0xff9E0507),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                order.diskon == null
                                    ? Text("-")
                                    : Text(currencyFormatter
                                        .format(order.diskon.toInt())),
                                // Text(currencyFormatter.format(int.parse(
                                //     getRawValue(order.diskon.toString())))),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Diskon",
                                  style: TextStyle(
                                      color: Color(0xff9E0507),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                order.diskon == null
                                    ? Text("-")
                                    : Text(order.diskon.toString()),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                      Text(
                        "Diskon Type",
                        style: TextStyle(
                            color: Color(0xff9E0507),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(order.diskonType),
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
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Status Pengiriman",
                        style: TextStyle(
                            color: Color(0xff9E0507),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(order.statusPengiriman),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Kemasan",
                        style: TextStyle(
                            color: Color(0xff9E0507),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: order.kemasan.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Kemasan : ${order.kemasan[index].berat} Kg'),
                              Text(
                                  'Quantity: ${order.kemasan[index].quantity}'),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Tanggal Pengiriman",
                        style: TextStyle(
                            color: Color(0xff9E0507),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      order.tanggalPengiriman == null
                          ? Text("-")
                          : Text(DateFormat('yyyy-MM-dd')
                              .format(order.tanggalPengiriman))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
