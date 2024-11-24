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
import 'package:pt_sage/models/noPol.dart';
import 'package:pt_sage/models/transaksiDelivery.dart';
import 'package:pt_sage/page/dashboard_page.dart';
import 'package:pt_sage/page/list_pengiriman.dart';
import 'package:pt_sage/providers/pengiriman_provider.dart';
import 'package:sp_util/sp_util.dart';
import '../models/kendaraan.dart';
import '../models/lot.dart';
import '../models/transaksiPoKendaraan.dart';
import '../page/home_page.dart';

class PengirimanController extends GetxController {
  static TextEditingController dateController = TextEditingController();
  static TextEditingController kendaraanController = TextEditingController();
  static TextEditingController supirController = TextEditingController();
  static TextEditingController noPolController = TextEditingController();
  static TextEditingController customerController = TextEditingController();
  final isLoading = false.obs;

  String? token = SpUtil.getString('token');

  Future<List<ProductLot>?> getProductLotData(id) async {
    try {
      final uri = Uri.parse('$Delivery/productLot/$id');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      print(uri);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Pastikan 'data' adalah daftar sebelum memprosesnya
        if (jsonResponse['data'] is List) {
          List<dynamic> data = jsonResponse['data'];

          // Convert the JSON list into a list of ProductLot objects
          return data.map((json) => ProductLot.fromJson(json)).toList();
        } else {
          print('Error: Data is not a list');
          return null;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<List<TransaksiDelivery>?> getDeliveryData() async {
    try {
      isLoading.value = true;
      final uri = Uri.parse("$Delivery");
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print("Delivery ${response.statusCode}");
      print("Delivery uri ${uri}");
      print("Roles ${uri}");
      if (response.statusCode == 200) {
        print(response.body);

        final List<dynamic> jsonResponse = jsonDecode(response.body);
        isLoading.value = false;
        return jsonResponse
            .map((data) => TransaksiDelivery.fromJson(data))
            .toList();
      } else {
        print('Error: Unexpected response format');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<List<ProductLot>?> getTransaksiPoProductLotData(id) async {
    try {
      final uri = Uri.parse('$TransaksiPo/productLot/$id');
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      print(uri);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Check if the 'data' key exists and contains a list
        if (jsonResponse['success'] == true && jsonResponse['data'] is List) {
          List<dynamic> productList = jsonResponse['data'];

          // Map the product list to ProductLot objects
          return productList.map((json) => ProductLot.fromJson(json)).toList();
        } else {
          throw Exception('No product data found');
        }
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

  Future<List<TransaksiPoKendaraan>?> TransaksiPogetKendaraan() async {
    try {
      final uri = Uri.parse('$TransaksiPo/kendaraan');
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final jsonResponse =
            jsonDecode(response.body); // Decode the full response

        List<dynamic> kendaraanList =
            jsonResponse['data']; // Access the 'data' field
        return kendaraanList
            .map((json) => TransaksiPoKendaraan.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<List<NoPolisiData>?> TransaksiPogetNoPol(id) async {
    try {
      final uri = Uri.parse('$TransaksiPo/no-polisi/$id');
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final jsonResponse =
            jsonDecode(response.body); // Decode the full response

        List<dynamic> kendaraanList =
            jsonResponse['data']; // Access the 'data' field
        return kendaraanList
            .map((json) => NoPolisiData.fromJson(json))
            .toList();
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
        EasyLoading.show();
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

        // if (totalLotTersedia >= totalQuantity) {
        PengirimanProvider().store(data, endpoint, token).then((value) {
          print(value.statusCode);
          if (value.statusCode == 200) {
            PengirimanController.kendaraanController.text = '';
            PengirimanController.noPolController.text = '';
            PengirimanController.supirController.text = '';
            Get.offAll(() => HomePage());
            Get.snackbar('Success', 'Pengiriman Berhasil',
                backgroundColor: Color.fromARGB(255, 75, 212, 146),
                colorText: Colors.white);
          } else {
            Get.snackbar('Error', 'Pengiriman Gagal',
                backgroundColor: Colors.red, colorText: Colors.white);
          }

          EasyLoading.dismiss();
        });
      }
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }

  void TransaksiPostore(noPolId, poId, customer, int? kendaraan, namaSupir,
      NoPol, tanggal, lot, Kemasan, jumlahLot, totalQuantity) {
    final endpoint = '$TransaksiPo/store/$poId';
    num totalLotTersedia = 0;
    try {
      if (namaSupir.isEmpty && NoPol.isEmpty && noPolId.isBlank) {
        Get.snackbar('Error', 'Data Tidak Boleh Kosong',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        EasyLoading.show();
        var data = {
          "customer_id": customer,
          "nomor_polisi_id": noPolId,
          "kendaraan_id": kendaraan,
          "nama_sopir": namaSupir,
          "tanggal_pengiriman": tanggal,
          "product_lot": lot,
          "kemasan": Kemasan
        };

        for (int i = 0; i < jumlahLot.length; i++) {
          totalLotTersedia += jumlahLot[i];
        }

        // if (totalLotTersedia >= totalQuantity) {
        PengirimanProvider().store(data, endpoint, token).then((value) {
          if (value.statusCode == 200) {
            PengirimanController.kendaraanController.text = '';
            PengirimanController.noPolController.text = '';
            PengirimanController.supirController.text = '';
            Get.offAll(() => HomePage());
            Get.snackbar('Success', 'Pengiriman Berhasil',
                backgroundColor: Color.fromARGB(255, 75, 212, 146),
                colorText: Colors.white);
          } else {
            Get.snackbar('Error', 'Pengiriman Gagal',
                backgroundColor: Colors.red, colorText: Colors.white);
          }

          EasyLoading.dismiss();
        });
      }
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }

  void TransaksiDeliveryUpdate(noPolId, pengirimanId, int? kendaraan, namaSupir,
      NoPol, tanggal, lot, Kemasan, jumlahLot) {
    final endpoint = '$Delivery/update/$pengirimanId';
    num totalLotTersedia = 0;
    try {
      if (namaSupir.isEmpty && NoPol.isEmpty && noPolId.isBlank) {
        Get.snackbar('Error', 'Data Tidak Boleh Kosong',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        EasyLoading.show();
        var data = {
          "nomor_polisi_id": noPolId,
          "kendaraan_id": kendaraan,
          "nama_sopir": namaSupir,
          "tanggal_pengiriman": tanggal,
          "product_lot": lot,
          "kemasan": Kemasan
        };

        for (int i = 0; i < jumlahLot.length; i++) {
          totalLotTersedia += jumlahLot[i];
        }

        // if (totalLotTersedia >= totalQuantity) {
        PengirimanProvider().update(data, endpoint, token).then((value) {
          if (value.statusCode == 200) {
            PengirimanController.kendaraanController.text = '';
            PengirimanController.noPolController.text = '';
            PengirimanController.supirController.text = '';
            Get.offAll(() => HomePage());
            Get.snackbar('Success', 'Pengiriman Berhasil',
                backgroundColor: Color.fromARGB(255, 75, 212, 146),
                colorText: Colors.white);
          } else {
            Get.snackbar('Error', 'Pengiriman Gagal',
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
