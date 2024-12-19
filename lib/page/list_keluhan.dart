import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/invoice_controller.dart';
import 'package:pt_sage/controllers/keluahanPelanggan_controller.dart';
import 'package:pt_sage/page/feedback_page.dart';
import 'package:pt_sage/page/invoice_page.dart';
import 'package:sp_util/sp_util.dart';
import '../models/invoice.dart';
import '../models/keluhanCustomer.dart';
import 'detail_keluhan_page.dart';
import 'home_page.dart';

class ListKeluhanPage extends StatefulWidget {
  final List<int> menuIds;
  ListKeluhanPage({Key? key})
      : menuIds = SpUtil.getStringList('menus')?.map(int.parse).toList() ?? [],
        super(key: key);

  @override
  State<ListKeluhanPage> createState() => _ListKeluhanPageState();
}

class _ListKeluhanPageState extends State<ListKeluhanPage> {
  List<KeluhanData>? keluhanData;
  int? roles;

  @override
  void initState() {
    super.initState();
    fetchKeluhan();
    roles = SpUtil.getInt('roles');
  }

  void fetchKeluhan() async {
    List<KeluhanData>? fetchKeluhan =
        await KeluhanPelangganController().getKeluhan();
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
          actions: [
            widget.menuIds.contains(31) || roles == 1
                ? IconButton(
                    onPressed: () {
                      Get.to(() => FeedBackPage());
                      KeluhanPelangganController.keluhanController.text = '';
                    },
                    icon: Icon(
                      Icons.add,
                      color: Color(0xffBF1619),
                    ))
                : SizedBox()
          ],
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
                              image: AssetImage('assets/Chat_alt_3.png'))),
                    ),
                    title: Text(keluhan.kodeInvoice!),
                    subtitle: Text(keluhan.customer!.customersName!),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Get.to(() => DetailKeluhanPage(), arguments: keluhan);
                    },
                  );
                }));
  }
}
