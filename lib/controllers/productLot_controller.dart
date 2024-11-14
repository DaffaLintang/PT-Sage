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
import '../models/dataProductLot.dart';
import '../models/kendaraan.dart';
import '../models/lot.dart';
import '../models/transaksiPoKendaraan.dart';
import '../page/home_page.dart';

class DataProductLotController extends GetxController {
  String? token = SpUtil.getString('token');
  Future<List<InventoryItem>?> getDataLot() async {
    try {
      final uri = Uri.parse('$DataProductLot');
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((json) => InventoryItem.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }
}
