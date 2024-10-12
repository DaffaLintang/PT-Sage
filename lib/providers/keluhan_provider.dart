import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KeluhanProvider extends GetConnect {
  Future<http.Response> storeKeluhan(String? token, Map<String, dynamic> data) {
    final uri = Uri.parse("${KeluhanApi}/store");
    return http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));
  }

  Future<http.Response> nonRetur(id, String? token, Map<String, dynamic> data) {
    final uri = Uri.parse("${AdminKeluhanApi}/non-retur-update/${id}");
    return http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));
  }

  Future<http.Response> updateRetur(String? token, id) {
    final uri = Uri.parse("${AdminKeluhanApi}/retur-update/${id}");
    return http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
  }

  Future<http.Response> updateApproveRetur(
      String? token, id, Map<String, dynamic> data) {
    final uri = Uri.parse("${AdminKeluhanApi}/approval-retur-update/${id}");
    return http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));
  }

  Future<http.Response> updateApproveNonRetur(
      String? token, id, Map<String, dynamic> data) {
    final uri = Uri.parse("${AdminKeluhanApi}/approval-non-retur-update/${id}");
    return http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));
  }

  Future<http.Response> reject(String? token, id) {
    final uri = Uri.parse("${AdminKeluhanApi}/reject/${id}");
    return http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
  }
}
