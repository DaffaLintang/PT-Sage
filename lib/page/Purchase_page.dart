import 'dart:ffi';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart'
    as numFormat;
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
  bool isFormatting = false;
  int _currentSelection = 0;
  String? totalBayar;
  int? totalHarga;
  final List<String> items = [];
  String? selectedValue;
  final Map<String, int> customertMap = {};
  final List<String> itemsProduk = [];
  String? selectedValueProduk;
  final Map<String, int> productMap = {};
  final Map<String, String> hargaMap = {};

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
  );

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
    print(productId);
    PoController.jDpController.text = '';
    PoController.diskonController.clear();
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
      totalHarga = (harga * jumlah);
      totalBayar = (harga * jumlah).toString();
      PoController.hargaController.text = currencyFormatter.format(harga);
      // SpUtil.putInt('total', total);
    });
  }

  String getRawValue(String formattedValue) {
    String plainValue = formattedValue.replaceAll(RegExp(r'[^\d]'), '');
    if (formattedValue.contains(',')) {
      plainValue = plainValue.substring(0, plainValue.length - 2);
    }

    return plainValue;
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

  void hitungDiskonNominal(String diskon) {
    int? total = totalHarga;

    if (diskon.isEmpty) {
      return;
    }
    try {
      setState(() {
        int totalDiskon = int.parse(diskon);
        if ((total! - totalDiskon) < 0) {
          Get.snackbar('Error', 'Diskon Melebihi Harga',
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          totalBayar = (total - totalDiskon).toString();
        }
      });
    } catch (e) {
      // Handle the error case where diskon is not a valid number
      print("Error parsing diskon: $e");
    }
  }

  void hitungDiskonPersen(String diskon) {
    int? total = totalHarga;

    if (diskon.isEmpty) {
      return;
    }
    if (diskon == 0) {
      totalBayar = total.toString();
    } else {
      try {
        setState(() {
          int totalDiskon = int.parse(diskon);
          double totalDiskonPersen = total! * (totalDiskon / 100);
          double hasil = total - totalDiskonPersen;
          String formattedValue = hasil.toStringAsFixed(0);
          totalBayar = formattedValue;
        });
      } catch (e) {
        // Handle the error case where diskon is not a valid number
        print("Error parsing diskon: $e");
      }
    }
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
                      Text("Harga Produk",
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
                      ToggleButtons(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              '%',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Rp',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                        isSelected: List.generate(
                            2, (index) => index == _currentSelection),
                        onPressed: (int newIndex) {
                          setState(() {
                            _currentSelection = newIndex;
                            // totalBayar = int.parse(getRawValue(
                            //         PoController.hargaController.text))
                            //     .toString();
                            PoController.diskonController.clear();
                            hitungDiskonPersen("0");
                          });
                        },
                        selectedColor: Colors.white,
                        fillColor: Color(0xffBF1619),
                        borderColor: Color(0xffBF1619),
                        borderRadius: BorderRadius.circular(12),
                        borderWidth: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _currentSelection == 0
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black.withOpacity(0.05)),
                              child: TextField(
                                onSubmitted: (value) {
                                  hitungDiskonPersen(
                                      PoController.diskonController.text);
                                  print(PoController.diskonController.text);
                                },
                                controller: PoController.diskonController,
                                inputFormatters: [
                                  numFormat.PercentageTextInputFormatter()
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.percent,
                                    color: Color(0xffBF1619),
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Persentase Diskon',
                                ),
                              ),
                            )
                          : Container(
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
                                controller: PoController.diskonController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nominal Diskon',
                                ),
                                onSubmitted: (String? value) {
                                  hitungDiskonNominal(getRawValue(
                                      PoController.diskonController.text));
                                },
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
                totalBayar == null
                    ? SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Bayar",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20)),
                          Text(
                              totalBayar == null
                                  ? ""
                                  : currencyFormatter
                                      .format(int.parse(totalBayar.toString())),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20)),
                        ],
                      ),
                SizedBox(
                  height: 10,
                ),
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
                          String jumlahDiskon =
                              PoController.diskonController.text;
                          PoController().store(
                              customerId,
                              productId,
                              totalBayar,
                              selectedValueTempo,
                              selectedValueDp,
                              jumlahDp,
                              getRawValue(jumlahDiskon),
                              _currentSelection);
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
