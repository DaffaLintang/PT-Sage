import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pt_sage/apiVar.dart' as apiVar;
import 'package:pt_sage/models/payment.dart' as paymentModel;
import 'package:pt_sage/providers/payment_provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:path/path.dart';
import '../models/detailPayment.dart';
import '../page/home_page.dart';

import 'dart:io';

class PaymentController extends GetxController {
  String? token = SpUtil.getString('token');
  static TextEditingController bayarText = TextEditingController();

  Future<List<paymentModel.Payment>?> getPayment() async {
    try {
      final uri = Uri.parse('${apiVar.PaymentApi}');
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

  Future<List<DetailPayment>?> getDetailPayment(id) async {
    try {
      final uri = Uri.parse('${apiVar.PaymentApi}/$id');
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => DetailPayment.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  void store(bayar, id, buktiBayar) async {
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

        // Membuat request multipart
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${apiVar.PaymentApi}/store/$idPengiriman'),
        );

        request.headers['Authorization'] = 'Bearer $token';
        request.fields['jumlah_bayar'] = JumlahBayar.toString();

        // Tambahkan file bukti bayar
        if (buktiBayar != null) {
          print("Adding file: ${buktiBayar.path}");
          var stream = http.ByteStream(buktiBayar.openRead());
          var length = await buktiBayar.length();

          var multipartFile = http.MultipartFile(
            'bukti_bayar',
            stream,
            length,
            filename: basename(buktiBayar.path),
          );
          request.files.add(multipartFile);
        } else {
          print("buktiBayar is null");
        }

        var response = await request.send();

        if (response.statusCode == 200) {
          Get.offAll(() => const HomePage());
          Get.snackbar('Success', 'Pembayaran Berhasil',
              backgroundColor: Color.fromARGB(255, 75, 212, 146),
              colorText: Colors.white);
        } else if (response.statusCode == 400) {
          Get.snackbar('Error', 'Pembayaran Melebihi Total Harga',
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          print('Response status: ${response.statusCode}');
          print('Response body: ${await response.stream.bytesToString()}');
          Get.snackbar('Error', 'Pembayaran Gagal',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      }
    } catch (e, stackTrace) {
      EasyLoading.dismiss();
      print('Exception occurred: $e\n$stackTrace');
      Get.snackbar('Error', 'Terjadi Kesalahan',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
