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
  List<Invoice>? invoices;

  @override
  void initState() {
    super.initState();
    fetchInvoices();
  }

  void fetchInvoices() async {
    List<Invoice> fetchedInvoice = await InvoiceController().fetchInvoices();
    setState(() {
      invoices = fetchedInvoice;
    });
  }

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
        body: invoices == null
            ? Center(child: Text("Tidak ada data"))
            : ListView.builder(
                itemCount: invoices!.length,
                itemBuilder: (context, index) {
                  final invoice = invoices![index];
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
                              image: AssetImage('assets/Basket_alt_3.png'))),
                    ),
                    title: Text(invoice.kodeInvoice),
                    subtitle: Text(invoice.kodePengiriman),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Get.offAll(() => InvoicePage(), arguments: invoice);
                    },
                  );
                }));
  }
}
