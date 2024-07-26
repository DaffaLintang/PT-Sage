import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';

class LoginProvider extends GetConnect {
  Future<Response> auth(var data) {
    return post("http://10.0.2.2:8000/api/login", data);
  }
}
