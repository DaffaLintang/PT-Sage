import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KuisionerProvider extends GetConnect {
  // Future<http.Response> store(Map<String, dynamic> data) {
  //   final uri = Uri.parse('$KuisionerPosisiBersaingApi/store');
  //   print(uri);
  //   return http.post(uri, body: jsonEncode(data));
  // }
  Future<Response> store(var data) {
    return post("${KuisionerPosisiBersaingApi}/store", data);
  }
}
