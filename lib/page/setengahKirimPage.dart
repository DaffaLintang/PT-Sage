import 'dart:ffi';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pt_sage/controllers/pengiriman.dart';
import 'package:pt_sage/controllers/purchase_order_controller.dart';
import 'package:pt_sage/models/lot.dart';
import 'package:pt_sage/models/transaksiPoKendaraan.dart';
import 'package:pt_sage/models/warper.dart';
import 'package:pt_sage/page/home_page.dart';
import 'package:pt_sage/page/list_pengiriman.dart';

import '../models/kendaraan.dart';

class SetenggahKirimPage extends StatefulWidget {
  const SetenggahKirimPage({Key? key}) : super(key: key);

  @override
  State<SetenggahKirimPage> createState() => _SetenggahKirimPageState();
}

class _SetenggahKirimPageState extends State<SetenggahKirimPage> {
  final List<String> items = [];
  final Map<String, int> customertMap = {};
  final Map<String, int> kendaraanMap = {};
  final Map<String, int> noPolMap = {};
  String? selectedValue;
  String? selectedValue1;
  String? selectedValue2;
  int? customerId;
  int? KendaraanId;
  late var rawValue = '';
  final order = Get.arguments;
  List<ProductLot>? productLots;
  List<bool>? isChecked;
  List<int> selectedProductLotIds = [];
  List<int> selectedJumlahProductLotIds = [];
  final Map<String, int> kemasan = {};
  final List<String> itemsKendaraan = [];
  List<int> pcsKirim = [];
  bool isInitialized = false;
  int? productId;
  DateTime? pickedDate;
  List<int> noPolIds = [];
  List<String> noPol = [];

