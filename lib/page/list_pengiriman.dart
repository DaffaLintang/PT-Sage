import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/models/purchase_order.dart';
import 'package:pt_sage/page/Pengiriman_barang.dart';
import 'package:sp_util/sp_util.dart';
import '../controllers/pengiriman.dart';
import '../controllers/purchase_order_controller.dart';
import 'home_page.dart';

class ListPengiriman extends StatefulWidget {
  final List<int> menuIds;
  ListPengiriman({Key? key})
      : menuIds = SpUtil.getStringList('menus')?.map(int.parse).toList() ?? [],
        super(key: key);

  @override
  State<ListPengiriman> createState() => _ListPengirimanState();
}

class _ListPengirimanState extends State<ListPengiriman> {
  PurchaseOrderList? orders;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    final poController = PoController();
    PurchaseOrderList? fetchedOrders = await poController.getPoData();
    setState(() {
      orders = fetchedOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "List Pengiriman",
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
        ),
        body: orders == null
            ? Center(child: Text("Tidak ada data"))
            : ListView.builder(
                itemCount: orders!.orders.length,
                itemBuilder: (context, index) {
                  final order = orders!.orders[index];
                  return widget.menuIds.contains(18) &&
                              widget.menuIds.contains(19) ||
                          roles == 1
                      ? order.status == 'approved' &&
                                  order.statusPengiriman == 'belum di kirim' ||
                              order.statusPengiriman == 'setengah di kirim'
                          ? ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black,
                                          BlendMode.srcATop,
                                        ),
                                        image: AssetImage(
                                            'assets/package_car.png'))),
                              ),
                              title: Text(order.kodePo),
                              subtitle: Text(order.statusPengiriman!),
                              trailing: Icon(Icons.arrow_forward),
                              onTap: () {
                                Get.to(() => PengirimanBarangPage(),
                                    arguments: order);
                                PengirimanController.kendaraanController.text =
                                    '';
                                PengirimanController.noPolController.text = '';
                                PengirimanController.supirController.text = '';
                              },
                            )
                          : SizedBox()
                      : widget.menuIds.contains(18) || roles == 1
                          ? order.status == 'approved' &&
                                  order.statusPengiriman == 'belum di kirim'
                              ? ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            colorFilter: ColorFilter.mode(
                                              Colors.black,
                                              BlendMode.srcATop,
                                            ),
                                            image: AssetImage(
                                                'assets/package_car.png'))),
                                  ),
                                  title: Text(order.kodePo),
                                  subtitle: Text(order.statusPengiriman!),
                                  trailing: Icon(Icons.arrow_forward),
                                  onTap: () {
                                    Get.to(() => PengirimanBarangPage(),
                                        arguments: order);
                                    PengirimanController
                                        .kendaraanController.text = '';
                                    PengirimanController.noPolController.text =
                                        '';
                                    PengirimanController.supirController.text =
                                        '';
                                  },
                                )
                              : SizedBox()
                          : widget.menuIds.contains(19) || roles == 1
                              ? order.status == 'approved' &&
                                      order.statusPengiriman ==
                                          'setengah di kirim'
                                  ? ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                colorFilter: ColorFilter.mode(
                                                  Colors.black,
                                                  BlendMode.srcATop,
                                                ),
                                                image: AssetImage(
                                                    'assets/package_car.png'))),
                                      ),
                                      title: Text(order.kodePo),
                                      subtitle: Text(order.statusPengiriman!),
                                      trailing: Icon(Icons.arrow_forward),
                                      onTap: () {
                                        Get.to(() => PengirimanBarangPage(),
                                            arguments: order);
                                        PengirimanController
                                            .kendaraanController.text = '';
                                        PengirimanController
                                            .noPolController.text = '';
                                        PengirimanController
                                            .supirController.text = '';
                                      },
                                    )
                                  : SizedBox()
                              : SizedBox();
                }));
  }
}
