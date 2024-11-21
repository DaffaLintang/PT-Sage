import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/models/product.dart';
import 'package:pt_sage/models/purchase_order.dart';
import 'package:pt_sage/models/transaksiPo.dart';
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
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return PurchaseOrderList.fromJson(jsonResponse);
      } else {
        print('Error: Unexpected response format');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<List<TransaksiPurchaseOrder>?> getTransaksiPoData(roles) async {
    try {
      final uri =
          Uri.parse(roles == 1 ? "$TransaksiPo/approvePO" : "$TransaksiPo");
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print("status ${response.statusCode}");
      print("Uri: $uri");
      // print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((data) => TransaksiPurchaseOrder.fromJson(data))
            .toList();
      } else {
        print('Error: Unexpected response format');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<List<TransaksiPurchaseOrder>?> getKendaraanPo(id) async {
    try {
      final uri = Uri.parse("$TransaksiPo/no-polisi/$id");
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((data) => TransaksiPurchaseOrder.fromJson(data))
            .toList();
      } else {
        print('Error: Unexpected response format');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<KemasanList?> getKemasan(id) async {
    try {
      // isLoading.value = true;
      final uri = Uri.parse('$PoAPI/kemasan/$id');
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

  // Future<DataWrapper?> getProductData() async {
  //   try {
  //     isLoading2.value = true;
  //     final uri = Uri.parse(PoCreateAPI);

  //     var client = http.Client();
  //     var request = http.Request('GET', uri)
  //       ..headers['Authorization'] = 'Bearer $token';

  //     var streamedResponse = await client.send(request);

  //     // Reading the streamed response
  //     var byteStream = streamedResponse.stream;
  //     var jsonDecoder = Utf8Decoder().bind(byteStream).transform(json.decoder);

  //     await for (var chunk in jsonDecoder) {
  //       try {
  //         // Check if the chunk is a Map
  //         if (chunk is Map<String, dynamic>) {
  //           isLoading2.value = false;
  //           return DataWrapper.fromJson(chunk);
  //         } else {
  //           print('Unexpected JSON structure or type.');
  //         }
  //       } catch (e) {
  //         print('Error parsing JSON chunk: $e');
  //       }
  //     }
  //   } catch (e) {
  //     print('Error: ${e.toString()}');
  //   } finally {
  //     isLoading2.value = false;
  //   }
  //   return null;
  // }
  Future<DataWrapper?> getProductData() async {
    try {
      isLoading2.value = true;

      final response = await http.get(
        Uri.parse(PoCreateAPI),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print('Raw response body: ${response.body}');

        try {
          var jsonResponse = jsonDecode(response.body);

          if (jsonResponse is Map<String, dynamic>) {
            return DataWrapper.fromJson(
                jsonResponse); // Ensure DataWrapper handles all types properly.
          } else {
            print('Unexpected JSON structure.');
          }
        } catch (e) {
          print('Error decoding JSON: $e');
        }
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading2.value = false;
    }
    return null;
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
      diskonTypes, kemasans, quantity, hargas) {
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
    int? harga = hargas;
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
            backgroundColor: Color.fromARGB(255, 244, 190, 54),
            colorText: Colors.white);
      } else {
        EasyLoading.show();
        var data = {
          "customers": customer,
          "product": product,
          "harga": harga,
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
            EasyLoading.dismiss();
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
