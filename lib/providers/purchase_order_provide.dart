import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';

class PoProvider extends GetConnect {
  Future<Response> store(var data) {
    return post(PoStoreAPI, data);
  }
}
