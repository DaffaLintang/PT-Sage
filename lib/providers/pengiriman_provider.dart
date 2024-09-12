import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengirimanProvider extends GetConnect {
  // Future<http.Response?> store(
  //     Map<String, dynamic> data, String endPoint) async {
  //   final uri = Uri.parse(endPoint);

  //   try {
  //     final response = await http.post(
  //       uri,
  //       headers: {
  //         // if (token != null) 'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(data),
  //     );
  //     print(uri);
  //     if (response.statusCode == 200) {
  //       print('Success: ${response.body}');
  //     } else {
  //       print(
  //           'Failed with status: ${response.statusCode}, body: ${response.body}');
  //     }
  //     return response;
  //   } catch (e) {
  //     print('Exception occurred: $e');
  //     return null; // Return null if an exception occurs
  //   }
  // }
  Future<Response> store(Map<String, dynamic> data, String endPoint) {
    return post(endPoint, data);
  }
}
