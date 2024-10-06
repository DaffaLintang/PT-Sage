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
  final isLoading = false.obs;

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

        KeluhanProvider().storeKeluhan(token, data).then((value) {
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

  void retur(id) {
    try {
      KeluhanProvider().updateRetur(token, id).then((value) {
        // print(value.statusCode);
        if (value.statusCode == 200) {
          // KeluhanPelangganController.keluhanController.text = '';
          Get.offAll(() => HomePage());
          Get.snackbar('Success', 'Retur Berhasil',
              backgroundColor: Color.fromARGB(255, 75, 212, 146),
              colorText: Colors.white);
        } else {
          Get.snackbar('Error', 'Retur Gagal',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      });
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }

  void reject(id) {
    try {
      KeluhanProvider().reject(token, id).then((value) {
        // print(value.statusCode);
        if (value.statusCode == 200) {
          // KeluhanPelangganController.keluhanController.text = '';
          Get.offAll(() => HomePage());
          Get.snackbar('Success', 'Reject Berhasil',
              backgroundColor: Color.fromARGB(255, 75, 212, 146),
              colorText: Colors.white);
        } else {
          Get.snackbar('Error', 'Reject Gagal',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      });
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }

  void approveRetur(id) {
    try {
      KeluhanProvider().updateApproveRetur(token, id).then((value) {
        // print(value.statusCode);
        if (value.statusCode == 200) {
          // KeluhanPelangganController.keluhanController.text = '';
          Get.offAll(() => HomePage());
          Get.snackbar('Success', 'Retur Berhasil Diapprove',
              backgroundColor: Color.fromARGB(255, 75, 212, 146),
              colorText: Colors.white);
        } else {
          Get.snackbar('Error', 'Retur Gagal Diapprove',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      });
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }

  void approveNonRetur(id) {
    try {
      KeluhanProvider().updateApproveNonRetur(token, id).then((value) {
        // print(value.statusCode);
        if (value.statusCode == 200) {
          // KeluhanPelangganController.keluhanController.text = '';
          Get.offAll(() => HomePage());
          Get.snackbar('Success', 'Non Retur Berhasil Diapprove',
              backgroundColor: Color.fromARGB(255, 75, 212, 146),
              colorText: Colors.white);
        } else {
          Get.snackbar('Error', 'Non Retur Gagal Diapprove',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      });
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }

  void nonRetur(id, keluhan) {
    String? keluhans;

    switch (keluhan) {
      case "Biasa":
        keluhans = "biasa";
        break;
      case "Khusus":
        keluhans = "pending";
        break;
    }
    print(keluhan);
    try {
      if (keluhan == null) {
        Get.snackbar('Error', 'Jenis Keluhan Harus Diisi',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        EasyLoading.show();
        var data = {"type_non_retur": keluhans};
        KeluhanProvider().nonRetur(id, token, data).then((value) {
          if (value.statusCode == 200) {
            Get.offAll(() => const HomePage());
            Get.snackbar('Success', 'Non Retur Berhasil',
                backgroundColor: Color.fromARGB(255, 75, 212, 146),
                colorText: Colors.white);
          } else {
            Get.snackbar('Error', 'Non Retur Gagal',
                backgroundColor: Colors.red, colorText: Colors.white);
          }
          EasyLoading.dismiss();
        });
      }
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }

  Future<List<AdminKeluhanData>?> getAdminKeluhan() async {
    try {
      final uri = Uri.parse("${AdminKeluhanApi}");
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        List<AdminKeluhanData> customers = data.map((item) {
          return AdminKeluhanData.fromJson(item as Map<String, dynamic>);
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

  Future<List<Retur>?> getReturApproval() async {
    try {
      isLoading.value = true;
      final uri = Uri.parse("${AdminKeluhanApi}/approval-retur");
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      // print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        List<Retur> keluhan = data.map((item) {
          return Retur.fromJson(item as Map<String, dynamic>);
        }).toList();
        isLoading.value = false;

        return keluhan;
      } else {
        isLoading.value = false;
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<List<NonRetur>?> getNonReturApproval() async {
    try {
      isLoading.value = true;
      final uri = Uri.parse("${AdminKeluhanApi}/approval-non-retur");
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      // print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        List<NonRetur> keluhan = data.map((item) {
          return NonRetur.fromJson(item as Map<String, dynamic>);
        }).toList();
        isLoading.value = false;

        return keluhan;
      } else {
        isLoading.value = false;
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future<DetailKeluhan?> getAdminDetailKeluhan(id) async {
    try {
      isLoading.value = true; // Start loading
      final uri = Uri.parse("${AdminKeluhanApi}/retur/${id}");
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Map<String, dynamic> data = jsonResponse['data'];

        isLoading.value = false; // Stop loading
        return DetailKeluhan.fromJson(data); // Return fetched data
      } else {
        isLoading.value = false; // Stop loading on failure
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false; // Stop loading on exception
      print('Error: ${e.toString()}');
      return null;
    }
  }
}
