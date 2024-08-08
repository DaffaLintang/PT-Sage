import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/kuisioner_controller.dart';
import 'package:pt_sage/models/kuisioner.dart';
import '../controllers/purchase_order_controller.dart';
import '../models/pbData.dart';
import '../models/warper.dart';
import 'home_page.dart';

class KuisonerPage extends StatefulWidget {
  @override
  State<KuisonerPage> createState() => _KuisonerPageState();
}

class _KuisonerPageState extends State<KuisonerPage> {
  final KuisionerController kuisionerController =
      Get.put(KuisionerController());
  int _currentSelection = 0;

  KuisionerKpList? kuisionerKpList;
  KuisionerPbList? kuisionerPbList;
  List<List<int?>> _selectedValues = [];
  List<List<int?>> _selectedValues1 = [];
  String? selectedValue;
  final Map<String, int> customertMap = {};
  final List<String> itemsCustomer = [];
  int? customerId;

  get items => null;

  @override
  void initState() {
    super.initState();
    fetchKuisioner();
    fetchKuisionerPb();
    fetchCustomer();
  }

  @override
  void dispose() {
    // Tidak perlu menghapus controller di sini karena GetX akan mengelola siklus hidup controller
    super.dispose();
  }

  void fetchCustomer() async {
    final poController = PoController();
    DataWrapper? dataWrapper = await poController.getProductData();
    setState(() {
      dataWrapper?.customers.forEach((customer) {
        itemsCustomer.add(customer.customersName);
        customertMap[customer.customersName] = customer.id;
      });
    });
  }

  void fetchKuisioner() async {
    KuisionerKpList? fetchedOrders =
        await kuisionerController.getKepuasanPelangan();
    setState(() {
      kuisionerKpList = fetchedOrders;
      if (kuisionerKpList != null) {
        _initializeSelectedValues();
      }
    });
  }

  void fetchKuisionerPb() async {
    KuisionerPbList? fetchedOrders =
        await kuisionerController.getPosisiBersaing();
    setState(() {
      kuisionerPbList = fetchedOrders;
      if (kuisionerPbList != null) {
        _initializeSelectedValuesPb();
      }
    });
  }

  void _initializeSelectedValuesPb() {
    if (kuisionerPbList != null) {
      _selectedValues1 = List.generate(
        kuisionerPbList!.kuisionerList.length,
        (index) => List<int?>.filled(
            kuisionerPbList!.kuisionerList[index].subKuisioner.length, null),
      );

      kuisionerController.PbCatatanController = List.generate(
        kuisionerPbList!.kuisionerList.length,
        (index) => List<TextEditingController>.generate(
          kuisionerPbList!.kuisionerList[index].subKuisioner.length,
          (subIndex) => TextEditingController(),
        ),
      );
    }
  }

  void _initializeSelectedValues() {
    if (kuisionerKpList != null) {
      _selectedValues = List.generate(
        kuisionerKpList!.kuisionerList.length,
        (index) => List<int?>.filled(
          kuisionerKpList!.kuisionerList[index].subKuisioner.length,
          null,
        ),
      );
    }
  }

  void printAllValues() {
    // Print values for Kepuasan Pelanggan
    print("Kepuasan Pelanggan Values:");
    for (int i = 0; i < _selectedValues.length; i++) {
      for (int j = 0; j < _selectedValues[i].length; j++) {
        print(
            "Question ${i + 1}, Sub-question ${j + 1}: ${_selectedValues[i][j]}");
      }
    }

    // Print values for Posisi Bersaing
  }

  PbData printPbValue() {
    List<int> subKuisionerId = [];
    List<String> selectedValue = [];
    List<String> catatanValue = [];
    var data = {};

    for (int z = 0;
        z < kuisionerPbList!.kuisionerList[0].subKuisioner.length;
        z++) {
      subKuisionerId.add(kuisionerPbList!.kuisionerList[0].subKuisioner[z].id);
    }
    for (int i = 0; i < _selectedValues1.length; i++) {
      for (int j = 0; j < _selectedValues1[i].length; j++) {
        selectedValue.add(_selectedValues1[i][j].toString());
        catatanValue.add(kuisionerController.PbCatatanController[i][j].text);
      }
    }

    return PbData(subKuisionerId, selectedValue, catatanValue);
  }

  Map<String, int> processJawaban(PbData pbData) {
    Map<String, int> jawaban = {};
    for (int i = 0; i < pbData.subKuisionerIds.length; i++) {
      try {
        int value = int.parse(pbData.selectedValues[i]);
        jawaban[pbData.subKuisionerIds[i].toString()] = value;
      } catch (e) {
        print("Gagal mengubah nilai ke integer: $e");
      }
    }
    return jawaban;
  }

