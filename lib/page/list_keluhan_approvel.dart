import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/keluahanPelanggan_controller.dart';
import 'package:pt_sage/models/keluhanCustomer.dart';

import 'detail_approval_non_retur_page .dart';
import 'detail_approval_retur_page.dart';
import 'home_page.dart';

class ListKeluhanApproval extends StatefulWidget {
  const ListKeluhanApproval({Key? key}) : super(key: key);

  @override
  State<ListKeluhanApproval> createState() => _ListKeluhanApprovalState();
}

class _ListKeluhanApprovalState extends State<ListKeluhanApproval> {
  final KeluhanPelangganController controller =
      Get.put(KeluhanPelangganController());
  int _currentSelection = 0;
  List<Retur>? retur;
  List<NonRetur>? nonRetur;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchReturKeluhan();
    fetchNonReturKeluhan();
  }

  void fetchReturKeluhan() async {
    List<Retur>? fetchKeluhan =
        await KeluhanPelangganController().getReturApproval();
    setState(() {
      retur = fetchKeluhan;
      print(retur!.length);
    });
  }

  void fetchNonReturKeluhan() async {
    List<NonRetur>? fetchKeluhan =
        await KeluhanPelangganController().getNonReturApproval();
    setState(() {
      nonRetur = fetchKeluhan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Approval Keluhan",
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
        body: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  ToggleButtons(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          'Retur',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Non-Retur',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                    isSelected:
                        List.generate(2, (index) => index == _currentSelection),
                    onPressed: (int newIndex) {
                      setState(() {
                        _currentSelection = newIndex;
                      });
                    },
                    selectedColor: Colors.white,
                    fillColor: Color(0xffBF1619),
                    borderColor: Color(0xffBF1619),
                    borderRadius: BorderRadius.circular(12),
                    borderWidth: 1,
                  ),
                  SizedBox(height: 20),
                  _currentSelection == 0
                      ? Obx(() {
                          if (controller.isLoading.value || retur == null) {
                            return Center(
                                child:
                                    CircularProgressIndicator()); // Show loading
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: retur!.length,
                                itemBuilder: (context, index) {
                                  final keluhan = retur![index];
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
                                              image: AssetImage(
                                                  'assets/Chat_alt_3.png'))),
                                    ),
                                    title: Text(keluhan.kodeInvoice),
                                    subtitle:
                                        Text(keluhan.customer.customersName),
                                    trailing: Icon(Icons.arrow_forward),
                                    onTap: () {
                                      Get.to(() => DetailReturApprovalPage(),
                                          arguments: keluhan);
                                    },
                                  );
                                });
                          }
                        })
                      : Obx(() {
                          if (controller.isLoading.value || nonRetur == null) {
                            return Center(
                                child:
                                    CircularProgressIndicator()); // Show loading
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: nonRetur!.length,
                                itemBuilder: (context, index) {
                                  final keluhan = nonRetur![index];
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
                                              image: AssetImage(
                                                  'assets/Chat_alt_3.png'))),
                                    ),
                                    title: Text(keluhan.kodeInvoice),
                                    subtitle:
                                        Text(keluhan.customer.customersName),
                                    trailing: Icon(Icons.arrow_forward),
                                    onTap: () {
                                      Get.to(() => DetailNonReturApprovalPage(),
                                          arguments: keluhan);
                                    },
                                  );
                                });
                          }
                        })
                ],
              ),
            )
          ],
        ));
  }
}

// class ReturWidget extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class NonReturWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue[100],
      child: Text('Ini adalah widget Non-Retur'),
    );
  }
}
