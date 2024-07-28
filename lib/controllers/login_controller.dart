import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pt_sage/page/home_page.dart';
import 'package:sp_util/sp_util.dart';

import '../providers/login_provider.dart';

class LoginController extends GetxController {
  static TextEditingController usernameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  void auth() {
    String username = usernameController.text;
    String password = passwordController.text;

    try {
      if (username.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'username atau Password Tidak Boleh Kosong',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        EasyLoading.show();
        var data = {"username": username, "password": password};
        LoginProvider().auth(data).then((value) {
          if (value.statusCode == 200) {
            var token = value.body["token"];
            var data = value.body["user"];
            SpUtil.putString('token', token);
            SpUtil.putString('username', data["username"]);
            SpUtil.putString('email', data["email"]);
            SpUtil.putInt('roles', data["levels_id"]);
            Get.offAll(() => HomePage());
            Get.snackbar('Success', 'Login Berhasil',
                backgroundColor: Color.fromARGB(255, 75, 212, 146),
                colorText: Colors.white);
          } else {
            Get.snackbar('Error', 'Login Gagal',
                backgroundColor: Colors.red, colorText: Colors.white);
          }
          EasyLoading.dismiss();
        });
      }
    } catch (e, stackTrace) {
      print('Exception occurred: $e\n$stackTrace');
    }
  }
}
