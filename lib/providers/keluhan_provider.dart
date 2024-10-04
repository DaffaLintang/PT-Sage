import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KuisionerProvider extends GetConnect {
  Future<http.Response> storeKeluhan(String? token, Map<String, dynamic> data) {
    final uri = Uri.parse("${KeluhanApi}/store");
    return http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));
  }
}