  @override
  void initState() {
    super.initState();
    // print(order);
    productId = order.purchaseOrder.productId;

    // Run initialization only if it's not already done
    if (!isInitialized) {
      // fetchCustomer();
      if (order.purchaseOrder.deliveryStatus == "setengah di kirim") {
        fetchKendaraan();
        PengirimanController().getKendaraan();
        fetchProductLot();
      } else {
        TransasiPofetchKendaraan();
        fetchTransaksiProductLot();
      }
      PengirimanController.customerController.text =
          order.customer.customersName;

      PengirimanController.dateController
        ..text = DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(order.tanggalPengiriman));

      // Set the flag to true after initialization
      isInitialized = true;
    }
  }

  Future<void> fetchNoPol(id) async {
    try {
      var nopolData = await PengirimanController().TransaksiPogetNoPol(id);

      setState(() {
        noPolIds = nopolData?.map((nopols) => nopols.id).toList() ?? [];
        noPol = nopolData?.map((nopols) => nopols.noPolisi).toList() ?? [];

        // Memetakan nomor polisi (noPol) ke ID (noPolIds) menggunakan Map<String, List<int>>
        for (int i = 0; i < noPol.length; i++) {
          noPolMap[noPol[i]] = noPolIds[i];
        }
      });

      // Debugging output untuk memeriksa hasil
    } catch (e) {
      print('Error fetching NoPol data: $e');
    }
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
        PengirimanController.dateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate!);
      });
    }
  }

  void fetchKendaraan() async {
    List<Kendaraan>? kendaraanList =
        await PengirimanController().getKendaraan();
    setState(() {
      kendaraanList?.forEach((kendaraan) {
        itemsKendaraan.add(kendaraan.jenisKendaraan);
        // print(kendaraan.jenisKendaraan);
        kendaraanMap[kendaraan.jenisKendaraan] = kendaraan.id;
        // noPolMap[kendaraan.jenisKendaraan] = kendaraan.noPolisi;
      });
    });
  }

  void TransasiPofetchKendaraan() async {
    List<TransaksiPoKendaraan>? kendaraanList =
        await PengirimanController().TransaksiPogetKendaraan();
    setState(() {
      kendaraanList?.forEach((kendaraan) {
        itemsKendaraan.add(kendaraan.jenisKendaraan);
        print(kendaraan.jenisKendaraan);
        kendaraanMap[kendaraan.jenisKendaraan] = kendaraan.id;
        // noPolMap[kendaraan.jenisKendaraan] = kendaraan.noPolisi;
      });
    });
  }

  void fetchProductLot() async {
    List<ProductLot>? productLotList =
        await PengirimanController().getProductLotData(productId);

    setState(() {
      productLots = productLotList ?? [];
      isChecked = List<bool>.filled(productLots!.length, false);
    });
  }

  void fetchTransaksiProductLot() async {
    List<ProductLot>? productLotList =
        await PengirimanController().getTransaksiPoProductLotData(productId);

    setState(() {
      productLots = productLotList;
      isChecked = List<bool>.filled(productLots!.length, false);
    });
  }

  void printValue() {
    if (pcsKirim.isEmpty) {
      Get.snackbar('Error', 'Silahkan Pilih Jumlah Lot',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      for (int i = 0; i < order.detailDelivery.length; i++) {
        var id = order.detailDelivery[i].kemasanId;
        var quantity = pcsKirim[i];
        kemasan.addAll({"${id}": quantity});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pengiriman Barang",
          style: TextStyle(
              color: Color(0xff9E0507),
              fontFamily: GoogleFonts.rubik().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => ListPengiriman());
              PengirimanController.kendaraanController.text = '';
              PengirimanController.noPolController.text = '';
              PengirimanController.supirController.text = '';
            },
            icon: Image.asset('assets/LineRed.png')),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      order.kodePengiriman,
                      style: TextStyle(
                          fontFamily: GoogleFonts.rubik().fontFamily,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    )),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Customer",
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
                          controller: PengirimanController.customerController,
                          enabled: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nama Customer',
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
                      Text("Pilih Kendaraan",
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Pilih Kendaraan',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: itemsKendaraan
                                .map((String kendaraan) =>
                                    DropdownMenuItem<String>(
                                      value: kendaraan,
                                      child: Text(
                                        kendaraan,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue1,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue1 = value;
                                KendaraanId = kendaraanMap[selectedValue1!];
                                // PengirimanController.noPolController.text =
                                //     noPolMap[selectedValue1] ?? '';

                                fetchNoPol(KendaraanId);
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),

                // Container(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text("Kendaraan",
                //           style: TextStyle(
                //               fontFamily: GoogleFonts.rubik().fontFamily)),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Container(
                //         padding:
                //             EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(12),
                //             color: Colors.black.withOpacity(0.05)),
                //         child: TextField(
                //           controller: PengirimanController.kendaraanController,
                //           decoration: InputDecoration(
                //             border: InputBorder.none,
                //             hintText: 'Kendaraan',
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 20,
                //       ),
                //     ],
                //   ),
                // ),

                selectedValue1 == null
                    ? SizedBox()
                    : Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pilih Nomor Polisi",
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
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      'Pilih Kendaraan',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: noPol.map((String no) {
                                      return DropdownMenuItem<String>(
                                        value: no,
                                        child: Text(
                                          no,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    value: selectedValue2,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedValue2 = value;
                                        print(
                                            'selectedValue2: $selectedValue2'); // Cek nilai selectedValue2

                                        // Cek apakah selectedValue2 ada di noPolMap

                                        rawValue = noPolMap[selectedValue2!]
                                            .toString();
                                      });
                                    },
                                  ),
                                )),
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
                      Text("Nama Supir",
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
                          controller: PengirimanController.supirController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nama Supir',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                // Container(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text("Nomor Polisi",
                //           style: TextStyle(
                //               fontFamily: GoogleFonts.rubik().fontFamily)),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Container(
                //         padding:
                //             EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(12),
                //             color: Colors.black.withOpacity(0.05)),
                //         child: TextField(
                //           enabled: false,
                //           controller: PengirimanController.noPolController,
                //           decoration: InputDecoration(
                //             border: InputBorder.none,
                //             hintText: 'Nomor Polisi',
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 20,
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tanggal",
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
                            controller: PengirimanController.dateController,
                            // enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tanggal',
                            ),
                            onTap: () {
                              selectedDate();
                            },
                            showCursor: true,
                            readOnly: true),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Text("Pilih Lot",
                    style:
                        TextStyle(fontFamily: GoogleFonts.rubik().fontFamily)),
                // Text(productLots![0].lotNumber ?? 'No Lot Number'),
                productLots == null || productLots!.isEmpty
                    ? Center(child: Text('No product lots available'))
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: productLots!.length,
                        itemBuilder: (context, index) {
                          ProductLot productLot = productLots![index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Color(0xff9E0507),
                              child: Text(productLot.id.toString()),
                            ),
                            title: Text(' ${productLot.lotNumber}'),
                            subtitle: Text('Quantity: ${productLot.quantity}'),
                            trailing: Checkbox(
                              value: isChecked![index],
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked![index] = value!;
                                  if (isChecked![index]) {
                                    pcsKirim.clear();
                                    selectedProductLotIds.add(productLot.id);
                                    selectedJumlahProductLotIds
                                        .add(int.parse(productLot.quantity));
                                    for (int z = 0;
                                        z < order.detailDelivery.length;
                                        z++) {
                                      int jlmPcs =
                                          ((int.parse(productLot.quantity) /
                                                      order.detailDelivery
                                                          .length) /
                                                  order.detailDelivery[z]
                                                      .kemasan.weight)
                                              .toInt();
                                      if (jlmPcs *
                                              order.detailDelivery[z].kemasan
                                                  .weight <=
                                          order.purchaseOrder.detailPos[z]
                                              .jumlahKgKemasan) {
                                        pcsKirim.add(
                                            ((int.parse(productLot.quantity) /
                                                        order.detailDelivery
                                                            .length) /
                                                    order.detailDelivery[z]
                                                        .kemasan.weight)
                                                .toInt());
                                      } else {
                                        num totalBerat = jlmPcs *
                                            order.detailDelivery[z].kemasan
                                                .weight;
                                        num selisih = totalBerat -
                                            order.purchaseOrder.detailPos[z]
                                                .jumlahKgKemasan;
                                        num jumlahAsli = totalBerat - selisih;
                                        pcsKirim.add(((jumlahAsli *
                                                    order
                                                        .detailDelivery.length /
                                                    order.detailDelivery
                                                        .length) /
                                                order.detailDelivery[z].kemasan
                                                    .weight)
                                            .toInt());
                                      }
                                    }
                                    print(pcsKirim);
                                  } else {
                                    pcsKirim.clear();
                                    selectedProductLotIds.remove(productLot.id);
                                    selectedJumlahProductLotIds
                                        .remove(int.parse(productLot.quantity));
                                  }
                                });
                              },
                            ),
                          );
                        }),
                Text("Jumlah Kemasan",
                    style:
                        TextStyle(fontFamily: GoogleFonts.rubik().fontFamily)),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: order.detailDelivery.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                            'Kemasan: ${order.detailDelivery[index].kemasan.weight} Kg'),
                        subtitle: Text(
                            'Pcs: ${pcsKirim.length > 0 ? pcsKirim[index] : 0}'),
                        trailing: Text(
                            "Jumlah: ${order.purchaseOrder.detailPos[index].jumlahKgKemasan} Kg"));
                  },
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 80),
                        child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              child: Text('Kirim'),
                              onPressed: () {
                                if (pcsKirim.length == 1 &&
                                    pcsKirim.contains(0)) {
                                  Get.snackbar('Error', 'Jumlah Lot Kurang',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white);
                                } else {
                                  printValue();
                                  PengirimanController()
                                      .TransaksiDeliveryUpdate(
                                    rawValue,
                                    order.kodePengiriman,
                                    KendaraanId,
                                    PengirimanController.supirController.text,
                                    PengirimanController.noPolController.text,
                                    PengirimanController.dateController.text,
                                    selectedProductLotIds,
                                    kemasan,
                                    selectedJumlahProductLotIds,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                primary: Color(0xff9E0507),
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
