import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/menu_controller.dart';
import 'package:pt_sage/page/Pengiriman_barang.dart';
import 'package:pt_sage/page/Purchase_page.dart';
import 'package:pt_sage/page/detail_kuisioner_page.dart';
import 'package:pt_sage/page/feedback_page.dart';
import 'package:pt_sage/page/invc_approvel_page.dart';
import 'package:pt_sage/page/kuisoner_page.dart';
import 'package:pt_sage/page/list_invoice_page.dart';
import 'package:pt_sage/page/list_keluhan.dart';
import 'package:pt_sage/page/list_po_page.dart';
import 'package:pt_sage/page/po_approvel_page.dart';
import 'package:pt_sage/utils/menu.dart';
import 'package:sp_util/sp_util.dart';

import 'DataLot_page.dart';
import 'List_customer_approval_page.dart';
import 'list_keluhan_approvel.dart';
import 'list_payment_page.dart';
import 'list_penanganan-pelanggan_page.dart';
import 'list_pengiriman.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? username;
  int? roles;
  List<int>? menuIds;

  final MenuController controller = Get.put(MenuController());

  String getRole(int i) {
    switch (i) {
      case 1:
        return "Super Admin";
        break;
      case 2:
        return "Admin";
        break;
      case 3:
        return "Direktur";
        break;
      case 4:
        return "manajer";
        break;
      case 5:
        return "Marketing";
        break;
      default:
        return "Unknown role";
    }
  }

  void checkIfIdExists() async {
    menuIds = await MenuController().getMenu();
    setState(() {});
    SpUtil.putStringList('menus', menuIds!.map((id) => id.toString()).toList());
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      username = SpUtil.getString('username') ?? "Username";
      roles = SpUtil.getInt('roles');
      checkIfIdExists();
      print("vatar : ${SpUtil.getString('avatar')}");
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String roleText = roles != null ? getRole(roles!) : "Role not set";
    return Scaffold(body: Obx(() {
      if (controller.isLoading.value || menuIds == null) {
        return Center(child: CircularProgressIndicator()); // Show loading
      } else {
        return Stack(
          children: [
            Positioned(
              top: -50,
              child: Container(
                width: screenWidth,
                height: 1000,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/bgDhs.png'),
                )),
              ),
            ),
            ListView(
              children: [
                SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/Logo(1).png'))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "PT. SAGE MASHLAHAT INDONESIA",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        width: 327,
                        height: 197,
                        decoration: BoxDecoration(
                            color: Color(0xff9E0507),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(4, 5),
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                height: 110,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Selamat Datang',
                                      style: GoogleFonts.rubik(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '$username',
                                      style: GoogleFonts.rubik(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              width: double.infinity,
                              height: 87,
                              decoration: BoxDecoration(
                                // gradient: LinearGradient(
                                //     colors: [Color(0xFF9E0507), Color(0xFFF29607)],
                                //     begin: Alignment.centerLeft,
                                //     end: Alignment.centerRight),
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Roles: ${SpUtil.getString("rolesName")}",
                                    style: TextStyle(
                                        color: Color(0xff9E0507),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Fitur Tersedia",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.2,
                        children: [
                          if (menuIds!.contains(15) || roles == 1) ...[
                            Menu(
                                onTap: () {
                                  Get.to(() => ListPOApprovel());
                                },
                                title: 'Sales Order Approval',
                                imageAsset: 'assets/Done_ring_round.png'),
                          ],
                          if (menuIds!.contains(16) ||
                              menuIds!.contains(17) ||
                              roles == 1) ...[
                            Menu(
                                onTap: () {
                                  Get.to(() => ListKeluhanApproval());
                                },
                                title: 'Keluhan Approval',
                                imageAsset: 'assets/Done_ring_round.png'),
                          ],
                          if (menuIds!.contains(14) || roles == 1) ...[
                            Menu(
                                onTap: () {
                                  Get.to(() => ListCustomerApprovel());
                                },
                                title: 'Pelanggan Approval',
                                imageAsset: 'assets/Done_ring_round.png'),
                          ],
                          if (menuIds!.contains(28) || roles == 1) ...[
                            Menu(
                                onTap: () {
                                  Get.to(() => listPoPage());
                                },
                                title: 'Sales Order',
                                imageAsset: 'assets/Basket_alt_3.png'),
                          ],
                          if (menuIds!.contains(20) ||
                              menuIds!.contains(21) ||
                              roles == 1) ...[
                            Menu(
                                onTap: () {
                                  Get.to(() => ListPengiriman());
                                },
                                title: 'Pengiriman Barang',
                                imageAsset: 'assets/package_car.png'),
                          ],
                          if (menuIds!.contains(30) ||
                              menuIds!.contains(31) ||
                              roles == 1) ...[
                            Menu(
                                onTap: () {
                                  Get.to(() => ListKeluhanPage());
                                },
                                title: 'Keluhan Pelanggan',
                                imageAsset: 'assets/Chat_alt_3.png'),
                          ],
                          if (menuIds!.contains(22) || roles == 1) ...[
                            Menu(
                                onTap: () {
                                  Get.to(() => ListInvoicePage());
                                },
                                title: 'Invoice',
                                imageAsset: 'assets/File_dock.png'),
                          ],
                          if (menuIds!.contains(25) ||
                              menuIds!.contains(26) ||
                              roles == 1) ...[
                            Menu(
                                onTap: () {
                                  Get.to(() => KuisonerPage(),
                                      arguments: menuIds);
                                },
                                title: 'Kuisioner',
                                imageAsset: 'assets/Desk_alt.png'),
                          ],
                          if (menuIds!.contains(24) || roles == 1) ...[
                            Menu(
                                onTap: () {
                                  Get.to(() =>
                                      ListPenanggananKeluhanPelangganPage());
                                },
                                title: 'Penangganan Keluhan',
                                imageAsset: 'assets/comment-question.png'),
                          ],
                          if (menuIds!.contains(23) || roles == 1) ...[
                            Menu(
                                onTap: () {
                                  Get.to(() => ListPaymentPage());
                                },
                                title: 'Pembayaran',
                                imageAsset: 'assets/money.png'),
                          ],
                          if (menuIds!.contains(18) || roles == 1) ...[
                            Menu(
                                onTap: () {
                                  Get.to(() => DataGoodTurnOvrSlip());
                                },
                                title: 'Stock FG',
                                imageAsset: 'assets/Info.png'),
                          ]
                        ],
                      ),
                    ],
                  ),
                )),
              ],
            )
          ],
        );
      }
    }));
  }
}
