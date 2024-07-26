import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pt_sage/page/Pengiriman_barang.dart';
import 'package:pt_sage/page/dashboard_page.dart';
import 'package:pt_sage/page/feedback_page.dart';
import 'package:pt_sage/page/home_page.dart';
import 'package:pt_sage/page/login_page.dart';
import 'package:sp_util/sp_util.dart';

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
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
