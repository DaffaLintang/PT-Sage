import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:pt_sage/models/kemasan.dart';
import 'package:pt_sage/apiVar.dart' as apiVar;
import 'package:pt_sage/models/payment.dart' as paymentModel;
import 'package:pt_sage/page/dashboard_page.dart';
import 'package:pt_sage/page/list_pengiriman.dart';
import 'package:pt_sage/providers/payment_provider.dart';
import 'package:pt_sage/providers/pengiriman_provider.dart';
import 'package:sp_util/sp_util.dart';
import '../models/kendaraan.dart';
import '../models/lot.dart';
import '../page/home_page.dart';

class PaymentController extends GetxController {
  String? token = SpUtil.getString('token');
  static TextEditingController bayarText = TextEditingController();

  Future<List<paymentModel.Payment>?> getPayment() async {
    try {
      final uri = Uri.parse('${apiVar.PaymentApi}/');
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => paymentModel.Payment.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  void store(bayar, id) {
    String? idPengiriman = id;
    int? JumlahBayar = bayar;

    try {
      if (JumlahBayar == null) {
        Get.snackbar('Error', 'Data Tidak Boleh Kosong',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (JumlahBayar < 999) {
        Get.snackbar('Error', 'Minimum Pembayaran Rp.1.000',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        EasyLoading.show();
        var data = {
          "jumlah_bayar": JumlahBayar,
        };
        PaymentProvider().store(token, data, id).then((value) {
          if (value.statusCode == 200) {
            Get.offAll(() => const HomePage());
            Get.snackbar('Success', 'Pembayaran Berhasil',
                backgroundColor: Color.fromARGB(255, 75, 212, 146),
                colorText: Colors.white);
            bayarText.text = '';
          } else if (value.statusCode == 400) {
            Get.snackbar('Error', 'Pembayaran Melebihi Total Harga',
                backgroundColor: Colors.red, colorText: Colors.white);
          } else {
            Get.snackbar('Error', 'Pembelian Gagal',
                backgroundColor: Colors.red, colorText: Colors.white);
            return false;
          }
          print(data);
          EasyLoading.dismiss();
        });
      }
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }
}
