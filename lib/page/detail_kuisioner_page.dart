import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/kuisioner_controller.dart';
import 'package:pt_sage/models/kuisioner.dart';
import 'package:pt_sage/page/kuisoner_page.dart';
import 'package:sp_util/sp_util.dart';
import '../controllers/purchase_order_controller.dart';
import '../models/warper.dart';
import 'home_page.dart';

class DetailKuisioner extends StatefulWidget {
  @override
  State<DetailKuisioner> createState() => _DetailKuisionerState();
}

class _DetailKuisionerState extends State<DetailKuisioner> {
  SurveyData? surveyData;
  @override
  void initState() {
    super.initState();
    KuisionerController().getDataSurveyKp();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (SpUtil.getInt("roles") != 2) {
        Get.offAll(KuisonerPage());
      }
    });
  }

  void fetchSurveyDataKpKuisioner() async {
    SurveyData? surveyDataKp = await KuisionerController().getDataSurveyKp();
    if (mounted) {
      setState(() {
        surveyData = surveyDataKp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (SpUtil.getInt("roles") != 2) {
      Future.microtask(() => Get.offAll(KuisonerPage()));
    }
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
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => KuisonerPage());
                PoController.hargaController.text = '0';
                PoController.jumlahConroller.text = '1';
              },
              icon: Icon(
                Icons.assignment,
                color: Color(0xffBF1619),
              )),
        ],
      ),
      body: FutureBuilder<SurveyData?>(
        future: KuisionerController().getDataSurveyKp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final surveyData = snapshot.data;

            if (surveyData == null) {
              return Center(child: Text('Tidak ada data tersedia.'));
            }

            return ListView(
              children: [
                ...surveyData.dataPerAspek.map((aspek) {
                  return Card(
                    child: ListTile(
                      title: Text(aspek.aspek,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      subtitle: Text(
                        'Total Respon: ${aspek.totalJawaban}\n'
                        'Jumlah Jawaban: \n ${aspek.countJawaban.one} (1), '
                        '${aspek.countJawaban.two} (2), '
                        '${aspek.countJawaban.three} (3), '
                        '${aspek.countJawaban.four} (4), '
                        '${aspek.countJawaban.five} (5)',
                      ),
                    ),
                  );
                }).toList(),

                // Menampilkan data dari `indeksKepuasan`
                ...surveyData.indeksKepuasan.map((indeks) {
                  return Card(
                    child: ListTile(
                      title: Text(indeks.aspek,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      subtitle: Text(
                        'Indeks Kepuasan: ${indeks.indeksKepuasanAspek}\n'
                        'Presentase: ${indeks.presentase}%',
                      ),
                    ),
                  );
                }).toList(),

                // Menampilkan data dari `totalJawabanAll`
                ListTile(
                  title: Text('Total Jawaban Semua Aspek'),
                  subtitle: Text(
                    '1: ${surveyData.totalJawabanAll.one}\n'
                    '2: ${surveyData.totalJawabanAll.two}\n'
                    '3: ${surveyData.totalJawabanAll.three}\n'
                    '4: ${surveyData.totalJawabanAll.four}\n'
                    '5: ${surveyData.totalJawabanAll.five}',
                  ),
                ),

                // Menampilkan data dari `totalIndeksKeseluruhan`
                ListTile(
                  title: Text('Total Indeks Keseluruhan'),
                  subtitle: Text(
                    '1: ${surveyData.totalIndeksKeseluruhan.one}\n'
                    '2: ${surveyData.totalIndeksKeseluruhan.two}\n'
                    '3: ${surveyData.totalIndeksKeseluruhan.three}\n'
                    '4: ${surveyData.totalIndeksKeseluruhan.four}\n'
                    '5: ${surveyData.totalIndeksKeseluruhan.five}',
                  ),
                ),

                // Menampilkan persentase keseluruhan
                ListTile(
                  title: Text('Total Persentase'),
                  subtitle: Text('${surveyData.totalPercentage}%'),
                ),
              ],
            );
          } else {
            return Center(child: Text('Tidak ada data tersedia.'));
          }
        },
      ),
    );
  }
}
