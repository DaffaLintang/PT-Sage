import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/models/kuisioner.dart';
import 'package:http/http.dart' as http;

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
        print(jsonResponse);
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
        print(jsonResponse);
        return KuisionerPbList.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  // void store() {
  //   int? product = products;
  //   int? jumlah = int.tryParse(jumlahConroller.text);

  //   try {
  //     if (customer == null ||
  //         product == null ||
  //         jumlah == null ||
  //         jumlah < 1 ||
  //         totalHarga == null ||
  //         tempo == null ||
  //         tempo.isEmpty ||
  //         dp == null ||
  //         dp.isEmpty) {
  //       // print(jumlahDp);
  //       Get.snackbar('Error', 'Data Tidak Boleh Kosong',
  //           backgroundColor: Colors.red, colorText: Colors.white);
  //     } else {
  //       EasyLoading.show();
  //       var data = {
  //         "customers": customer,
  //         "product": product,
  //         "jumlah": jumlah,
  //         "total_harga": totalHarga,
  //         "tempo": tempo,
  //         "dp": dp,
  //         "jumlah_dp": jumlahDp
  //       };
  //       PoProvider().store(token, data).then((value) {
  //         print(value.statusCode);
  //         if (value.statusCode == 201) {
  //           Get.offAll(() => listPoPage());
  //           Get.snackbar('Success', 'Pembelian Berhasil',
  //               backgroundColor: Color.fromARGB(255, 75, 212, 146),
  //               colorText: Colors.white);
  //         } else {
  //           Get.snackbar('Error', 'Pembelian Gagal',
  //               backgroundColor: Colors.red, colorText: Colors.white);
  //         }
  //         EasyLoading.dismiss();
  //       });
  //     }
  //   } catch (e, stackTrace) {
  //     print('Exception occurred: $e\n$stackTrace');
  //   }
  // }
}
