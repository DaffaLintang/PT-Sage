import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/invoice_controller.dart';
import 'package:pt_sage/controllers/keluahanPelanggan_controller.dart';
import 'package:pt_sage/page/feedback_page.dart';
import 'package:pt_sage/page/invoice_page.dart';
import 'package:pt_sage/page/penanganan_keluhan_pelanggan_page.dart';
import '../controllers/menu_controller.dart';
import '../models/invoice.dart';
import '../models/keluhanCustomer.dart';
import 'detail_keluhan_page.dart';
import 'home_page.dart';

class ListPenanggananKeluhanPelangganPage extends StatefulWidget {
  const ListPenanggananKeluhanPelangganPage({Key? key}) : super(key: key);

  @override
  State<ListPenanggananKeluhanPelangganPage> createState() =>
      _ListPenanggananKeluhanPelangganPageState();
}

class _ListPenanggananKeluhanPelangganPageState
    extends State<ListPenanggananKeluhanPelangganPage> {
  List<AdminKeluhanData>? keluhanData;
  late final menus;
  List<int> actionId = [];

  @override
  void initState() {
    super.initState();
    fetchKeluhan();
    checkIfIdExists();
    print(actionId);
  }

  void checkIfIdExists() async {
    menus = await MenuController().getMenu();
    setState(() {});
    for (var menu in menus) {
      for (var action in menu.actions) {
        actionId.add(action.actionId);
      }
    }
    // SpUtil.putStringList('menus', menuIds!.map((id) => id.toString()).toList());
  }

  void fetchKeluhan() async {
    List<AdminKeluhanData>? fetchKeluhan =
        await KeluhanPelangganController().getAdminKeluhan();
    setState(() {
      keluhanData = fetchKeluhan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "List Keluhan",
            style: TextStyle(
                color: Color(0xffBF1619),
                fontFamily: GoogleFonts.rubik().fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 22),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAll(() => HomePage());
              },
              icon: Image.asset('assets/LineRed.png')),
          backgroundColor: Colors.white,
          elevation: 5,
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Get.to(() => FeedBackPage());
          //         KeluhanPelangganController.keluhanController.text = '';
          //       },
          //       icon: Icon(
          //         Icons.add,
          //         color: Color(0xffBF1619),
          //       )),
          // ],
        ),
        body: keluhanData == null
            ? Center(child: Text("Tidak ada data"))
            : ListView.builder(
                itemCount: keluhanData!.length,
                itemBuilder: (context, index) {
                  final keluhan = keluhanData![index];
                  return ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.black,
                                BlendMode.srcATop,
                              ),
                              image:
                                  AssetImage('assets/comment-question.png'))),
                    ),
                    title: Text(keluhan.kodeInvoice!),
                    subtitle: Text(keluhan.customer!.customersName!),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: actionId.contains(44)
                        ? () {
                            Get.to(
                              DetailPenanggananKeluhan(),
                              arguments: keluhan,
                            );
                          }
                        : null,
                  );
                }));
  }
}
