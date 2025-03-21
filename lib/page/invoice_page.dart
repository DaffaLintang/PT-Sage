import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/controllers/invoice_controller.dart';
import 'package:pt_sage/models/customer.dart';
import 'package:pt_sage/models/invoice.dart';
import 'package:pt_sage/models/supplier.dart';
import 'package:pt_sage/page/home_page.dart';
import 'package:pt_sage/page/list_invoice_page.dart';
import 'dart:io' as io;

import 'package:pt_sage/providers/pdf_invoice_api.dart';

import '../controllers/menu_controller.dart';
import '../providers/pdf_api.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  io.File? _image;
  final ImagePicker _picker = ImagePicker();
  final invoice = Get.arguments;
  late final menus;
  List<int> actionId = [];

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
  );

  void checkIfIdExists() async {
    menus = await MenuController().getMenu();
    setState(() {});
    for (var menu in menus) {
      for (var action in menu.actions) {
        if (action.actionId == 39) {
          actionId.add(action.actionId);
        }
      }
    }
    // SpUtil.putStringList('menus', menuIds!.map((id) => id.toString()).toList());
  }

  @override
  void initState() {
    super.initState();
    checkIfIdExists();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = io.File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageCamera(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = io.File(pickedFile.path);
      });
    }
  }

  io.File? _image1;
  final ImagePicker _picker1 = ImagePicker();

  Future<void> _pickImage1(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image1 = io.File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Invoice",
          style: TextStyle(
              color: Color(0xffBF1619),
              fontFamily: GoogleFonts.rubik().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => ListInvoicePage());
            },
            icon: Image.asset('assets/LineRed.png')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              invoice.kodeInvoice,
                              style: TextStyle(
                                  fontFamily: GoogleFonts.rubik().fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Tanggal : ${DateFormat('yyyy-MM-dd').format(invoice.delivery.tanggalPengiriman)}',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.rubik().fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Text(
                          invoice.kodePengiriman,
                          style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          invoice.delivery.kodePo,
                          style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(18),
                  width: double.infinity,
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
                        "Detail Customer",
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
                      Text(invoice.delivery.purchaseOrder.customersName),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Alamat",
                        style: TextStyle(
                            color: Color(0xff9E0507),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(invoice.delivery.purchaseOrder.address),
                      SizedBox(
                        height: 15,
                      ),
                      // Text(
                      //   "Jenis Customer",
                      //   style: TextStyle(
                      //       color: Color(0xff9E0507),
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w700),
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Text("Petani"),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      Text(
                        "No Hp/WA",
                        style: TextStyle(
                            color: Color(0xff9E0507),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(invoice.delivery.purchaseOrder.phone),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  // padding: EdgeInsets.all(18),
                  width: double.infinity,
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 20),
                        child: Text(
                          "Detail Pesanan",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000)),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 8.0,
                          columns: [
                            DataColumn(
                              label: Text(
                                "No",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Produk",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Unit",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Qty(Sack)",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Tonase(kg)",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Harga/kg",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Diskon",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Jumlah",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(Text("1")),
                                DataCell(
                                  Container(
                                    width: 80, // Set a specific width if needed
                                    child: Text(
                                      invoice
                                          .delivery.purchaseOrder.productName,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  invoice.delivery.kemasan.isNotEmpty
                                      ? SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: invoice.delivery.kemasan
                                                .map<Widget>((kemasan) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Berat Kemasan: ${kemasan.kemasanWeight} kg"),
                                                  SizedBox(height: 8),
                                                  Text(
                                                      'Pcs: ${kemasan.pcs} pcs'),
                                                  SizedBox(height: 8),
                                                ],
                                              );
                                            }).toList(), // Make sure to use .toList() here
                                          ),
                                        )
                                      : Text("No kemasan data available"),
                                ),
                                DataCell(Text(
                                  "${invoice.delivery.detailDelivery.fold<int>(0, (int sum, DetailDelivery item) => sum + item.totalPcs).toString()} Sack",
                                )),
                                DataCell(Text(
                                    "${invoice.delivery.purchaseOrder.quantity} Kg")),
                                DataCell(Text(currencyFormatter.format(
                                    double.parse(invoice
                                        .delivery.purchaseOrder.price)))),
                                invoice.delivery.purchaseOrder.discountType ==
                                        "nominal"
                                    ? DataCell(Text(currencyFormatter.format(
                                        double.tryParse(invoice.delivery
                                                .purchaseOrder.discount)
                                            ?.toInt())))
                                    : DataCell(Text(invoice
                                        .delivery.purchaseOrder.discount
                                        .toString())),
                                DataCell(Text(currencyFormatter.format(
                                    double.parse(invoice
                                        .delivery.purchaseOrder.totalPrice)))),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Color.fromARGB(255, 202, 202, 202),
                      ),
                      Container(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tempo",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  invoice.delivery.purchaseOrder.paymentTerm,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text(
                                    currencyFormatter.format(int.parse(invoice
                                        .delivery.purchaseOrder.totalPrice)),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text("Bayar",
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w800)),
                            //     Text("Rp.100.000",
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w800)),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text("Sisa Bayar",
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w800)),
                            //     Text("Rp.10.100.000",
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w800)),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Dp",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text(invoice.delivery.purchaseOrder.dp,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Dp",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text(
                                    currencyFormatter.format(int.parse(invoice
                                        .delivery.purchaseOrder.dpAmount)),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Status",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text(invoice.delivery.purchaseOrder.status,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Pengiriman Status",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text(
                                    invoice
                                        .delivery.purchaseOrder.deliveryStatus,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tipe Diskon",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text(
                                    invoice.delivery.purchaseOrder.discountType,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Hutang",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text(currencyFormatter.format(invoice.hutang),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Jenis Kendaraan",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text(invoice.delivery.kendaraan.jenisKendaraan,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("No Polisi",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text(invoice.delivery.noPolisi.NoPolisi,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text("Nomor Polisi",
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w800)),
                            //     Text(invoice.delivery.kendaraan.NoPolisi,
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w800)),
                            //   ],
                            // ),
                            SizedBox(
                              height: 8,
                            ),
                            // invoice.delivery.purchaseOrder.discountType ==
                            //         "nominal"
                            //     ? Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Text("Diskon Total",
                            //               style: TextStyle(
                            //                   fontSize: 12,
                            //                   fontWeight: FontWeight.w800)),
                            //           invoice.delivery.purchaseOrder.discount ==
                            //                   null
                            //               ? Text("-")
                            //               : Text(
                            //                   currencyFormatter.format(
                            //                       double.tryParse(invoice
                            //                               .delivery
                            //                               .purchaseOrder
                            //                               .discount)
                            //                           ?.toInt()),
                            //                   style: TextStyle(
                            //                       fontSize: 12,
                            //                       fontWeight: FontWeight.w800)),
                            //         ],
                            //       )
                            //     : Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Text(
                            //             "Diskon Total",
                            //             style: TextStyle(
                            //                 fontSize: 12,
                            //                 fontWeight: FontWeight.w800),
                            //           ),
                            //           invoice.delivery.purchaseOrder.discount ==
                            //                   null
                            //               ? Text("-")
                            //               : Text(
                            //                   invoice.delivery.purchaseOrder
                            //                       .discount
                            //                       .toString(),
                            //                   style: TextStyle(
                            //                       fontSize: 12,
                            //                       fontWeight: FontWeight.w800)),
                            //         ],
                            //       ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // children: [
                            // Text("Diskon Total",
                            //     style: TextStyle(
                            //         fontSize: 12,
                            //         fontWeight: FontWeight.w800)),
                            //     Text(invoice.delivery.purchaseOrder.discount,
                            // style: TextStyle(
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w800)),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   padding: EdgeInsets.all(8),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(16),
                //     border: Border.all(color: Color(0xff9E0507)),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.5),
                //         spreadRadius: 2,
                //         blurRadius: 7,
                //         offset: Offset(0, 5), // changes position of shadow
                //       ),
                //     ],
                //   ),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       "Bukti Pengiriman",
                //       style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.w600,
                //           color: Color(0xff000000)),
                //     ),
                // SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     invoice.buktiKirim != null
                // ? Image.network(
                //     Uri.encodeFull(
                //         '${MainUrl}/${invoice.buktiKirim}'),
                //     width: 70,
                //     height: 70,
                //     loadingBuilder: (BuildContext context,
                //         Widget child,
                //         ImageChunkEvent? loadingProgress) {
                //       if (loadingProgress == null) {
                //         return child;
                //       } else {
                //         return Center(
                //           child: CircularProgressIndicator(
                //             value: loadingProgress
                //                         .expectedTotalBytes !=
                //                     null
                //                 ? loadingProgress
                //                         .cumulativeBytesLoaded /
                //                     loadingProgress
                //                         .expectedTotalBytes!
                //                 : null,
                //           ),
                //         );
                //       }
                //     },
                //     errorBuilder: (BuildContext context,
                //         Object exception,
                //         StackTrace? stackTrace) {
                //       return Text('Gagal memuat gambar');
                //     },
                //   )
                //         : _image1 == null
                //             ? Container(
                //                 decoration: BoxDecoration(
                //                     borderRadius:
                //                         BorderRadius.circular(10),
                //                     border: Border.all(
                //                         color: Color(0xff9E0507))),
                //                 padding: EdgeInsets.all(8),
                //                 width: 70,
                //                 height: 70,
                //                 child: Center(
                //                     child: Text(
                //                   "No Image",
                //                   textAlign: TextAlign.center,
                //                 )),
                //               )
                //             : Container(
                //                 decoration: BoxDecoration(
                //                     borderRadius:
                //                         BorderRadius.circular(10),
                //                     border: Border.all(
                //                         color: Color(0xff6B8A7A))),
                //                 padding: EdgeInsets.all(8),
                //                 width: 70,
                //                 height: 70,
                //                 child: Image.file(_image1!),
                //               ),
                //     invoice.buktiKirim != null
                //         ? ElevatedButton(
                //             style: ElevatedButton.styleFrom(
                //               onPrimary: Colors.white,
                //               shape: RoundedRectangleBorder(
                //                   borderRadius:
                //                       BorderRadius.circular(10)),
                //               primary: Color(0xff9E0507),
                //             ),
                //             onPressed: () {
                //               showDialog(
                //                   context: context,
                //                   builder: (BuildContext context) {
                //                     return Dialog(
                //                       child: GestureDetector(
                //                         onTap: () {
                //                           Navigator.of(context).pop();
                //                         },
                //                         child: Image.network(
                //                           Uri.encodeFull(
                //                               '${MainUrl}/${invoice.buktiKirim}'),
                //                           fit: BoxFit.contain,
                //                         ),
                //                       ),
                //                     );
                //                   });
                //             },
                //             child: Container(
                //                 padding: EdgeInsets.symmetric(
                //                     horizontal: 5, vertical: 10),
                //                 child: Container(
                //                     padding: EdgeInsets.symmetric(
                //                         horizontal: 5, vertical: 1),
                //                     child: Column(
                //                       children: [
                //                         Text(
                //                           "Lihat",
                //                           style: TextStyle(fontSize: 12),
                //                         ),
                //                         Text(
                //                           "Bukti",
                //                           style: TextStyle(fontSize: 12),
                //                         ),
                //                       ],
                //                     ))))
                //         : Row(
                //             children: [
                //               ElevatedButton(
                //                   style: ElevatedButton.styleFrom(
                //                     onPrimary: Colors.white,
                //                     shape: RoundedRectangleBorder(
                //                         borderRadius:
                //                             BorderRadius.circular(10)),
                //                     primary: Color(0xff9E0507),
                //                   ),
                //                   onPressed: () =>
                //                       _pickImage1(ImageSource.gallery),
                //                   child: Container(
                //                       padding: EdgeInsets.symmetric(
                //                           horizontal: 5, vertical: 10),
                //                       child: Container(
                //                           padding: EdgeInsets.symmetric(
                //                               horizontal: 5, vertical: 1),
                //                           child: Column(
                //                             children: [
                //                               Text(
                //                                 "Choose",
                //                                 style: TextStyle(
                //                                     fontSize: 12),
                //                               ),
                //                               Text(
                //                                 "Photo",
                //                                 style: TextStyle(
                //                                     fontSize: 12),
                //                               ),
                //                             ],
                //                           )))),
                //               SizedBox(
                //                 width: 10,
                //               ),
                //               ElevatedButton(
                //                   style: ElevatedButton.styleFrom(
                //                     onPrimary: Colors.white,
                //                     shape: RoundedRectangleBorder(
                //                         borderRadius:
                //                             BorderRadius.circular(10)),
                //                     primary: Color(0xff9E0507),
                //                   ),
                //                   onPressed: () =>
                //                       _pickImage1(ImageSource.camera),
                //                   child: Container(
                //                       padding: EdgeInsets.symmetric(
                //                           horizontal: 5, vertical: 10),
                //                       child: Column(
                //                         children: [
                //                           Text(
                //                             "Take",
                //                             style:
                //                                 TextStyle(fontSize: 12),
                //                           ),
                //                           Text(
                //                             "Photo",
                //                             style:
                //                                 TextStyle(fontSize: 12),
                //                           ),
                //                         ],
                //                       ))),
                //             ],
                //           ),
                //   ],
                // ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   padding: EdgeInsets.all(8),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(16),
                //     border: Border.all(color: Color(0xff9E0507)),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.5),
                //         spreadRadius: 2,
                //         blurRadius: 7,
                //         offset: Offset(0, 5), // changes position of shadow
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "Bukti Pembayaran",
                //         style: TextStyle(
                //             fontSize: 20,
                //             fontWeight: FontWeight.w600,
                //             color: Color(0xff000000)),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           invoice.buktiBayar != null
                //               ? Image.network(
                //                   Uri.encodeFull(
                //                       '${MainUrl}/${invoice.buktiBayar}'),
                //                   width: 70,
                //                   height: 70,
                //                   loadingBuilder: (BuildContext context,
                //                       Widget child,
                //                       ImageChunkEvent? loadingProgress) {
                //                     if (loadingProgress == null) {
                //                       return child;
                //                     } else {
                //                       return Center(
                //                         child: CircularProgressIndicator(
                //                           value: loadingProgress
                //                                       .expectedTotalBytes !=
                //                                   null
                //                               ? loadingProgress
                //                                       .cumulativeBytesLoaded /
                //                                   loadingProgress
                //                                       .expectedTotalBytes!
                //                               : null,
                //                         ),
                //                       );
                //                     }
                //                   },
                //                   errorBuilder: (BuildContext context,
                //                       Object exception,
                //                       StackTrace? stackTrace) {
                //                     return Text('Gagal memuat gambar');
                //                   },
                //                 )
                //               : _image == null
                //                   ? Container(
                //                       decoration: BoxDecoration(
                //                           borderRadius:
                //                               BorderRadius.circular(10),
                //                           border: Border.all(
                //                               color: Color(0xff9E0507))),
                //                       padding: EdgeInsets.all(8),
                //                       width: 70,
                //                       height: 70,
                //                       child: Center(
                //                           child: Text(
                //                         "No Image",
                //                         textAlign: TextAlign.center,
                //                       )),
                //                     )
                //                   : Container(
                //                       decoration: BoxDecoration(
                //                           borderRadius:
                //                               BorderRadius.circular(10),
                //                           border: Border.all(
                //                               color: Color(0xff6B8A7A))),
                //                       padding: EdgeInsets.all(8),
                //                       width: 70,
                //                       height: 70,
                //                       child: Image.file(_image!),
                //                     ),
                //           invoice.buktiKirim != null
                //               ? ElevatedButton(
                //                   style: ElevatedButton.styleFrom(
                //                     onPrimary: Colors.white,
                //                     shape: RoundedRectangleBorder(
                //                         borderRadius:
                //                             BorderRadius.circular(10)),
                //                     primary: Color(0xff9E0507),
                //                   ),
                //                   onPressed: () {
                //                     showDialog(
                //                         context: context,
                //                         builder: (BuildContext context) {
                //                           return Dialog(
                //                             child: GestureDetector(
                //                               onTap: () {
                //                                 Navigator.of(context).pop();
                //                               },
                //                               child: Image.network(
                //                                 Uri.encodeFull(
                //                                     '${MainUrl}/${invoice.buktiBayar}'),
                //                                 fit: BoxFit.contain,
                //                               ),
                //                             ),
                //                           );
                //                         });
                //                   },
                //                   child: Container(
                //                       padding: EdgeInsets.symmetric(
                //                           horizontal: 5, vertical: 10),
                //                       child: Container(
                //                           padding: EdgeInsets.symmetric(
                //                               horizontal: 5, vertical: 1),
                //                           child: Column(
                //                             children: [
                //                               Text(
                //                                 "Lihat",
                //                                 style: TextStyle(fontSize: 12),
                //                               ),
                //                               Text(
                //                                 "Bukti",
                //                                 style: TextStyle(fontSize: 12),
                //                               ),
                //                             ],
                //                           ))))
                //               : Row(
                //                   children: [
                //                     ElevatedButton(
                //                         style: ElevatedButton.styleFrom(
                //                           onPrimary: Colors.white,
                //                           shape: RoundedRectangleBorder(
                //                               borderRadius:
                //                                   BorderRadius.circular(10)),
                //                           primary: Color(0xff9E0507),
                //                         ),
                //                         onPressed: () =>
                //                             _pickImage(ImageSource.gallery),
                //                         child: Container(
                //                             padding: EdgeInsets.symmetric(
                //                                 horizontal: 5, vertical: 10),
                //                             child: Container(
                //                                 padding: EdgeInsets.symmetric(
                //                                     horizontal: 5, vertical: 1),
                //                                 child: Column(
                //                                   children: [
                //                                     Text(
                //                                       "Choose",
                //                                       style: TextStyle(
                //                                           fontSize: 12),
                //                                     ),
                //                                     Text(
                //                                       "Photo",
                //                                       style: TextStyle(
                //                                           fontSize: 12),
                //                                     ),
                //                                   ],
                //                                 )))),
                //                     SizedBox(
                //                       width: 10,
                //                     ),
                //                     ElevatedButton(
                //                         style: ElevatedButton.styleFrom(
                //                           onPrimary: Colors.white,
                //                           shape: RoundedRectangleBorder(
                //                               borderRadius:
                //                                   BorderRadius.circular(10)),
                //                           primary: Color(0xff9E0507),
                //                         ),
                //                         onPressed: () =>
                //                             _pickImage(ImageSource.camera),
                //                         child: Container(
                //                             padding: EdgeInsets.symmetric(
                //                                 horizontal: 5, vertical: 10),
                //                             child: Column(
                //                               children: [
                //                                 Text(
                //                                   "Take",
                //                                   style:
                //                                       TextStyle(fontSize: 12),
                //                                 ),
                //                                 Text(
                //                                   "Photo",
                //                                   style:
                //                                       TextStyle(fontSize: 12),
                //                                 ),
                //                               ],
                //                             ))),
                //                   ],
                //                 ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Tagihan Selanjutnya",
                      //   style: TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.w600,
                      //       color: Color(0xff000000)),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(12),
                      //       color: Colors.black.withOpacity(0.05)),
                      //   child: TextField(
                      //     // controller: RegisterController.emailController,
                      //     decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       hintText: 'Rp.10.000.000',
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                actionId.contains(39) || roles == 1
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    child: Text('Cetak Invoice'),
                                    onPressed: () async {
                                      print(
                                          "length ${invoice.delivery.purchaseOrder.address.length}");
                                      final status =
                                          await Permission.storage.request();
                                      if (status.isGranted) {
                                        final pdfFile =
                                            await PdfInvoiceApi.generate(
                                                invoice);
                                        PdfApi.openFile(pdfFile);
                                      } else {
                                        print('print error');
                                      }
                                      // if (invoice.buktiKirim != null &&
                                      //     invoice.buktiBayar != null) {
                                      //   // If both buktiKirim and buktiBayar are not null
                                      //   final status =
                                      //       await Permission.storage.request();
                                      //   if (status.isGranted) {
                                      //     final pdfFile =
                                      //         await PdfInvoiceApi.generate(invoice);
                                      //     PdfApi.openFile(pdfFile);
                                      //   } else {
                                      //     print('print error');
                                      //   }
                                      // } else if (_image == null || _image1 == null) {
                                      //   // If images are null
                                      //   Get.snackbar('Error', 'Bukti Belum Di Upload',
                                      //       backgroundColor: Colors.red,
                                      //       colorText: Colors.white);
                                      // } else {
                                      //   // If images are present, submit the form and generate the PDF
                                      //   InvoiceController().submitForm(
                                      //       _image!, _image1!, invoice.kodeInvoice);
                                      //   final status =
                                      //       await Permission.storage.request();
                                      //   if (status.isGranted) {
                                      //     final pdfFile =
                                      //         await PdfInvoiceApi.generate(invoice);
                                      //     PdfApi.openFile(pdfFile);
                                      //   } else {
                                      //     print('print error');
                                      //   }
                                      // }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      primary: Color(0xffBF1619),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
