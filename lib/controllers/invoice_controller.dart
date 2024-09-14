import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/models/invoice.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

class InvoiceController extends GetxController {
  String? token = SpUtil.getString('token');

  // Future<List<DeliveryResponse>> fetchInvoices() async {
  //   final response = await http.get(Uri.parse(InvoiceApi));
  //   // print(response.statusCode);
  //   // print(response.body);

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = jsonDecode(response.body);
  //     // print(data);

  //     final List<dynamic> detailDeliveryJson = data['data'];
  //     // Mengembalikan list of DetailDelivery
  //     return detailDeliveryJson
  //         .map((json) => DeliveryResponse.fromJson(json))
  //         .toList();
  //   } else {
  //     // Jika 'detail_delivery' tidak ditemukan atau null, kembalikan list kosong
  //     return [];
  //   }
  // }

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
}
