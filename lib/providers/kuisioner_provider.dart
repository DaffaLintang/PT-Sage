import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KuisionerProvider extends GetConnect {
  Future<http.Response> storePb(var data, token) {
    final uri = Uri.parse("${KuisionerPosisiBersaingApi}/store");
    return http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));
  }

  Future<http.Response> storeKp(var data, token) {
    final uri = Uri.parse("${KepuasanPelanggan}/store");
    return http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));
  }
}
