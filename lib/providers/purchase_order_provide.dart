import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PoProvider extends GetConnect {
  Future<http.Response> store(String? token, Map<String, dynamic> data) {
    final uri = Uri.parse(PoStoreAPI);
    return http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));
  }
}
