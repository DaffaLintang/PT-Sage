import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/kuisioner_controller.dart';
import 'package:pt_sage/models/customer.dart';
import 'package:pt_sage/models/kuisioner.dart';
import '../controllers/purchase_order_controller.dart';
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
  CompetitorResponse? competitorResponse;
  late List<CustomersPb> customersPb;
  late List<CustomersKp> customersKp;
  List<List<int?>> _selectedValues = [];
  List<List<int?>> _selectedValues1 = [];
  String? selectedValue;
  String? selectedValuePb;
  String? selectedValueKp;
  List<List<String?>> selectedValueKompetitor = [];
  final Map<String, int> customertMap = {};
  final Map<String, int> customertMapPb = {};
  final Map<String, int> customertMapKp = {};
  final Map<String, int> competitorMap = {};
  final List<String> itemCompetitor = [];
  final List<String> itemsCustomer = [];
  final List<String> itemsCustomerPb = [];
  final List<String> itemsCustomerKp = [];
  int? customerId;
  int? competitorId;

  get items => null;

  @override
  void initState() {
    super.initState();
    fetchKuisioner();
    fetchKuisionerPb();
    loadCustomersKp();
    loadCustomersPb();
    getCompetitors();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchCustomer() async {
    EasyLoading.show();
    final poController = PoController();
    DataWrapper? dataWrapper = await poController.getProductData();
    if (mounted) {
      setState(() {
        dataWrapper?.customers.forEach((customer) {
          itemsCustomer.add(customer.customersName);
          customertMap[customer.customersName] = customer.id;
        });
      });
    }
    EasyLoading.dismiss();
  }

  void fetchKuisioner() async {
    EasyLoading.show();
    KuisionerKpList? fetchedOrders =
        await kuisionerController.getKepuasanPelangan();
    if (mounted) {
      setState(() {
        kuisionerKpList = fetchedOrders;
        if (kuisionerKpList != null) {
          _initializeSelectedValues();
        }
      });
    }
    EasyLoading.dismiss();
  }

  void getCompetitors() async {
    EasyLoading.show();
    try {
      CompetitorResponse? getCompetitor =
          await kuisionerController.fetchCompetitors();
      if (mounted) {
        setState(() {
          competitorResponse = getCompetitor;
          getCompetitor?.data.forEach((competitor) {
            itemCompetitor.add(competitor.name);
            competitorMap[competitor.name] = competitor.id;
          });
          if (kuisionerPbList != null) {
            selectedValueKompetitor = List<List<String?>>.generate(
              kuisionerPbList!.kuisionerList.length,
              (index) => List<String?>.generate(
                kuisionerPbList!.kuisionerList[index].subKuisioner.length,
                (subIndex) => null,
              ),
            );
          }
        });
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void loadCustomersPb() async {
    // EasyLoading.show();
    try {
      List<CustomersPb> customers =
          await kuisionerController.getPosisiBersaingCs();
      customers.forEach((customer) {
        itemsCustomerPb.add(customer.customersName);
        customertMapPb[customer.customersName] = customer.id;
      });
    } catch (e) {
      print(e);
    } finally {
      // EasyLoading.dismiss();
    }
  }

  void loadCustomersKp() async {
    // EasyLoading.show();
    try {
      List<CustomersKp> customers =
          await kuisionerController.getKepuasanPelangganCs();
      customers.forEach((customer) {
        itemsCustomerKp.add(customer.customersName);
        customertMapKp[customer.customersName] = customer.id;
      });
    } catch (e) {
      print(e);
    } finally {
      // EasyLoading.dismiss();
    }
  }

  void fetchKuisionerPb() async {
    EasyLoading.show();
    KuisionerPbList? fetchedOrders =
        await kuisionerController.getPosisiBersaing();
    if (mounted) {
      setState(() {
        kuisionerPbList = fetchedOrders;
        if (kuisionerPbList != null) {
          _initializeSelectedValuesPb();
        }
      });
    }
    EasyLoading.dismiss();
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

  KpData printKpValues() {
    List<int> subKuisionerId = [];
    List<String> selectedValue = [];

    for (int z = 0; z < kuisionerKpList!.kuisionerList.length; z++) {
      for (int n = 0;
          n < kuisionerKpList!.kuisionerList[z].subKuisioner.length;
          n++) {
        subKuisionerId
            .add(kuisionerKpList!.kuisionerList[z].subKuisioner[n].id);
      }
    }
    for (int i = 0; i < _selectedValues.length; i++) {
      for (int j = 0; j < _selectedValues[i].length; j++) {
        selectedValue.add(_selectedValues[i][j].toString());
      }
    }
    return KpData(subKuisionerId, selectedValue);
  }

  PbData printPbValue() {
    List<int> subKuisionerId = [];
    List<String> selectedValue = [];
    List<String> catatanValue = [];

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

  Map<String, int> processKpJawaban(KpData kpData) {
    Map<String, int> jawaban = {};
    for (int i = 0; i < kpData.subKuisionerIds.length; i++) {
      try {
        int value = int.parse(kpData.selectedValues[i]);
        jawaban[kpData.subKuisionerIds[i].toString()] = value;
      } catch (e) {
        print("Gagal mengubah nilai ke integer: $e");
      }
    }
    return jawaban;
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
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
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
                                  items: itemsCustomerPb
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
                                          customertMapPb[selectedValue!];
                                      print(customerId);
                                    });
                                  },
                                ),
                              ),
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
                                          SizedBox(height: 5),
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
                                                // Verify that the index is within bounds
                                                if (subQuestionIndex >=
                                                    selectedValueKompetitor[
                                                            questionIndex]
                                                        .length) {
                                                  return Container(); // or handle as appropriate
                                                }
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
                                                        color:
                                                            Color(0xffBF1619)),
                                                  ),
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
                                                      SizedBox(height: 5),
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
                                                      DropdownButtonHideUnderline(
                                                        child: DropdownButton2<
                                                            String>(
                                                          isExpanded: true,
                                                          hint: Text(
                                                            'Pilih Kompetitor',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor,
                                                            ),
                                                          ),
                                                          items: itemCompetitor
                                                              .map((String
                                                                  competitor) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: competitor,
                                                              child: Text(
                                                                  competitor),
                                                            );
                                                          }).toList(),
                                                          value: selectedValueKompetitor[
                                                                  questionIndex]
                                                              [
                                                              subQuestionIndex],
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              selectedValueKompetitor[
                                                                      questionIndex]
                                                                  [
                                                                  subQuestionIndex] = value;
                                                              competitorId = competitorMap[
                                                                  selectedValueKompetitor[
                                                                          questionIndex]
                                                                      [
                                                                      subQuestionIndex]!];
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      selectedValueKompetitor[
                                                                      questionIndex]
                                                                  [
                                                                  subQuestionIndex] !=
                                                              null
                                                          ? Row(
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
                                                                          padding:
                                                                              const EdgeInsets.only(right: 0.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Radio<int>(
                                                                                value: index + 1,
                                                                                groupValue: _selectedValues1[questionIndex][subQuestionIndex],
                                                                                onChanged: (value) {
                                                                                  setState(() {
                                                                                    _selectedValues1[questionIndex][subQuestionIndex] = value;
                                                                                  });
                                                                                },
                                                                              ),
                                                                              Text('${index + 1}'),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : SizedBox()
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
                                    var result = printPbValue();
                                    var jawaban = processJawaban(result);
                                    var catatan = processCatatan(result);

                                    KuisionerController()
                                        .storePb(customerId, jawaban, catatan);
                                    print(customerId);
                                    print(jawaban);
                                    print(catatan);
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
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
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
                                  items: itemsCustomerKp
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
                                  value: selectedValueKp,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValueKp = value;
                                      customerId =
                                          customertMapKp[selectedValueKp!];
                                    });
                                  },
                                ),
                              ),
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
                                    var result = printKpValues();
                                    var jawaban = processKpJawaban(result);

                                    // KuisionerController()
                                    //     .storePb(customerId, jawaban, catatan);
                                    KuisionerController()
                                        .storeKp(customerId, jawaban);
                                    print(jawaban);
                                    print(customerId);
                                    print(selectedValueKp);
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
