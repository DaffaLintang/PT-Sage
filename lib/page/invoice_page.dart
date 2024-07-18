import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pt_sage/page/home_page.dart';
import 'dart:io' as io;

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  io.File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = io.File(pickedFile.path);
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
              Get.offAll(() => HomePage());
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
                              "#INVC0001",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.rubik().fontFamily,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Tanggal : 15/06/2024 ",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.rubik().fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Text(
                          "#KodePengiriman",
                          style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "#KodePO",
                          style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(18),
                  width: double.infinity,
                  height: 300,
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
                      Text("Daffa Lintang"),
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
                      Text("Jl. Veteran 200 Gorontalo"),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Jenis Customer",
                        style: TextStyle(
                            color: Color(0xff9E0507),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Petani"),
                      SizedBox(
                        height: 15,
                      ),
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
                      Text("089123123123"),
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
                      DataTable(
                        columnSpacing: 8.0,
                        columns: [
                          DataColumn(
                              label: Text("Nama Barang",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))),
                          DataColumn(
                              label: Text("Jumlah",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))),
                          DataColumn(
                              label: Text("Nomor Lot",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))),
                          DataColumn(
                              label: Text("Tanggal",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(
                              Container(
                                width: 80, // Set a specific width if needed
                                child: Text(
                                  "Jaggung 100kg 5x",
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow
                                      .clip, // Optional: Specify the overflow behavior
                                ),
                              ),
                            ),
                            DataCell(
                              Text("5"),
                            ),
                            DataCell(
                              Text("1"),
                            ),
                            DataCell(
                              Text("5/06/2024"),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(
                              Container(
                                width: 80, // Set a specific width if needed
                                child: Text(
                                  "Jaggung 100kg 5x",
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow
                                      .clip, // Optional: Specify the overflow behavior
                                ),
                              ),
                            ),
                            DataCell(
                              Text("5"),
                            ),
                            DataCell(
                              Text("1"),
                            ),
                            DataCell(
                              Text("5/06/2024"),
                            ),
                          ]),
                          DataRow(cells: [
                            DataCell(
                              Container(
                                width: 80, // Set a specific width if needed
                                child: Text(
                                  "Jaggung 100kg 5x",
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow
                                      .clip, // Optional: Specify the overflow behavior
                                ),
                              ),
                            ),
                            DataCell(
                              Text("5"),
                            ),
                            DataCell(
                              Text("1"),
                            ),
                            DataCell(
                              Text("5/06/2024"),
                            ),
                          ]),
                        ],
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
                                  "1/3",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text("Rp.100.000",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Bayar",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text("Rp.100.000",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sisa Bayar",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                                Text("Rp.10.100.000",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bukti Pengiriman",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _image == null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Color(0xff9E0507))),
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
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Color(0xff6B8A7A))),
                                  padding: EdgeInsets.all(8),
                                  width: 70,
                                  height: 70,
                                  child: Image.file(_image!),
                                ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                primary: Color(0xff9E0507),
                              ),
                              onPressed: () => _pickImage(ImageSource.gallery),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1),
                                child: Text(
                                  "Choose Photo",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ))
                        ],
                      ),
                    ],
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
                        offset: Offset(0, 5), // changes position of shadow
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _image == null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Color(0xff9E0507))),
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
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Color(0xff6B8A7A))),
                                  padding: EdgeInsets.all(8),
                                  width: 70,
                                  height: 70,
                                  child: Image.file(_image!),
                                ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                primary: Color(0xff9E0507),
                              ),
                              onPressed: () => _pickImage(ImageSource.gallery),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1),
                                child: Text(
                                  "Choose Photo",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ))
                        ],
                      ),
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
                      Text(
                        "Tagihan Selanjutnya",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000)),
                      ),
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
                          // controller: RegisterController.emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Rp.10.000.000',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Container(
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
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                primary: Color(0xffBF1619),
                              ),
                            )),
                      ),
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
