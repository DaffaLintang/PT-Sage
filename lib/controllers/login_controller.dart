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
          print(value.statusCode);
          if (value.statusCode == 200) {
            username = '';
            password = '';
            var token = value.body["token"];
            var data = value.body["user"];
            // print(data["level"]["level_name"]);
            SpUtil.putInt('id', data["id"]);
            SpUtil.putString('token', token);
            SpUtil.putString('username', data["username"]);
            SpUtil.putString('email', data["email"]);
            SpUtil.putString('ttd', data["ttd"] ?? '');
            SpUtil.putString('avatar', data["avatar"] ?? "");
            SpUtil.putString('fullname', data["fullname"]);
            SpUtil.putInt('roles', data["levels_id"]);
            SpUtil.putString('rolesName', data["level"]["levels_name"]);
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
