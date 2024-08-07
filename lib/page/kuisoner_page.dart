import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/kuisioner_controller.dart';
import 'package:pt_sage/models/kuisioner.dart';
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

  @override
  void initState() {
    super.initState();
    fetchKuisioner();
    fetchKuisionerPb();
  }

  @override
  void dispose() {
    // Tidak perlu menghapus controller di sini karena GetX akan mengelola siklus hidup controller
    super.dispose();
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
    print("Posisi Bersaing Values:");
    for (int i = 0; i < _selectedValues1.length; i++) {
      for (int j = 0; j < _selectedValues1[i].length; j++) {
        print(
            "Question ${i + 1}, Sub-question ${j + 1}: ${_selectedValues1[i][j]}");
        print("Catatan: ${kuisionerController.PbCatatanController[i][j].text}");
      }
    }
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
                          horizontal: 20.0,
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
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: List<
                                                                Widget>.generate(
                                                              5,
                                                              (int index) =>
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8.0),
                                                                child:
                                                                    Radio<int>(
                                                                  value:
                                                                      index + 1,
                                                                  groupValue: _selectedValues1[
                                                                          questionIndex]
                                                                      [
                                                                      subQuestionIndex],
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      _selectedValues1[questionIndex]
                                                                              [
                                                                              subQuestionIndex] =
                                                                          value;
                                                                    });
                                                                  },
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
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
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
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: List<
                                                                Widget>.generate(
                                                              5,
                                                              (int index) =>
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8.0),
                                                                child:
                                                                    Radio<int>(
                                                                  value:
                                                                      index + 1,
                                                                  groupValue: _selectedValues[
                                                                          questionIndex]
                                                                      [
                                                                      subQuestionIndex],
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      _selectedValues[questionIndex]
                                                                              [
                                                                              subQuestionIndex] =
                                                                          value;
                                                                    });
                                                                  },
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
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
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
                            borderRadius: BorderRadius.circular(12)),
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
        ],
      ),
    );
  }
}
