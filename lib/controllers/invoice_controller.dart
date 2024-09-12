import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/models/invoice.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

class InvoiceController extends GetxController {
  String? token = SpUtil.getString('token');

  Future<List<Invoice>> fetchInvoices() async {
    final response = await http.get(Uri.parse(InvoiceApi));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      // Parsing JSON menjadi list of Invoice
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Invoice.fromJson(json)).toList();
    } else {
      // Jika gagal, lemparkan exception
      throw Exception('Failed to load invoices');
    }
  }
}
