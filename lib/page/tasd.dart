import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

class KuisonerPage extends StatefulWidget {
  @override
  State<KuisonerPage> createState() => _KuisonerPageState();
}

class _KuisonerPageState extends State<KuisonerPage> {
  int _currentSelection = 0;

  List<List<int?>> _selectedValues = List.generate(
      4,
      (index) => List.generate(
          5, (index) => null)); // 4 questions each with 5 sub questions
  List<List<int?>> _selectedValues1 = List.generate(
      4,
      (index) => List.generate(
          5, (index) => null)); // 4 questions each with 5 sub questions

  void printSelectedValues() {
    for (int i = 0; i < _selectedValues.length; i++) {
      for (int j = 0; j < _selectedValues[i].length; j++) {
        print(
            'Pertanyaan ${i + 1}, Sub Pertanyaan ${j + 1}: ${_selectedValues[i][j]}');
      }
    }
  }

  void printSelectedValues1() {
    for (int i = 0; i < _selectedValues1.length; i++) {
      for (int j = 0; j < _selectedValues1[i].length; j++) {
        print(
            'Pertanyaan ${i + 1}, Sub Pertanyaan ${j + 1}: ${_selectedValues1[i][j]}');
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
      body: Center(
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Posisi Bersaing',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                                  width: 2.0, color: const Color(0xffBF1619)),
                              borderRadius: BorderRadius.circular(12)),
                          height: 430,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 4, // Number of questions
                            itemBuilder: (context, questionIndex) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Judul Pertanyaan ${questionIndex + 1}",
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
                                              5, // Number of sub questions
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (context, subQuestionIndex) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Color(0xffBF1619))),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Sub Pertanyaan ${subQuestionIndex + 1}',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Row(
                                                    children: List.generate(5,
                                                        (innerIndex) {
                                                      int value =
                                                          innerIndex + 1;
                                                      return Expanded(
                                                        child: Row(
                                                          children: [
                                                            Radio<int>(
                                                              value: value,
                                                              groupValue: _selectedValues1[
                                                                      questionIndex]
                                                                  [
                                                                  subQuestionIndex],
                                                              onChanged: (int?
                                                                  newValue1) {
                                                                setState(() {
                                                                  _selectedValues1[
                                                                              questionIndex]
                                                                          [
                                                                          subQuestionIndex] =
                                                                      newValue1;
                                                                });
                                                              },
                                                              materialTapTargetSize:
                                                                  MaterialTapTargetSize
                                                                      .shrinkWrap,
                                                            ),
                                                            Text(
                                                                '$value'), // Teks angka di samping radio button
                                                          ],
                                                        ),
                                                      );
                                                    }),
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
                                  printSelectedValues1();
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
                                  width: 2.0, color: const Color(0xffBF1619)),
                              borderRadius: BorderRadius.circular(12)),
                          height: 430,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 4, // Number of questions
                            itemBuilder: (context, questionIndex) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Judul Pertanyaan ${questionIndex + 1}",
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
                                              5, // Number of sub questions
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (context, subQuestionIndex) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Color(0xffBF1619))),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Sub Pertanyaan ${subQuestionIndex + 1}',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                  printSelectedValues();
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
      ),
    );
  }
}
