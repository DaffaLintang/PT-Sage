import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KuisionerProvider extends GetConnect {
  Future<Response> storePb(var data) {
    return post("${KuisionerPosisiBersaingApi}/store", data);
  }

  Future<Response> storeKp(var data) {
    return post("${KuisionerPosisiBersaingApi}/store", data);
  }
}
