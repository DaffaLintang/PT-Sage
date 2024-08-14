import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pt_sage/page/login_page.dart';
import 'package:sp_util/sp_util.dart';

import 'controllers/purchase_order_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(PoController()); // Daftarkan controller di sini
      }),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
