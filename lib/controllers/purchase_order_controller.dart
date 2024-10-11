import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/models/product.dart';
import 'package:pt_sage/models/purchase_order.dart';
import 'package:pt_sage/models/warper.dart';
import 'package:pt_sage/page/dashboard_page.dart';
import 'package:pt_sage/page/list_po_page.dart';
import 'package:pt_sage/providers/purchase_order_provide.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

import '../models/kemasan.dart';
import '../page/home_page.dart';

class PoController extends GetxController {
  static TextEditingController jumlahConroller = TextEditingController();
  static TextEditingController hargaController = TextEditingController();
  static TextEditingController jDpController = TextEditingController(text: '');
  static TextEditingController diskonController = TextEditingController();
  static TextEditingController searchController = TextEditingController();
  RxList<TextEditingController> jummlahKemasan =
      <TextEditingController>[TextEditingController()].obs;
  final isLoading = false.obs;
  final isLoading2 = false.obs;

  String? token = SpUtil.getString('token');
  static int jumlahBulat = 0;

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
      isLoading.value = true;
      final uri = Uri.parse('$PoAPI/kemasan');
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        isLoading.value = false;
        return KemasanList.fromJson(jsonResponse);
      } else {
        isLoading.value = false;
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<DataWrapper?> getProductData() async {
    try {
      isLoading2.value = true;
      final uri = Uri.parse(PoCreateAPI);

      // Menggunakan http.Client untuk streaming data
      var client = http.Client();
      var request = http.Request('GET', uri)
        ..headers['Authorization'] = 'Bearer $token';

      var streamedResponse = await client.send(request);

      // Menggunakan ByteStream untuk membaca respons secara bertahap
      var byteStream = streamedResponse.stream;
      var jsonDecoder = Utf8Decoder().bind(byteStream).transform(json.decoder);

      // Memvalidasi respons JSON
      await for (var chunk in jsonDecoder) {
        try {
          // Validasi JSON chunk
          if (isValidJson(chunk)) {
            // JSON valid, lanjutkan parsing
            Map<String, dynamic> jsonResponse = chunk as Map<String, dynamic>;
            isLoading2.value = false;
            return DataWrapper.fromJson(jsonResponse);
          } else {
            // JSON tidak valid
            print('Invalid JSON format in the chunk.');
            isLoading2.value = false;
            return null;
          }
        } catch (e) {
          // Tangani kesalahan jika terjadi pada bagian tertentu dari respons
          print('Error parsing JSON chunk: $e');
          isLoading2.value = false;
          return null;
        }
      }
    } catch (e) {
      isLoading2.value = false;
      print('Error: ${e.toString()}');
      return null;
    }
  }

// Fungsi untuk memvalidasi JSON
  bool isValidJson(Object? json) {
    try {
      // Coba mengonversi chunk menjadi JSON
      if (json is Map<String, dynamic>) {
        return true; // JSON valid jika bisa di-decode menjadi Map<String, dynamic>
      }
    } catch (e) {
      print('Invalid JSON: $e');
    }
    return false; // JSON tidak valid jika terjadi kesalahan saat parsing
  }

// Fungsi untuk memvalidasi JSON

  // Future<DataWrapper?> getProductData() async {
  //   try {
  //     isLoading2.value = true;
  //     final uri = Uri.parse(PoCreateAPI);

  //     // Menambahkan timeout agar request tidak menunggu terlalu lama
  //     final response = await http.get(
  //       uri,
  //       headers: {'Authorization': 'Bearer $token'},
  //     ).timeout(const Duration(seconds: 15));

  //     // Cek apakah status respons adalah 200 (sukses)
  //     if (response.statusCode == 200) {
  //       // Parsing JSON dengan memisahkan dari logika HTTP
  //       return _parseJson(response.body);
  //     } else {
  //       // Jika status kode tidak 200, tampilkan error
  //       isLoading2.value = false;
  //       print('Failed to load data: ${response.statusCode}');
  //       return null;
  //     }
  //   } on TimeoutException {
  //     // Menangani error jika request timeout
  //     isLoading2.value = false;
  //     print('Request timed out');
  //     return null;
  //   } catch (e) {
  //     // Tangani error lainnya, seperti masalah jaringan
  //     isLoading2.value = false;
  //     print('Error: ${e.toString()}');
  //     return null;
  //   }
  // }

  // String fixIncompleteJson(String jsonString) {
  //   // Cek apakah JSON ditutup dengan benar
  //   if (!jsonString.trim().endsWith(']')) {
  //     print('JSON response is incomplete.');
  //     return jsonString + ']'; // Tambahkan penutup array jika tidak ada
  //   }
  //   return jsonString;
  // }

  // DataWrapper? _parseJson(String responseBody) {
  //   try {
  //     // Memperbaiki JSON jika tidak lengkap
  //     String fixedResponseBody = fixIncompleteJson(responseBody);

  //     // Cek apakah panjang responseBody cukup
  //     if (fixedResponseBody.isEmpty) {
  //       print('Response body is empty');
  //       return null;
  //     }

  //     // Parsing JSON yang telah diperbaiki
  //     final Map<String, dynamic> jsonResponse = jsonDecode(fixedResponseBody);
  //     isLoading2.value = false;
  //     return DataWrapper.fromJson(jsonResponse);
  //   } catch (e) {
  //     // Tangani jika terjadi error parsing
  //     isLoading2.value = false;
  //     print('Error parsing JSON: $e\nResponse: $responseBody');
  //     return null;
  //   }
  // }

  void hitungJumlahBulat(int? jumlah) {
    jumlahBulat = 0;
    if (jumlah! % 5 == 0) {
      jumlahBulat += jumlah;
    } else {
      jumlahBulat += (jumlah / 5).ceil() * 5;
      // Get.snackbar('Pemberitahuan', 'Jumlah Dibulatkan Menjadi ${jumlahBulat}',
      //     backgroundColor: Colors.red, colorText: Colors.white);
      // jumlahConroller.text = jumlahBulat.toString();
    }
  }

  bool store(customers, products, totals, tempos, dps, jumlahDps, diskons,
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
      print(jumlah);
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
            backgroundColor: Color.fromARGB(255, 244, 190, 54),
            colorText: Colors.white);
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
            diskonController.text = '';
            jDpController.text = '';
            Get.offAll(() => const HomePage());
            Get.snackbar('Success', 'Pembelian Berhasil',
                backgroundColor: Color.fromARGB(255, 75, 212, 146),
                colorText: Colors.white);
            jumlahBulat = 0;
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
    return true;
  }
}
