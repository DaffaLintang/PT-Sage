import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/page/dashboard_page.dart';
import 'package:pt_sage/providers/approved_provider.dart';
import 'package:sp_util/sp_util.dart';

import '../page/detail_po_approve_page.dart';
import '../page/po_approvel_page.dart';

class ApprovedController extends GetxController {
  String? token = SpUtil.getString('token');
  static TextEditingController dateController = TextEditingController();

  void approve(String poId, date) async {
    final endpoint = '${ApprovelPo}/${poId}';
    final data = {"status": "approved", "tanggal_pengiriman": date};
    if (date.trim().isEmpty) {
      Get.snackbar('Error', 'Tanggal Pengiriman Harus Diisi',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      final response =
          await ApprovedProvider().updateData(token!, endpoint, data);

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Data Berhasil Di Approve',
            backgroundColor: Color.fromARGB(255, 75, 212, 146),
            colorText: Colors.white);
        dateController.text = "";
        Get.offAll(() => DashboardPage());
      } else {
        Get.snackbar('Error', 'Terjadi kesalahan',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  void rejected(String poId, date) async {
    final endpoint = '${ApprovelPo}/${poId}';
    final data = {"status": "rejected", "tanggal_pengiriman": date};
    if (date.trim().isEmpty) {
      Get.snackbar('Error', 'Tanggal Pengiriman Harus Diisi',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      final response =
          await ApprovedProvider().updateData(token!, endpoint, data);

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Data Berhasil Di Reject',
            backgroundColor: Color.fromARGB(255, 75, 212, 146),
            colorText: Colors.white);
        Get.offAll(() => ListPOApprovel());
      } else {
        Get.snackbar('Error', 'Terjadi kesalahan',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }
}
