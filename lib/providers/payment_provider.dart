import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pt_sage/models/payment.dart';

class PaymentProvider extends GetConnect {
  Future<http.Response> store(String? token, Map<String, dynamic> data, id) {
    final uri = Uri.parse("${PaymentApi}/store/${id}");
    return http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));
  }
}
