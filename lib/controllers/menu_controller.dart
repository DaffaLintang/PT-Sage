import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pt_sage/page/home_page.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import 'package:pt_sage/models/payment.dart' as paymentModel;

import '../apiVar.dart';
import '../models/menu.dart';
import '../models/menuRole.dart';
import '../providers/login_provider.dart';

class MenuController extends GetxController {
  final isLoading = false.obs;
  String? token = SpUtil.getString('token');
  int? role = SpUtil.getInt('roles');
  // Future<List<int>?> getMenu() async {
  //   try {
  //     isLoading.value = true;
  //     final uri = Uri.parse('${MenuApi}/${role}');
  //     final response =
  //         await http.get(uri, headers: {'Authorization': 'Bearer $token'});

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //       List<dynamic> data = jsonResponse['selectedMenu'];

  //       // Mengambil hanya ID dari setiap item dalam `selectedMenu`
  //       isLoading.value = false;
  //       return data.map<int>((json) => json['id'] as int).toList();
  //     } else {
  //       isLoading.value = false;
  //       throw Exception('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: ${e.toString()}');
  //     return null;
  //   }
  // }
  Future<List<SelectedMenu>?> getMenu() async {
    try {
      isLoading.value = true;
      final uri = Uri.parse('${MenuApi}/${role}');
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['selectedMenu'];

        // Mengubah data JSON menjadi model SelectedMenu
        List<SelectedMenu> menus =
            data.map((json) => SelectedMenu.fromJson(json)).toList();

        List<int> menuIds = menus.map((menu) => menu.menuId).toList();

        // Menyimpan menuId sebagai StringList menggunakan SpUtil
        SpUtil.putStringList(
            'menus', menuIds.map((id) => id.toString()).toList());

        isLoading.value = false;
        return menus;
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
}
