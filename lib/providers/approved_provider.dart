import 'package:get/get.dart';

class ApprovedProvider extends GetConnect {
  Future<Response> updateData(
      String token, String endpoint, Map<String, dynamic> data) async {
    final response = await put(
      endpoint,
      data,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<Response> updateDataCustomer(
      String token, String endpoint, Map<String, dynamic> data) async {
    final response = await post(
      endpoint,
      data,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}
