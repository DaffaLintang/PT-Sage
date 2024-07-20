import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/page/invoice_page.dart';
import 'home_page.dart';

class ListInvoicePage extends StatefulWidget {
  const ListInvoicePage({Key? key}) : super(key: key);

  @override
  State<ListInvoicePage> createState() => _ListInvoicePageState();
}

class _ListInvoicePageState extends State<ListInvoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feedback",
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
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.text_snippet_outlined),
            title: Text("#INVC0001"),
            subtitle: Text('Subtitle invoice'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Aksi saat ListTile ditekan
              Get.offAll(() => InvoicePage());
            },
          );
        },
      ),
    );
  }
}
