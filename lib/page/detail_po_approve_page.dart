import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pt_sage/controllers/approved_controller.dart';
import 'package:pt_sage/page/list_po_page.dart';
import 'package:pt_sage/page/po_approvel_page.dart';

class DetailPoApprovalPage extends StatefulWidget {
  const DetailPoApprovalPage({Key? key}) : super(key: key);

  @override
  State<DetailPoApprovalPage> createState() => _DetailPoApprovalPageState();
}

class _DetailPoApprovalPageState extends State<DetailPoApprovalPage> {
  DateTime? pickedDate;
  final order = Get.arguments;
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
  );

  // String getRawValue(String formattedValue) {
  //   String plainValue = formattedValue.replaceAll(RegExp(r'[^\d]'), '');
  //   if (formattedValue.contains('.')) {
  //     plainValue = plainValue.substring(0, plainValue.length - 2);
  //   }

  //   return plainValue;
  // }

  String getRawValue(String formattedValue) {
    // Menghapus semua karakter non-numerik
    String plainValue = formattedValue.replaceAll(RegExp(r'[^\d]'), '');

    // Hanya potong dua karakter terakhir jika formattedValue memiliki titik desimal dan ada desimal yang sah
    if (formattedValue.contains('.') &&
        formattedValue.split('.').last.length == 2) {
      plainValue = plainValue.substring(0, plainValue.length - 2);
    }

    return plainValue;
  }

  Future<void> selectedDate() async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945),
      lastDate: DateTime(2900),
    );

    if (pickedDate != null) {
      setState(() {
        ApprovedController.dateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate!);
      });
    }
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
              Get.offAll(() => ListPOApprovel());
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
                          : Text(order.tanggalPengiriman)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tanggal Pengiriman",
                          style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.05)),
                        child: TextField(
                            controller: ApprovedController.dateController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Tanggal Pengiriman',
                                prefixIcon: Icon(
                                  Icons.date_range,
                                  color: Color(0xffBF1619),
                                )),
                            onTap: () {
                              selectedDate();
                            },
                            showCursor: true,
                            readOnly: true),
                      ),
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
                              'Approved',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              final approvedController =
                                  Get.put(ApprovedController());
                              approvedController.approve(order.kodePo,
                                  ApprovedController.dateController.text);
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
                            child: Text('Rejected'),
                            onPressed: () {
                              final approvedController =
                                  Get.put(ApprovedController());
                              approvedController.rejected(order.kodePo,
                                  ApprovedController.dateController.text);
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
          ),
        ],
      ),
    );
  }
}
