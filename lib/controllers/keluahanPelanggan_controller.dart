import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import '../models/keluhanCustomer.dart';
import '../models/purchase_order.dart';
import '../page/dashboard_page.dart';
import '../page/home_page.dart';
import '../providers/keluhan_provider.dart';

class KeluhanPelangganController extends GetxController {
  static TextEditingController keluhanController = TextEditingController();
  static TextEditingController searchController = TextEditingController();
  static TextEditingController searchInvoiceController =
      TextEditingController();
  String? token = SpUtil.getString('token');

  Future<List<KeluhanCustomer>?> getKeluhanCustomer() async {
    try {
      final uri = Uri.parse("${KeluhanApi}/approved-customers");
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        List<KeluhanCustomer> customers = data.map((item) {
          return KeluhanCustomer.fromJson(item as Map<String, dynamic>);
        }).toList();

        return customers;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<List<KeluhanData>?> getKeluhan() async {
    try {
      final uri = Uri.parse("${KeluhanApi}");
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        List<KeluhanData> customers = data.map((item) {
          return KeluhanData.fromJson(item as Map<String, dynamic>);
        }).toList();

        return customers;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  void storeKeluhan(customer, invoice, keluhan) {
    try {
      if (customer == null || invoice == null || keluhan.isEmpty) {
        Get.snackbar('Error', 'Data Tidak Boleh Kosong',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        var data = {
          "customer_id": customer,
          "kode_invoice": invoice,
          "keluhan": keluhan
        };

        KuisionerProvider().storeKeluhan(token, data).then((value) {
          print(value.statusCode);
          if (value.statusCode == 201) {
            KeluhanPelangganController.keluhanController.text = '';
            Get.offAll(() => HomePage());
            Get.snackbar('Success', 'Berhasil Mengirim Keluhan',
                backgroundColor: Color.fromARGB(255, 75, 212, 146),
                colorText: Colors.white);
          } else if (value.statusCode == 400) {
            Get.snackbar('Error', 'Customer Tidak Sesuai Dengan Kode Invoice',
                backgroundColor: Colors.red, colorText: Colors.white);
          } else {
            Get.snackbar('Error', 'Gagal Mengirim Keluhan',
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
