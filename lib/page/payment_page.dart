import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/controllers/payment_controller.dart';
import 'package:pt_sage/controllers/pengiriman.dart';
import 'package:pt_sage/page/list_payment_page.dart';
import 'package:pt_sage/page/list_penanganan-pelanggan_page.dart';
import 'package:pt_sage/page/list_po_page.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;

import '../controllers/keluahanPelanggan_controller.dart';
import '../models/detailPayment.dart';
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
  io.File? _image1;

  late List<DetailPayment> detailPayments;
  @override
  void initState() {
    super.initState();
    PaymentController.bayarText.text = '';
    fetchPayment();
  }

  final ImagePicker _picker1 = ImagePicker();

  Future<void> _pickImage1(ImageSource source) async {
    final XFile? pickedFile = await _picker1.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image1 = io.File(pickedFile.path);
      });
    }
  }

  Future<bool> checkImageExists(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response.statusCode == 200; // URL valid jika status kode 200
    } catch (e) {
      return false; // Kesalahan jaringan atau lainnya
    }
  }

  String getRawValue(String formattedValue) {
    String plainValue = formattedValue.replaceAll(RegExp(r'[^\d]'), '');
    if (formattedValue.contains('.')) {
      plainValue = plainValue.split('.')[0];
    }

    return plainValue;
  }

  void fetchPayment() async {
    List<DetailPayment>? fetchPayment =
        await PaymentController().getDetailPayment(payment.id);
    setState(() {
      detailPayments = fetchPayment ?? [];
    });
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
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Color(0xff9E0507)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bukti Pembayaran",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _image1 == null
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color:
                                                          Color(0xff9E0507))),
                                              padding: EdgeInsets.all(8),
                                              width: 70,
                                              height: 70,
                                              child: Center(
                                                  child: Text(
                                                "No Image",
                                                textAlign: TextAlign.center,
                                              )),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color:
                                                          Color(0xff6B8A7A))),
                                              padding: EdgeInsets.all(8),
                                              width: 70,
                                              height: 70,
                                              child: Image.file(_image1!),
                                            ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                primary: Color(0xff9E0507),
                                              ),
                                              onPressed: () => _pickImage1(
                                                  ImageSource.gallery),
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 1),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Choose",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            "Photo",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      )))),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                primary: Color(0xff9E0507),
                                              ),
                                              onPressed: () => _pickImage1(
                                                  ImageSource.camera),
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Take",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "Photo",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
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
                                      if (_image1 == null) {
                                        Get.snackbar(
                                            'Error', 'Bukti Belum Di Upload',
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      } else {
                                        // If images are present, submit the form and generate the PDF
                                        PaymentController().store(
                                            int.tryParse(getRawValue(
                                                PaymentController
                                                    .bayarText.text)),
                                            payment.kodePengiriman,
                                            _image1);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      primary: Color(0xff9E0507),
                                    ),
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    child: Text('Lihat Riwayat Pembayaran'),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Riwayat Pembayaran"),
                                            content: Container(
                                              width: double
                                                  .infinity, // Make sure content takes full width
                                              constraints: BoxConstraints(
                                                maxHeight:
                                                    300, // Limit max height
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize
                                                      .min, // Ensure the column only takes necessary space
                                                  children: List.generate(
                                                      detailPayments.length,
                                                      (index) {
                                                    final detailPayment =
                                                        detailPayments[index];
                                                    final imageUrl =
                                                        '${MainUrl}/${detailPayment.buktiBayar}';
                                                    // print(detailPayment
                                                    //             .buktiBayar !=
                                                    //         null &&
                                                    //     detailPayment.buktiBayar
                                                    //         .isNotEmpty);
                                                    // print(
                                                    //     '${MainUrl}/${detailPayment.buktiBayar}');
                                                    return ListTile(
                                                      trailing: (detailPayment
                                                                      .buktiBayar !=
                                                                  null &&
                                                              detailPayment
                                                                  .buktiBayar
                                                                  .isNotEmpty)
                                                          ? FutureBuilder<bool>(
                                                              future:
                                                                  checkImageExists(
                                                                      imageUrl),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  // Indikator pemuatan saat memeriksa URL
                                                                  return Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  );
                                                                } else if (snapshot
                                                                        .hasError ||
                                                                    snapshot.data ==
                                                                        false) {
                                                                  // Ikon fallback jika URL tidak valid atau kesalahan
                                                                  return Icon(
                                                                    Icons
                                                                        .broken_image,
                                                                    size: 50,
                                                                    color: Colors
                                                                        .grey,
                                                                  );
                                                                } else {
                                                                  // Gambar jika URL valid
                                                                  return Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    child: Image
                                                                        .network(
                                                                      Uri.encodeFull(
                                                                          imageUrl),
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      loadingBuilder: (BuildContext context,
                                                                          Widget
                                                                              child,
                                                                          ImageChunkEvent?
                                                                              loadingProgress) {
                                                                        if (loadingProgress ==
                                                                            null) {
                                                                          return child;
                                                                        } else {
                                                                          return Center(
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes!) : null,
                                                                            ),
                                                                          );
                                                                        }
                                                                      },
                                                                      errorBuilder: (BuildContext context,
                                                                          Object
                                                                              exception,
                                                                          StackTrace?
                                                                              stackTrace) {
                                                                        return Icon(
                                                                          Icons
                                                                              .broken_image,
                                                                          size:
                                                                              50,
                                                                          color:
                                                                              Colors.grey,
                                                                        );
                                                                      },
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .image_not_supported,
                                                              size: 50,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                      title: Text(
                                                        currencyFormatter.format(
                                                            detailPayment
                                                                .jumlahBayar),
                                                      ),
                                                      subtitle: Text(
                                                          detailPayment
                                                              .tanggalBayar),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: Text('Tutup'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      primary:
                                          Color.fromARGB(255, 47, 133, 225),
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
