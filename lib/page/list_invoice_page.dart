import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/invoice_controller.dart';
import 'package:pt_sage/page/invoice_page.dart';
import '../models/invoice.dart';
import 'home_page.dart';

class ListInvoicePage extends StatefulWidget {
  const ListInvoicePage({Key? key}) : super(key: key);

  @override
  State<ListInvoicePage> createState() => _ListInvoicePageState();
}

class _ListInvoicePageState extends State<ListInvoicePage> {
  late Future<List<Invoice>?> futureInvoices;

  @override
  void initState() {
    super.initState();
    futureInvoices = InvoiceController().fetchInvoices();
    print(futureInvoices);
  }

  // void fetchInvoices() async {
  //   List? fetchedInvoice = await InvoiceController().fetchInvoices();
  //   setState(() {
  //     // print(fetchedInvoice.);
  //     futureInvoices = InvoiceController().fetchInvoices();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List Invoice",
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
      body: FutureBuilder<List<Invoice>?>(
        future: futureInvoices,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Menampilkan indikator pemuatan saat data sedang dimuat
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Menampilkan pesan kesalahan jika ada error
            return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Menampilkan pesan jika tidak ada data
            return Center(child: Text("Tidak ada data"));
          } else {
            // Menampilkan data yang berhasil diambil
            final invoices = snapshot.data!;
            return ListView.builder(
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final invoice = invoices[index];
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
                        image: AssetImage('assets/File_dock.png'),
                      ),
                    ),
                  ),
                  title: Text(invoice.kodeInvoice),
                  subtitle: Text(invoice.kodePengiriman),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.offAll(() => InvoicePage(), arguments: invoice);
                  },
                );
              },
            );
          }
        },
      ),
    );
    //futureInvoices == null
    //  ? Center(child: Text("Tidak ada data"))
    //: SizedBox()
    // ListView.builder(
    //     itemCount: invoices!.length,
    //     itemBuilder: (context, index) {
    //       final detailDelivery = invoices![index];
    //       return ListTile(
    //         leading: Container(
    //           height: 50,
    //           width: 50,
    //           decoration: BoxDecoration(
    //               image: DecorationImage(
    //                   colorFilter: ColorFilter.mode(
    //                     Colors.black,
    //                     BlendMode.srcATop,
    //                   ),
    //                   image: AssetImage('assets/Basket_alt_3.png'))),
    //         ),
    //         // title: Text(detailDelivery.data![index].kodeInvoice!),
    //         // subtitle: Text(detailDelivery.kodePengiriman!),
    //         trailing: Icon(Icons.arrow_forward),
    //         onTap: () {
    //           Get.offAll(() => InvoicePage(),
    //               arguments: detailDelivery);
    //         },
    //       );
    //     })
    // );
  }
}
