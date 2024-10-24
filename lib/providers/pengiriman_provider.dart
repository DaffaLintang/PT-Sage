import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengirimanProvider extends GetConnect {
  Future<http.Response> store(
      Map<String, dynamic> data, String endPoint, String? token) {
    // return post(endPoint, data);
    final uri = Uri.parse(endPoint);
    return http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));
  }
}
