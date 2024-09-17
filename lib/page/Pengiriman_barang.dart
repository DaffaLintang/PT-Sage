import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pt_sage/controllers/pengiriman.dart';
import 'package:pt_sage/controllers/purchase_order_controller.dart';
import 'package:pt_sage/models/lot.dart';
import 'package:pt_sage/models/warper.dart';
import 'package:pt_sage/page/home_page.dart';
import 'package:pt_sage/page/list_pengiriman.dart';

class PengirimanBarangPage extends StatefulWidget {
  const PengirimanBarangPage({Key? key}) : super(key: key);

  @override
  State<PengirimanBarangPage> createState() => _PengirimanBarangPageState();
}

class _PengirimanBarangPageState extends State<PengirimanBarangPage> {
  final List<String> items = [];
  final Map<String, int> customertMap = {};
  String? selectedValue;
  int? customerId;
  final order = Get.arguments;
  List<ProductLot>? productLots;
  List<bool>? isChecked;
  List<int> selectedProductLotIds = [];
  List<int> selectedJumlahProductLotIds = [];
  final Map<String, int> kemasan = {};

  @override
  void initState() {
    super.initState();
    fetchCustomer();
    fetchProductLot();
    PengirimanController.customerController.text = order.customersName;
  }

  void fetchCustomer() async {
    final poController = PoController();
    DataWrapper? dataWrapper = await poController.getProductData();
    setState(() {
      dataWrapper?.customers.forEach((customer) {
        items.add(customer.customersName);
        customertMap[customer.customersName] = customer.id;
      });
    });
  }

  void fetchProductLot() async {
    List<ProductLot>? productLotList =
        await PengirimanController().getProductLotData();

    setState(() {
      productLots = productLotList;
      isChecked = List<bool>.filled(productLots!.length, false);
    });
  }

  void printValue() {
    for (int i = 0; i < order.kemasan.length; i++) {
      var id = order.kemasan[i].kemasanId;
      var quantity = order.kemasan[i].quantity ?? 0;
      kemasan.addAll({"${id}": quantity});
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
                      order.kodePo,
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
                      Text("Kendaraan",
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
                          controller: PengirimanController.kendaraanController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Kendaraan',
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nomor Polisi",
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
                          controller: PengirimanController.noPolController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nomor Polisi',
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
                          controller: PengirimanController.dateController
                            ..text = DateFormat('yyyy-MM-dd')
                                .format(order.tanggalPengiriman),
                          enabled: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tanggal',
                          ),
                        ),
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
                            title: Text('Lot Number: ${productLot.lotNumber}'),
                            subtitle: Text('Quantity: ${productLot.quantity}'),
                            trailing: Checkbox(
                              value: isChecked![index],
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked![index] = value!;
                                  if (isChecked![index]) {
                                    selectedProductLotIds.add(productLot.id);
                                    selectedJumlahProductLotIds
                                        .add(int.parse(productLot.quantity));
                                  } else {
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
                  itemCount: order.kemasan.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title:
                            Text('Kemasan: ${order.kemasan[index].berat} Kg'),
                        subtitle:
                            Text('Quantity: ${order.kemasan[index].quantity}'),
                        trailing: Text(
                            "Jumlah: ${order.kemasan[index].berat * order.kemasan[index].quantity} Kg"));
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
                                printValue();
                                PengirimanController().store(
                                    order.kodePo,
                                    order.customersId,
                                    PengirimanController
                                        .kendaraanController.text,
                                    PengirimanController.supirController.text,
                                    PengirimanController.noPolController.text,
                                    PengirimanController.dateController.text,
                                    selectedProductLotIds,
                                    kemasan,
                                    selectedJumlahProductLotIds,
                                    order.quantity);
                                // print(customerId);
                                // print(PengirimanController
                                //     .kendaraanController.text);
                                // print(
                                //     PengirimanController.supirController.text);
                                // print(
                                //     PengirimanController.noPolController.text);
                                // print(PengirimanController.dateController.text);
                                // print(selectedProductLotIds);
                                // print(order.kemasan);
                                // printValue();
                                // print(kemasan);
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
