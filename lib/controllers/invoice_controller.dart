import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pdf/widgets.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/models/invoice.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class InvoiceController extends GetxController {
  String? token = SpUtil.getString('token');
  var isLoading = false.obs;

  Future<List<Invoice>?> fetchInvoices() async {
    try {
      final uri = Uri.parse(InvoiceApi);
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> invoicesJson = jsonResponse['data'];
        // print(invoicesJson);
        return invoicesJson.map((json) => Invoice.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<void> submitForm(
      File buktiBayar, File buktiKirim, String InvId) async {
    isLoading(true);

    var url = Uri.parse("${InvoiceApi}/upload/${InvId}");
    var request = http.MultipartRequest('POST', url);
    var stream1 = http.ByteStream(buktiBayar.openRead());
    var length1 = await buktiBayar.length();
    var multipartFile1 = http.MultipartFile(
      'bukti_bayar',
      stream1,
      length1,
      filename: basename(buktiBayar.path),
    );

    var stream2 = http.ByteStream(buktiKirim.openRead());
    var length2 = await buktiKirim.length();
    var multipartFile2 = http.MultipartFile(
      'bukti_kirim',
      stream2,
      length2,
      filename: basename(buktiKirim.path),
    );

    request.files.add(multipartFile1);
    request.files.add(multipartFile2);

    try {
      if (buktiBayar != null || buktiKirim != null) {
        var response = await request.send();
        print(response.statusCode);
        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          // var decodedResponse = jsonDecode(responseData);
          Get.snackbar('Success', 'Upload Bukti Berhasil',
              backgroundColor: Color.fromARGB(255, 75, 212, 146),
              colorText: Colors.white);
        } else {
          // print('Failed: ${response.statusCode}');
          Get.snackbar('Error', 'Uploud Gagal',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar('Error', 'Bukti Belum Di Upload',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
