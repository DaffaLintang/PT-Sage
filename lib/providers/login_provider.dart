import 'package:get/get.dart';
import 'package:pt_sage/apiVar.dart';

class LoginProvider extends GetConnect {
  Future<Response> auth(var data) {
    print(post(LoginAPI, data));
    return post(LoginAPI, data);
  }
}
