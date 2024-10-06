import 'dart:ffi';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart'
    as numFormat;
import 'package:pt_sage/models/kemasan.dart';
import 'package:pt_sage/models/warper.dart';
import 'package:pt_sage/page/list_po_page.dart';
import 'package:sp_util/sp_util.dart';
import 'package:intl/intl.dart';

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
  late PoController poController;
  List<int> itemsKemasanIds = [];
  List<int> itemsKemasanWeights = [];
  List<String?> selectedKemasanValues = [];
  final Map<String, int> productMap = {};
  final Map<String, String> hargaMap = {};
  KemasanList? kemasanList;
  List<Map<String, dynamic>> formattedValues = [];
  int jumlahQuantity = 0;
  int? calculatedValue;
  int totalValue = 0;
  final PoController controller = Get.put(PoController());

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
  );

  final List<int> itemsTempo = [
    7,
    15,
    30,
    60,
    90,
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
    poController = Get.put(PoController());
    fetchKemasan();
    try {
      poController = Get.find<PoController>();
    } catch (e) {
      print('Error fetching PoController: $e');
    }
  }

  Future<void> fetchKemasan() async {
    var kemasanList = await poController.getKemasan();
    setState(() {
      itemsKemasanIds =
          kemasanList?.kemasan.map((kemasan) => kemasan.id).toList() ?? [];
      itemsKemasanWeights =
          kemasanList?.kemasan.map((kemasan) => kemasan.weight).toList() ?? [];

      selectedKemasanValues = List<String?>.generate(
        poController.jummlahKemasan.length,
        (index) => null,
        growable: true,
      );
    });
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

  void hitungHarga(hargaProduk) {
    setState(() {
      int jumlah = int.parse(PoController.jumlahConroller.text);
      // String? hargaString = SpUtil.getString("harga");
      int harga = int.parse(hargaProduk ?? '0');
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

  void handleTextChange(String value) {
    // String value = PoController.jumlahConroller.text;
    if (value.isEmpty || int.tryParse(value) == null || int.parse(value) < 1) {
      PoController.jumlahConroller.text = '1';
      PoController.jumlahConroller.selection = TextSelection.fromPosition(
          TextPosition(offset: PoController.jumlahConroller.text.length));
    }
    hitungHarga(hargaMap[selectedValueProduk ?? 0]);
  }

  void printValue() {
    for (int i = 0; i < selectedKemasanValues.length; i++) {
      var id = selectedKemasanValues[i];
      var quantity = int.tryParse(poController.jummlahKemasan[i].text) ?? 0;
      formattedValues.add({"id": int.parse(id ?? "0"), "quantity": quantity});
    }
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
                if (poController.jummlahKemasan.isNotEmpty) {
                  var firstElement = poController.jummlahKemasan.first;
                  firstElement.text = '';
                  poController.jummlahKemasan.clear();
                  poController.jummlahKemasan.add(firstElement);
                }
                PoController.diskonController.text = '';
                PoController.jDpController.text = '';
              },
              icon: Image.asset('assets/LineRed.png')),
          backgroundColor: Colors.white,
          elevation: 5,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator()); // Show loading
          } else {
            return ListView(
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
                                color: Colors.black.withOpacity(0.05),
                              ),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      60, // Sesuaikan dengan tinggi yang Anda inginkan
                                  maxWidth: double
                                      .infinity, // Agar lebar mengikuti container
                                ),
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
                                        customerId =
                                            customertMap[selectedValue!];
                                      });
                                    },
                                    buttonHeight:
                                        40, // Tentukan tinggi tombol dropdown sesuai ukuran yang diinginkan
                                    buttonWidth: double
                                        .infinity, // Agar lebar mengikuti container
                                    itemHeight: 40,
                                    dropdownMaxHeight: 200,
                                    searchController:
                                        PoController.searchController,
                                    searchInnerWidget: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 4,
                                        right: 8,
                                        left: 8,
                                      ),
                                      child: TextFormField(
                                        controller:
                                            PoController.searchController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search for a customer...',
                                          hintStyle:
                                              const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn: (item, searchValue) {
                                      return (item.value
                                          .toString()
                                          .contains(searchValue));
                                    },
                                    onMenuStateChange: (isOpen) {
                                      if (!isOpen) {
                                        PoController.searchController
                                            .clear(); // Clear search when menu is closed
                                      }
                                    },
                                    searchInnerWidgetHeight:
                                        120, // Menentukan tinggi dari widget pencarian
                                  ),
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
                                      selectedValueProduk = value;
                                      productId =
                                          productMap[selectedValueProduk!];
                                      String? productPrice =
                                          hargaMap[selectedValueProduk!];
                                      hitungHarga(productPrice!);
                                      // SpUtil.putInt('produk', productId!);
                                      // SpUtil.putString('harga', productPrice!);
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
                            Text("Harga Produk",
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
                            Text("Jumlah (kg)",
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
                                  // onEditingComplete: handleTextChange,
                                  keyboardType: TextInputType.number,
                                  controller: PoController.jumlahConroller,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Jumlah',
                                  ),
                                  onChanged: (String value) {
                                    handleTextChange(value);
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Pilih Kemasan",
                              style: TextStyle(
                                  fontFamily: GoogleFonts.rubik().fontFamily)),
                          GestureDetector(
                              child: Icon(
                                Icons.add_box_outlined,
                                color: Color(0xffBF1619),
                              ),
                              onTap: () {
                                setState(() {
                                  poController.jummlahKemasan
                                      .add(TextEditingController());
                                  selectedKemasanValues.add(null);
                                });
                              })
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: poController.jummlahKemasan.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            if (i >= selectedKemasanValues.length) {
                              return Container(); // Pastikan indeks berada dalam batas
                            }

                            int weight = 0;
                            if (selectedKemasanValues[i] != null) {
                              int? selectedId =
                                  int.tryParse(selectedKemasanValues[i]!);
                              int index = itemsKemasanIds.indexOf(selectedId!);
                              if (index != -1) {
                                weight = itemsKemasanWeights[index];
                              }
                            }

                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color:
                                                Colors.black.withOpacity(0.05),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              hint: Text(
                                                'Pilih Kemasan',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                              ),
                                              items: List.generate(
                                                  itemsKemasanIds.length,
                                                  (index) {
                                                return DropdownMenuItem<String>(
                                                  value: itemsKemasanIds[index]
                                                      .toString(), // Simpan ID sebagai nilai
                                                  child: Text(
                                                    '${itemsKemasanWeights[index]} Kg', // Tampilkan weight
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                );
                                              }),
                                              value: selectedKemasanValues[i],
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedKemasanValues[i] =
                                                      value;

                                                  // Update weight setelah pemilihan baru
                                                  int? selectedId =
                                                      int.tryParse(value!);
                                                  int index = itemsKemasanIds
                                                      .indexOf(selectedId!);
                                                  if (index != -1) {
                                                    weight =
                                                        itemsKemasanWeights[
                                                            index];
                                                  }

                                                  // Hitung dan update total
                                                  totalValue = 0;
                                                  for (int j = 0;
                                                      j <
                                                          poController
                                                              .jummlahKemasan
                                                              .length;
                                                      j++) {
                                                    int jumlah = int.tryParse(
                                                            poController
                                                                .jummlahKemasan[
                                                                    j]
                                                                .text) ??
                                                        0;
                                                    int itemWeight = 0;
                                                    if (selectedKemasanValues[
                                                            j] !=
                                                        null) {
                                                      int? selectedId =
                                                          int.tryParse(
                                                              selectedKemasanValues[
                                                                  j]!);
                                                      int index =
                                                          itemsKemasanIds
                                                              .indexOf(
                                                                  selectedId!);
                                                      if (index != -1) {
                                                        itemWeight =
                                                            itemsKemasanWeights[
                                                                index];
                                                      }
                                                    }
                                                    totalValue +=
                                                        jumlah * itemWeight;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      i != 0
                                          ? IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                setState(() {
                                                  poController.jummlahKemasan[i]
                                                      .clear();
                                                  poController.jummlahKemasan[i]
                                                      .dispose();
                                                  poController.jummlahKemasan
                                                      .removeAt(i);
                                                  selectedKemasanValues
                                                      .removeAt(i);

                                                  // Recalculate total after deletion
                                                  totalValue = 0;
                                                  for (int j = 0;
                                                      j <
                                                          poController
                                                              .jummlahKemasan
                                                              .length;
                                                      j++) {
                                                    int jumlah = int.tryParse(
                                                            poController
                                                                .jummlahKemasan[
                                                                    j]
                                                                .text) ??
                                                        0;
                                                    int itemWeight = 0;
                                                    if (selectedKemasanValues[
                                                            j] !=
                                                        null) {
                                                      int? selectedId =
                                                          int.tryParse(
                                                              selectedKemasanValues[
                                                                  j]!);
                                                      int index =
                                                          itemsKemasanIds
                                                              .indexOf(
                                                                  selectedId!);
                                                      if (index != -1) {
                                                        itemWeight =
                                                            itemsKemasanWeights[
                                                                index];
                                                      }
                                                    }
                                                    totalValue +=
                                                        jumlah * itemWeight;
                                                  }
                                                });
                                              },
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  TextField(
                                    controller: poController.jummlahKemasan[i],
                                    maxLines: null,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Jumlah kemasan'),
                                    onChanged: (value) {
                                      setState(() {
                                        // Recalculate total when the text changes
                                        totalValue = 0;
                                        for (int j = 0;
                                            j <
                                                poController
                                                    .jummlahKemasan.length;
                                            j++) {
                                          int jumlah = int.tryParse(poController
                                                  .jummlahKemasan[j].text) ??
                                              0;
                                          int itemWeight = 0;
                                          if (selectedKemasanValues[j] !=
                                              null) {
                                            int? selectedId = int.tryParse(
                                                selectedKemasanValues[j]!);
                                            int index = itemsKemasanIds
                                                .indexOf(selectedId!);
                                            if (index != -1) {
                                              itemWeight =
                                                  itemsKemasanWeights[index];
                                            }
                                          }
                                          totalValue += jumlah * itemWeight;
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tempo",
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
                                    'Berapa Hari',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: itemsTempo
                                      .map((int itemsTempo) =>
                                          DropdownMenuItem<String>(
                                            value: itemsTempo.toString(),
                                            child: Text(
                                              itemsTempo.toString(),
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
                                    fontFamily:
                                        GoogleFonts.rubik().fontFamily)),
                            SizedBox(
                              height: 10,
                            ),
                            ToggleButtons(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    '%',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    'Rp',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
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
                                            PoController
                                                .diskonController.text));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Total Bayar Dp",
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.rubik()
                                                  .fontFamily)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color:
                                                Colors.black.withOpacity(0.05)),
                                        child: TextField(
                                          inputFormatters: <TextInputFormatter>[
                                            CurrencyTextInputFormatter(
                                              locale: 'id',
                                              decimalDigits: 0,
                                              symbol: 'Rp',
                                            ),
                                          ],
                                          keyboardType: TextInputType.number,
                                          controller:
                                              PoController.jDpController,
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
                                Text(
                                    totalBayar == null
                                        ? ""
                                        : currencyFormatter.format(
                                            int.parse(totalBayar.toString())),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
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
                                printValue();
                                String jumlahDp = getRawValue(
                                    PoController.jDpController.text);
                                String jumlahDiskon =
                                    PoController.diskonController.text;
                                bool PoStore = PoController().store(
                                    customerId,
                                    productId,
                                    totalBayar,
                                    selectedValueTempo,
                                    selectedValueDp,
                                    jumlahDp,
                                    getRawValue(jumlahDiskon),
                                    _currentSelection,
                                    formattedValues,
                                    totalValue);
                                if (PoStore) {
                                  if (poController.jummlahKemasan.isNotEmpty) {
                                    var firstElement =
                                        poController.jummlahKemasan.first;
                                    firstElement.text = '';
                                    poController.jummlahKemasan.clear();
                                    poController.jummlahKemasan
                                        .add(firstElement);
                                  }
                                }
                                formattedValues.clear();
                                // PoController().hitungJumlahBulat(
                                //     int.tryParse(PoController.jumlahConroller.text));
                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return AlertDialog(
                                //       title: Text('Konfirmasi'),
                                //       content: Text(
                                //           'Jumlah Akan Dibulatkan Ke ${PoController.jumlahBulat}?'),
                                //       actions: <Widget>[
                                //         TextButton(
                                //           onPressed: () {
                                //             Navigator.of(context)
                                //                 .pop(false); // Pilihan Tidak
                                //           },
                                //           child: Text('Tidak'),
                                //         ),
                                //         TextButton(
                                //           onPressed: () {

                                //             // Navigator.of(context).pop(true);
                                //             // // Setelah menutup dialog, lakukan tindakan di sini
                                //             // printValue();
                                //             // String jumlahDp = getRawValue(
                                //             //     PoController.jDpController.text);
                                //             // String jumlahDiskon =
                                //             //     PoController.diskonController.text;
                                //             // bool PoStore = PoController().store(
                                //             //   customerId,
                                //             //   productId,
                                //             //   totalBayar,
                                //             //   selectedValueTempo,
                                //             //   selectedValueDp,
                                //             //   jumlahDp,
                                //             //   getRawValue(jumlahDiskon),
                                //             //   _currentSelection,
                                //             //   formattedValues,
                                //             //   totalValue,
                                //             // );

                                //             // if (PoStore) {
                                //             //   if (poController
                                //             //       .jummlahKemasan.isNotEmpty) {
                                //             //     var firstElement =
                                //             //         poController.jummlahKemasan.first;
                                //             //     firstElement.text = '';
                                //             //     poController.jummlahKemasan.clear();
                                //             //     poController.jummlahKemasan
                                //             //         .add(firstElement);
                                //             //   }
                                //             // }
                                //             // formattedValues.clear();
                                //           },
                                //           child: Text('Ya'),
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );
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
            );
          }
        }));
  }
}