  Map<String, String> processCatatan(PbData pbData) {
    Map<String, String> catatan = {};
    for (int i = 0; i < pbData.subKuisionerIds.length; i++) {
      catatan[pbData.subKuisionerIds[i].toString()] = pbData.catatanValues[i];
    }
    return catatan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kuisoner",
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
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                      items: itemsCustomer
                          .map(
                              (String customerName) => DropdownMenuItem<String>(
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
                ToggleButtons(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Kepuasan Pelanggan',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Posisi Bersaing',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                  isSelected:
                      List.generate(2, (index) => index == _currentSelection),
                  onPressed: (int newIndex) {
                    setState(() {
                      _currentSelection = newIndex;
                    });
                  },
                  selectedColor: Colors.white,
                  fillColor: Color(0xffBF1619),
                  borderColor: Color(0xffBF1619),
                  borderRadius: BorderRadius.circular(12),
                  borderWidth: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                _currentSelection == 1
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Kuisioner Posisi Bersaing',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.0,
                                      color: const Color(0xffBF1619)),
                                  borderRadius: BorderRadius.circular(12)),
                              height: 430,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    kuisionerPbList?.kuisionerList.length ?? 0,
                                itemBuilder: (context, questionIndex) {
                                  if (kuisionerPbList == null ||
                                      questionIndex >=
                                          kuisionerPbList!
                                              .kuisionerList.length) {
                                    return Container();
                                  }
                                  var question = kuisionerPbList!
                                      .kuisionerList[questionIndex];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            question.pertanyaan,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: ListView.builder(
                                              itemCount:
                                                  question.subKuisioner.length,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (context, subQuestionIndex) {
                                                var subQuestion =
                                                    question.subKuisioner[
                                                        subQuestionIndex];
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xffBF1619))),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        subQuestion
                                                            .subPertanyaan,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Flexible(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: List<
                                                                  Widget>.generate(
                                                                5,
                                                                (int index) =>
                                                                    Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            0.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Radio<
                                                                            int>(
                                                                          value:
                                                                              index + 1,
                                                                          groupValue:
                                                                              _selectedValues1[questionIndex][subQuestionIndex],
                                                                          onChanged:
                                                                              (value) {
                                                                            setState(() {
                                                                              _selectedValues1[questionIndex][subQuestionIndex] = value;
                                                                            });
                                                                          },
                                                                        ),
                                                                        Text(
                                                                            '${index + 1}'),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      TextField(
                                                        controller: kuisionerController
                                                                    .PbCatatanController[
                                                                questionIndex]
                                                            [subQuestionIndex],
                                                        maxLines: null,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Catatan Tambahan',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  child: Text('Kirim'),
                                  onPressed: () {
                                    var result = printPbValue();
                                    var jawaban = processJawaban(result);
                                    var catatan = processCatatan(result);

                                    KuisionerController()
                                        .store(customerId, jawaban, catatan);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    primary: Color(0xffBF1619),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Kuisioner Kepuasan Pelanggan',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.0,
                                      color: const Color(0xffBF1619)),
                                  borderRadius: BorderRadius.circular(12)),
                              height: 430,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    kuisionerKpList?.kuisionerList.length ?? 0,
                                itemBuilder: (context, questionIndex) {
                                  if (kuisionerKpList == null ||
                                      questionIndex >=
                                          kuisionerKpList!
                                              .kuisionerList.length) {
                                    return Container();
                                  }
                                  var question = kuisionerKpList!
                                      .kuisionerList[questionIndex];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            question.pertanyaan,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: ListView.builder(
                                              itemCount:
                                                  question.subKuisioner.length,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (context, subQuestionIndex) {
                                                var subQuestion =
                                                    question.subKuisioner[
                                                        subQuestionIndex];
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xffBF1619))),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        subQuestion
                                                            .subPertanyaan,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Flexible(
                                                            child: Row(
                                                              children: List<
                                                                  Widget>.generate(
                                                                5,
                                                                (int index) =>
                                                                    Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            0.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Radio<
                                                                            int>(
                                                                          value:
                                                                              index + 1,
                                                                          groupValue:
                                                                              _selectedValues[questionIndex][subQuestionIndex],
                                                                          onChanged:
                                                                              (value) {
                                                                            setState(() {
                                                                              _selectedValues[questionIndex][subQuestionIndex] = value;
                                                                            });
                                                                          },
                                                                        ),
                                                                        Text(
                                                                            '${index + 1}'),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  child: Text('Kirim'),
                                  onPressed: () {
                                    printAllValues();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    primary: Color(0xffBF1619),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
