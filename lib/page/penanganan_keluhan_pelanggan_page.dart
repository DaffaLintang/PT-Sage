import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pt_sage/controllers/pengiriman.dart';
import 'package:pt_sage/page/list_penanganan-pelanggan_page.dart';
import 'package:pt_sage/page/list_po_page.dart';

import '../controllers/keluahanPelanggan_controller.dart';
import '../models/keluhanCustomer.dart';

class DetailPenanggananKeluhan extends StatefulWidget {
  const DetailPenanggananKeluhan({Key? key}) : super(key: key);

  @override
  State<DetailPenanggananKeluhan> createState() =>
      _DetailPenanggananKeluhanState();
}

class _DetailPenanggananKeluhanState extends State<DetailPenanggananKeluhan> {
  final keluhan = Get.arguments;
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
  );
  DateTime? pickedDate;
  final KeluhanPelangganController controller =
      Get.put(KeluhanPelangganController());
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
    fetchKeluhan();
  }

  void fetchKeluhan() async {
    DetailKeluhan? fetchKeluhan =
        await controller.getAdminDetailKeluhan(keluhan.id);
    ;
    setState(() {
      detailKeluhan = fetchKeluhan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Keluhan Pelanggan",
          style: TextStyle(
              color: Color(0xffBF1619),
              fontFamily: GoogleFonts.rubik().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => ListPenanggananKeluhanPelangganPage());
            },
            icon: Image.asset('assets/LineRed.png')),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator()); // Show loading
        } else {
          // Your UI when data is loaded
          return ListView(
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
                            "Detail Keluhan Pelanggan",
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
                          Text(detailKeluhan!.customer.customersName),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Kode Invoice",
                            style: TextStyle(
                                color: Color(0xff9E0507),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(detailKeluhan!.kodeInvoice),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Keluhan",
                            style: TextStyle(
                                color: Color(0xff9E0507),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(detailKeluhan!.complaint),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Tanggal Pengaduan",
                            style: TextStyle(
                                color: Color(0xff9E0507),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(DateFormat('yyyy-MM-dd')
                              .format(detailKeluhan!.createdAt)),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Petugas",
                            style: TextStyle(
                                color: Color(0xff9E0507),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(detailKeluhan!.user.fullname),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Nomor Lot",
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
                            itemCount:
                                detailKeluhan!.delivery.detailDelivery.length,
                            itemBuilder: (context, index) {
                              return Text(
                                  "${index + 1}. ${detailKeluhan!.delivery.detailDelivery[index].productLot.lotNumber}");
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Varietas",
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
                            itemCount: detailKeluhan!
                                .delivery.purchaseOrder.product.varietas.length,
                            itemBuilder: (context, index) {
                              return Text(
                                  "${index + 1}. ${detailKeluhan!.delivery.purchaseOrder.product.varietas[index].varietasName}");
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          // margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: SizedBox(
                              width: 100,
                              height: 45,
                              child: ElevatedButton(
                                child: Text(
                                  'Retur',
                                  style: TextStyle(fontSize: 12),
                                ),
                                onPressed: () {
                                  KeluhanPelangganController()
                                      .retur(keluhan.id);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  primary: Color(0xff008000),
                                ),
                              )),
                        ),
                        Container(
                          // margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: SizedBox(
                              width: 100,
                              height: 45,
                              child: ElevatedButton(
                                child: Text('Non Retur',
                                    style: TextStyle(fontSize: 12)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Jenis Keluhan"),
                                        content: StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.black
                                                    .withOpacity(0.05),
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    'Pilih Jenis Keluhan',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                    ),
                                                  ),
                                                  items:
                                                      items.map((String item) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  value:
                                                      selectedValue, // Nilai yang dipilih
                                                  onChanged: (String? value) {
                                                    // Mengubah nilai yang dipilih dan memperbarui tampilan dialog
                                                    setState(() {
                                                      selectedValue = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Tutup dialog tanpa melakukan apapun
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Ketika tombol submit ditekan
                                              KeluhanPelangganController()
                                                  .nonRetur(keluhan.id,
                                                      selectedValue);
                                              Navigator.of(context)
                                                  .pop(); // Tutup dialog setelah submit
                                            },
                                            child: Text('Submit'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  primary: Color.fromARGB(255, 47, 133, 225),
                                ),
                              )),
                        ),
                        Container(
                          // margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: SizedBox(
                              width: 100,
                              height: 45,
                              child: ElevatedButton(
                                child: Text(
                                  'Reject',
                                  style: TextStyle(fontSize: 12),
                                ),
                                onPressed: () {
                                  KeluhanPelangganController()
                                      .reject(keluhan.id);
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
          );
        }
      }),
    );
  }
}
