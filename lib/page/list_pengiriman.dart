import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/apiVar.dart';
import 'package:pt_sage/models/purchase_order.dart';
import 'package:pt_sage/models/transaksiDelivery.dart';
import 'package:pt_sage/models/transaksiPo.dart';
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
  List<TransaksiPurchaseOrder>? orders;
  List<TransaksiDelivery>? order;
  int _currentSelection = 0;
  final PengirimanController controller = Get.put(PengirimanController());

  @override
  void initState() {
    super.initState();
    // if (roles == 1) {
    //   fetchTransaksiPo();
    //   fetchDelivery();
    // } else if (widget.menuIds.contains(20) || roles == 1) {
    //   fetchTransaksiPo();
    // } else if (widget.menuIds.contains(20) || roles == 1) {
    //   fetchDelivery();
    // }
    if (widget.menuIds.contains(20) || roles == 1) {
      fetchTransaksiPo();
    }
  }

  void fetchTransaksiPo() async {
    final poController = PoController();
    List<TransaksiPurchaseOrder>? fetchedOrders =
        await poController.getTransaksiPoData();

    setState(() {
      orders = fetchedOrders;
      print(order);
    });
  }

  void fetchDelivery() async {
    final poController = PengirimanController();
    List<TransaksiDelivery>? fetchedOrders =
        await poController.getDeliveryData();

    setState(() {
      order = fetchedOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final List<Map<String, dynamic>> menuOptions = [
    //   {'id': 20, 'label': 'Belum Kirim'},
    //   {'id': 21, 'label': 'Setengah Kirim'},
    // ];
    // final filteredOptions = menuOptions
    //     .where((option) => widget.menuIds.contains(option['id']))
    //     .toList();
    // final isSelected = List.generate(
    //     filteredOptions.length, (index) => index == _currentSelection);
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
        body:
            // ListView(
            //   children: [
            //     Center(
            //       child: Column(
            //         children: [
            //           SizedBox(
            //             height: 20,
            //           ),
            //           roles == 1
            //               ? ToggleButtons(
            //                   children: <Widget>[
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.symmetric(horizontal: 32.0),
            //                       child: Text(
            //                         'Belum Kirim',
            //                         style: TextStyle(
            //                             fontSize: 14, fontWeight: FontWeight.w600),
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.symmetric(horizontal: 16.0),
            //                       child: Text(
            //                         'Setengah Kirim',
            //                         style: TextStyle(
            //                             fontSize: 14, fontWeight: FontWeight.w600),
            //                       ),
            //                     ),
            //                   ],
            //                   isSelected: List.generate(
            //                       2, (index) => index == _currentSelection),
            //                   onPressed: (int newIndex) {
            //                     setState(() {
            //                       _currentSelection = newIndex;
            //                     });
            //                   },
            //                   selectedColor: Colors.white,
            //                   fillColor: Color(0xffBF1619),
            //                   borderColor: Color(0xffBF1619),
            //                   borderRadius: BorderRadius.circular(12),
            //                   borderWidth: 1,
            //                 )
            //               : ToggleButtons(
            //                   children: filteredOptions.map((option) {
            //                     return Padding(
            //                       padding:
            //                           const EdgeInsets.symmetric(horizontal: 16.0),
            //                       child: Text(
            //                         option['label']!,
            //                         style: TextStyle(
            //                             fontSize: 14, fontWeight: FontWeight.w600),
            //                       ),
            //                     );
            //                   }).toList(),
            //                   isSelected: isSelected,
            //                   onPressed: (int newIndex) {
            //                     setState(() {
            //                       _currentSelection = newIndex;
            //                     });
            //                   },
            //                   selectedColor: Colors.white,
            //                   fillColor: Color(0xffBF1619),
            //                   borderColor: Color(0xffBF1619),
            //                   borderRadius: BorderRadius.circular(12),
            //                   borderWidth: 1,
            //                 ),
            //           widget.menuIds.contains(20) && widget.menuIds.contains(21) ||
            //                   roles == 1
            //               ? _currentSelection == 0
            //                   ? Obx(() {
            //                       if (controller.isLoading.value &&
            //                           orders == null) {
            //                         return Center(
            //                             child:
            //                                 CircularProgressIndicator()); // Show loading
            //                       } else {
            //                         return ListView.builder(
            //                             shrinkWrap: true,
            //                             itemCount: orders?.length,
            //                             itemBuilder: (context, index) {
            //                               final order = orders![index];
            //                               return widget.menuIds.contains(20) ||
            //                                       roles == 1
            //                                   ? order.status == 'approved' &&
            //                                           order.deliveryStatus ==
            //                                               'belum di kirim'
            //                                       ? ListTile(
            //                                           leading: Container(
            //                                             height: 50,
            //                                             width: 50,
            //                                             decoration: BoxDecoration(
            //                                                 image: DecorationImage(
            //                                                     colorFilter:
            //                                                         ColorFilter
            //                                                             .mode(
            //                                                       Colors.black,
            //                                                       BlendMode.srcATop,
            //                                                     ),
            //                                                     image: AssetImage(
            //                                                         'assets/package_car.png'))),
            //                                           ),
            //                                           title: Text(order.kodePo),
            //                                           subtitle: Text(
            //                                               order.deliveryStatus),
            //                                           trailing:
            //                                               Icon(Icons.arrow_forward),
            //                                           onTap: () {
            //                                             Get.to(
            //                                                 () =>
            //                                                     PengirimanBarangPage(),
            //                                                 arguments: order);
            //                                             PengirimanController
            //                                                 .kendaraanController
            //                                                 .text = '';
            //                                             PengirimanController
            //                                                 .noPolController
            //                                                 .text = '';
            //                                             PengirimanController
            //                                                 .supirController
            //                                                 .text = '';
            //                                           },
            //                                         )
            //                                       : SizedBox()
            //                                   : SizedBox();
            //                             });
            //                       }
            //                     })
            //                   : Obx(() {
            //                       if (controller.isLoading.value && order == null) {
            //                         return Center(
            //                             child:
            //                                 CircularProgressIndicator()); // Show loading
            //                       } else {
            //                         return ListView.builder(
            //                             shrinkWrap: true,
            //                             itemCount: orders!.length,
            //                             itemBuilder: (context, index) {
            //                               final order = orders![index];
            //                               return widget.menuIds.contains(20) ||
            //                                       roles == 1
            //                                   ? order.status == 'approved' &&
            //                                           order.deliveryStatus ==
            //                                               'belum di kirim'
            //                                       ? ListTile(
            //                                           leading: Container(
            //                                             height: 50,
            //                                             width: 50,
            //                                             decoration: BoxDecoration(
            //                                                 image: DecorationImage(
            //                                                     colorFilter:
            //                                                         ColorFilter
            //                                                             .mode(
            //                                                       Colors.black,
            //                                                       BlendMode.srcATop,
            //                                                     ),
            //                                                     image: AssetImage(
            //                                                         'assets/package_car.png'))),
            //                                           ),
            //                                           title: Text(order.kodePo),
            //                                           subtitle: Text(
            //                                               order.deliveryStatus),
            //                                           trailing:
            //                                               Icon(Icons.arrow_forward),
            //                                           onTap: () {
            //                                             Get.to(
            //                                                 () =>
            //                                                     PengirimanBarangPage(),
            //                                                 arguments: order);
            //                                             PengirimanController
            //                                                 .kendaraanController
            //                                                 .text = '';
            //                                             PengirimanController
            //                                                 .noPolController
            //                                                 .text = '';
            //                                             PengirimanController
            //                                                 .supirController
            //                                                 .text = '';
            //                                           },
            //                                         )
            //                                       : SizedBox()
            //                                   : SizedBox();
            //                             });
            //                       }
            //                     })
            //               : SizedBox()
            //         ],
            //       ),
            //     )
            //   ],
            // )

            orders == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: orders!.length,
                    itemBuilder: (context, index) {
                      final order = orders![index];
                      return widget.menuIds.contains(20) &&
                                  widget.menuIds.contains(21) ||
                              roles == 1
                          ? order.status == 'approved' &&
                                      order.deliveryStatus ==
                                          'belum di kirim' ||
                                  order.deliveryStatus == 'setengah di kirim'
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
                                  subtitle: Text(order.deliveryStatus),
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
                          : widget.menuIds.contains(20) || roles == 1
                              ? order.status == 'approved' &&
                                      order.deliveryStatus == 'belum di kirim'
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
                                      subtitle: Text(order.deliveryStatus),
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
                              : widget.menuIds.contains(21) || roles == 1
                                  ? order.status == 'approved' &&
                                          order.deliveryStatus ==
                                              'setengah di kirim'
                                      ? ListTile(
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      Colors.black,
                                                      BlendMode.srcATop,
                                                    ),
                                                    image: AssetImage(
                                                        'assets/package_car.png'))),
                                          ),
                                          title: Text(order.kodePo),
                                          subtitle: Text(order.deliveryStatus),
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
