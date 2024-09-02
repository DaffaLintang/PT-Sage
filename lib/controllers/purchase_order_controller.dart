import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/models/product.dart';
import 'package:pt_sage/models/purchase_order.dart';
import 'package:pt_sage/models/warper.dart';
import 'package:pt_sage/page/list_po_page.dart';
import 'package:pt_sage/providers/purchase_order_provide.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

import '../models/kemasan.dart';

class PoController extends GetxController {
  static TextEditingController jumlahConroller = TextEditingController();
  static TextEditingController hargaController = TextEditingController();
  static TextEditingController jDpController = TextEditingController(text: '');
  static TextEditingController diskonController = TextEditingController();
  List<TextEditingController> jummlahKemasan = [TextEditingController()];
  static TextEditingController dateController = TextEditingController();
  String? token = SpUtil.getString('token');

  Future<PurchaseOrderList?> getPoData() async {
    try {
      final uri = Uri.parse(PoAPI);
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return PurchaseOrderList.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<KemasanList?> getKemasan() async {
    try {
      final uri = Uri.parse('$PoAPI/kemasan');
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return KemasanList.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<DataWrapper?> getProductData() async {
    try {
      final uri = Uri.parse(PoCreateAPI);
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return DataWrapper.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  void store(customers, products, totals, tempos, dps, jumlahDps, diskons,
      diskonTypes, kemasans, quantity) {
    int? customer = customers;
    int? product = products;
    int? jumlah = int.tryParse(jumlahConroller.text);
    String? totalHarga = totals;
    String? tempo = tempos;
    String? dp = dps;
    String? jumlahDp = jumlahDps;
    String? diskon = diskons;
    String? diskonType;
    int? quantitys = quantity;
    switch (diskonTypes) {
      case 0:
        diskonType = "persen";
        break;
      case 1:
        diskonType = "nominal";
        break;
      default:
        diskonType = "-";
    }
    try {
      if (customer == null ||
          product == null ||
          jumlah == null ||
          jumlah < 1 ||
          totalHarga == null ||
          tempo == null ||
          tempo.isEmpty ||
          dp == null ||
          dp.isEmpty ||
          kemasans!.length < 0) {
        Get.snackbar('Error', 'Data Tidak Boleh Kosong',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (quantitys! != jumlah) {
        Get.snackbar('Error', 'Quantity melebihi/kurang dari jumlah produk',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        EasyLoading.show();
        var data = {
          "customers": customer,
          "product": product,
          "jumlah": jumlah,
          "total_harga": totalHarga,
          "tempo": tempo,
          "dp": dp,
          "jumlah_dp": jumlahDp,
          "diskon": diskon,
          "diskon_type": diskonType,
          "kemasan": kemasans,
        };
        PoProvider().store(token, data).then((value) {
          if (value.statusCode == 201) {
            if (jummlahKemasan.isNotEmpty) {
              var firstElement = jummlahKemasan.first;
              firstElement.text = '';
              jummlahKemasan.clear();
              jummlahKemasan.add(firstElement);
            }
            diskonController.text = '';
            jDpController.text = '';
            Get.offAll(() => listPoPage());
            Get.snackbar('Success', 'Pembelian Berhasil',
                backgroundColor: Color.fromARGB(255, 75, 212, 146),
                colorText: Colors.white);
          } else {
            Get.snackbar('Error', 'Pembelian Gagal',
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
