import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pt_sage/models/customer.dart';
import 'package:pt_sage/models/invoice.dart';
import 'package:pt_sage/models/supplier.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:pt_sage/providers/pdf_api.dart';

import '../utils.dart';

Future<pw.Font> _loadFont(String path) async {
  final fontData = await rootBundle.load(path);
  return pw.Font.ttf(fontData);
}

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    final font = await _loadFont('assets/fonts/NotoSans-Regular.ttf');

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice, font),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice, font),
        buildInvoice(invoice, font),
        Divider(),
        buildTotal(invoice, font),
      ],
      footer: (context) => buildFooter(invoice, font),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice, pw.Font font) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer, font),
              buildInvoiceInfo(invoice.info, font),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer, pw.Font font) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            customer.name,
            style: TextStyle(fontWeight: FontWeight.bold, font: font),
          ),
          Text(customer.contact, style: TextStyle(font: font)),
          Text(customer.tujuan, style: TextStyle(font: font)),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info, pw.Font font) {
    final titles = <String>[
      'Tanggal Kirim:',
      'Pembayaran:',
    ];
    final data = <String>[
      Utils.formatDate(info.TanggalKirim),
      '${info.Pembayaran}',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200, font: font);
      }),
    );
  }

  static Widget buildTitle(Invoice invoice, pw.Font font) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, font: font),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info.description, style: TextStyle(font: font)),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice, pw.Font font) {
    final headers = [
      'No',
      'Produk',
      'Unit',
      'Qty (sack)',
      'Tonase (kg)',
      'Harga/kg',
      'Diskon',
      'Jumlah',
    ];
    final data = invoice.items.map((item) {
      final total = item.harga * item.jumlah;

      return [
        "${item.no}",
        '${item.produk}',
        '${item.qty}',
        '${item.tonase}',
        '${item.harga}',
        '${item.diskon}',
        '${item.jumlah}',
        '${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold, font: font),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
      cellStyle: TextStyle(font: font),
    );
  }

  static Widget buildTotal(Invoice invoice, pw.Font font) {
    final total = invoice.items
        .map((item) => item.harga * item.jumlah)
        .reduce((item1, item2) => item1 + item2);

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Total Tagihan',
                  value: Utils.formatPrice(total),
                  unite: true,
                  font: font,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice, pw.Font font) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'Address', value: invoice.supplier.address, font: font),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'SAGE MASHLAHAT INDONESIA BCA - ',
              value: invoice.supplier.paymentInfo,
              font: font),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
    required pw.Font font,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold, font: font);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value, style: TextStyle(font: font)),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
    required pw.Font font,
  }) {
    final style =
        titleStyle ?? TextStyle(fontWeight: FontWeight.bold, font: font);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : TextStyle(font: font)),
        ],
      ),
    );
  }
}
