import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/models/customer.dart';
import 'package:pt_sage/models/kuisioner.dart';
import 'package:http/http.dart' as http;
import 'package:pt_sage/page/kuisoner_page.dart';
import '../providers/kuisioner_provider.dart';

class KuisionerController extends GetxController {
  List<List<TextEditingController>> PbCatatanController = [];

  void initializeControllers(int questionCount, int subQuestionCount) {
    PbCatatanController = List.generate(
      questionCount,
      (index) =>
          List.generate(subQuestionCount, (index) => TextEditingController()),
    );
  }

  @override
  void onClose() {
    for (var subControllers in PbCatatanController) {
      for (var controller in subControllers) {
        controller.dispose();
      }
    }
    super.onClose();
  }

  Future<KuisionerKpList?> getKepuasanPelangan() async {
    try {
      final uri = Uri.parse(KuisionerKepuasanPelangganApi);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return KuisionerKpList.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<KuisionerPbList?> getPosisiBersaing() async {
    try {
      final uri = Uri.parse(KuisionerPosisiBersaingApi);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return KuisionerPbList.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<CompetitorResponse?> fetchCompetitors() async {
    final url = Uri.parse('$PosisiBersaing/getCompetitor');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return CompetitorResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load competitors');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<CustomersPb>> getPosisiBersaingCs() async {
    final response = await http.get(Uri.parse("$PosisiBersaing/getCS"));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['customers'];
      return jsonResponse.map((data) => CustomersPb.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }

  Future<List<CustomersKp>> getKepuasanPelangganCs() async {
    final response = await http.get(Uri.parse("$KepuasanPelanggan/getCS"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)['customers'];
      return jsonResponse.map((data) => CustomersKp.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }

  Future<SurveyData?> getDataSurveyKp() async {
    try {
      final uri = Uri.parse(IndeksAspek);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return SurveyData.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  void storePb(customerId, jawaban, pesaing, jawabanPesaing) {
    int? customer = customerId;
    try {
      if (customer == null || jawaban.isEmpty) {
        // print(jumlahDp);
        Get.snackbar('Error', 'Data Tidak Boleh Kosong',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        EasyLoading.show();
        var data = {
          "customer_id": customerId,
          "jawaban": jawaban,
          "pesaing": pesaing,
          "jawaban_pesaing": jawabanPesaing,
        };
        KuisionerProvider().storePb(data).then((value) {
          print(value.statusCode);
          print(data);
          if (value.statusCode == 200) {
            Get.snackbar('Success', 'Jawaban Berhasil Dismpan',
                backgroundColor: Color.fromARGB(255, 75, 212, 146),
                colorText: Colors.white);
            Get.offAll(() => KuisonerPage(key: UniqueKey()));
          } else {
            Get.snackbar('Error', 'Terjadi lesalahan',
                backgroundColor: Colors.red, colorText: Colors.white);
          }
          EasyLoading.dismiss();
        });
      }
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }

  void storeKp(customerId, jawaban) {
    int? customer = customerId;

    try {
      if (customer == null || jawaban.isEmpty || jawaban.length < 26) {
        Get.snackbar('Error', 'Data Tidak Boleh Kosong',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        EasyLoading.show();
        var data = {
          "customer_id": customerId,
          "jawaban": jawaban,
        };
        KuisionerProvider().storePb(data).then((value) {
          print(value.statusCode);
          print(data);

          if (value.statusCode == 200) {
            Get.snackbar('Success', 'Jawaban Berhasil Dismpan',
                backgroundColor: Color.fromARGB(255, 75, 212, 146),
                colorText: Colors.white);
            Get.offAll(() => KuisonerPage());
          } else {
            Get.snackbar('Error', 'Terjadi lesalahan',
                backgroundColor: Colors.red, colorText: Colors.white);
          }
          EasyLoading.dismiss();
        });
      }
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }
}
