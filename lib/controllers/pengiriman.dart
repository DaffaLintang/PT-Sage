import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:http/http.dart' as http;
import 'package:pt_sage/models/kemasan.dart';
import 'package:pt_sage/page/dashboard_page.dart';
import 'package:pt_sage/page/list_pengiriman.dart';
import 'package:pt_sage/providers/pengiriman_provider.dart';
import 'package:sp_util/sp_util.dart';
import '../models/kendaraan.dart';
import '../models/lot.dart';
import '../page/home_page.dart';

class PengirimanController extends GetxController {
  static TextEditingController dateController = TextEditingController();
  static TextEditingController kendaraanController = TextEditingController();
  static TextEditingController supirController = TextEditingController();
  static TextEditingController noPolController = TextEditingController();
  static TextEditingController customerController = TextEditingController();

  String? token = SpUtil.getString('token');

  Future<List<ProductLot>?> getProductLotData() async {
    try {
      final uri = Uri.parse('$Delivery/productLot');
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON list into a list of ProductLot objects
        return jsonResponse.map((json) => ProductLot.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<List<Kendaraan>?> getKendaraan() async {
    try {
      final uri = Uri.parse('$Delivery/kendaraan');
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final jsonResponse =
            jsonDecode(response.body); // Decode the full response

        List<dynamic> kendaraanList =
            jsonResponse['data']; // Access the 'data' field
        return kendaraanList.map((json) => Kendaraan.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  void store(poId, customer, int? kendaraan, namaSupir, NoPol, tanggal, lot,
      Kemasan, jumlahLot, totalQuantity) {
    final endpoint = '$Delivery/store/$poId';
    num totalLotTersedia = 0;
    try {
      if (namaSupir.isEmpty && NoPol.isEmpty) {
        Get.snackbar('Error', 'Data Tidak Boleh Kosong',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        // EasyLoading.show();
        var data = {
          "customer_id": customer,
          "kendaraan_id": kendaraan,
          "nama_sopir": namaSupir,
          "tanggal_pengiriman": tanggal,
          "product_lot": lot,
          "kemasan": Kemasan
        };

        for (int i = 0; i < jumlahLot.length; i++) {
          totalLotTersedia += jumlahLot[i];
        }
        if (totalLotTersedia >= totalQuantity) {
          PengirimanProvider().store(data, endpoint).then((value) {
            if (value.statusCode == 200) {
              PengirimanController.kendaraanController.text = '';
              PengirimanController.noPolController.text = '';
              PengirimanController.supirController.text = '';
              Get.offAll(() => HomePage());
              Get.snackbar('Success', 'Pengiriman Berhasil',
                  backgroundColor: Color.fromARGB(255, 75, 212, 146),
                  colorText: Colors.white);
            } else {
              Get.snackbar('Error', 'Pembelian Gagal',
                  backgroundColor: Colors.red, colorText: Colors.white);
            }
            EasyLoading.dismiss();
          });
        } else {
          Get.snackbar('Error', 'Jumlah Lot Kurang',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }
}
