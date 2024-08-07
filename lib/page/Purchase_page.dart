import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/models/warper.dart';
import 'package:pt_sage/page/list_po_page.dart';
import 'package:sp_util/sp_util.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import '../controllers/purchase_order_controller.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  var _bottomNavIndex = 0;
  bool isFormatting = false;

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
  );

  final List<String> items = [];
  String? selectedValue;
  final Map<String, int> customertMap = {};

  final List<String> itemsProduk = [];
  String? selectedValueProduk;
  final Map<String, int> productMap = {};
  final Map<String, String> hargaMap = {};

  final List<String> itemsTempo = [
    '7 Hari',
    '15 Hari',
    '30 Hari',
    '60 Hari',
    '90 Hari',
  ];
  String? selectedValueTempo;

  final List<String> itemsDp = [
    'ya',
    'Tidak',
  ];
  String? selectedValueDp;

  int? customerId;
  int? productId;
  int? total;

  @override
  void initState() {
    super.initState();
    fetchProduct();
    fetchCustomer();
    PoController.jDpController.text = '';
  }

  void fetchProduct() async {
    final poController = PoController();
    DataWrapper? dataWrapper = await poController.getProductData();
    setState(() {
      dataWrapper?.products.forEach((product) {
        itemsProduk.add(product.productName);
        productMap[product.productName] = product.id;
        hargaMap[product.productName] = product.price;
      });
    });
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

  void hitungHarga() {
    setState(() {
      int jumlah = int.parse(PoController.jumlahConroller.text);
      String? hargaString = SpUtil.getString("harga");
      int harga = int.parse(hargaString ?? '0');
      total = harga * jumlah;
      PoController.hargaController.text =
          currencyFormatter.format(int.parse(total.toString()));
      // SpUtil.putInt('total', total);
    });
  }

  String getRawValue(String formattedValue) {
    // Remove all non-digit characters
    return formattedValue.replaceAll(RegExp(r'[^\d]'), '');
  }

  void handleTextChange() {
    String value = PoController.jumlahConroller.text;
    if (value.isEmpty || int.tryParse(value) == null || int.parse(value) < 1) {
      PoController.jumlahConroller.text = '1';
      PoController.jumlahConroller.selection = TextSelection.fromPosition(
          TextPosition(offset: PoController.jumlahConroller.text.length));
    }
    hitungHarga();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Purchase Order",
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Detail Purchase Order",
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Pilih Customer',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: items
                                .map((String customerName) =>
                                    DropdownMenuItem<String>(
                                      value: customerName,
                                      child: Text(
                                        customerName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                                customerId = customertMap[selectedValue!];
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pilih Produk",
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
                              'Pilih Produk',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: itemsProduk
                                .map((String productName) =>
                                    DropdownMenuItem<String>(
                                      value: productName,
                                      child: Text(
                                        productName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValueProduk,
                            onChanged: (String? value) {
                              setState(() {
                                PoController.jumlahConroller.text = '1';
                                hitungHarga();
                                selectedValueProduk = value;
                                productId = productMap[selectedValueProduk!];
                                String? productPrice =
                                    hargaMap[selectedValueProduk!];
                                // SpUtil.putInt('produk', productId!);
                                SpUtil.putString('harga', productPrice!);
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Jumlah",
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
                          onEditingComplete: handleTextChange,
                          keyboardType: TextInputType.number,
                          controller: PoController.jumlahConroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Jumlah',
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
                      Text("Total Bayar",
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
                          enabled: false,
                          controller: PoController.hargaController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Total Bayar',
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
                      Text("Tempo",
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
                              'Berapa Hari',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: itemsTempo
                                .map((String itemsTempo) =>
                                    DropdownMenuItem<String>(
                                      value: itemsTempo,
                                      child: Text(
                                        itemsTempo,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValueTempo,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValueTempo = value;
                                // SpUtil.putString(
                                //     'tempo', selectedValueTempo.toString());
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Diskon (opsional)",
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
                          controller: PoController.diskonController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Diskon',
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
                      Text("DP?",
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
                              'Dp?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: itemsDp
                                .map((String itemsDp) =>
                                    DropdownMenuItem<String>(
                                      value: itemsDp,
                                      child: Text(
                                        itemsDp,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValueDp,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValueDp = value;
                                SpUtil.putString(
                                    "dp", selectedValueDp.toString());
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
                selectedValueDp == null
                    ? SizedBox()
                    : selectedValueDp == "ya"
                        ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Bayar Dp",
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
                                    controller: PoController.jDpController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Total Bayar Dp',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        child: Text('Kirim'),
                        onPressed: () {
                          String jumlahDp =
                              getRawValue(PoController.jDpController.text);
                          print(jumlahDp);
                          PoController().store(customerId, productId, total,
                              selectedValueTempo, selectedValueDp, jumlahDp);
                        },
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
    );
  }
}
