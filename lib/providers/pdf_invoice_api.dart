import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

Future<pw.MemoryImage> _loadImg(String path) async {
  final ByteData data = await rootBundle.load(path);
  final Uint8List bytes = data.buffer.asUint8List();
  return pw.MemoryImage(bytes);
}

// final logo =
// final invoiceData = Get.arguments;
final NumberFormat currencyFormatter = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
);

class PdfInvoiceApi {
  static Future<File> generate(invoiceData) async {
    final pdf = Document();
    final font = await _loadFont('assets/fonts/NotoSans-Regular.ttf');
    final img = await _loadImg('assets/Logo(1).png');

    pdf.addPage(MultiPage(
      build: (context) => [
        InvoiceHeader(invoiceData, img),
        buildHeader(invoiceData, font),
        SizedBox(height: 2 * PdfPageFormat.cm),
        // buildTitle(invoice, font),
        buildInvoice(invoiceData, font),
        Divider(),
        buildTotal(invoiceData, font),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildPaymentInfo(font),
        SizedBox(height: 1 * PdfPageFormat.cm),
        InvoiceFooter(invoiceData),
      ],
      footer: (context) => buildFooter(font),
    ));

    return PdfApi.saveDocument(name: 'invoice.pdf', pdf: pdf);
  }

  static Widget InvoiceFooter(invoiceData) =>
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text('Dibuat oleh,'),
          pw.SizedBox(height: 50),
          pw.Text('HILMA FARDIDA'),
          pw.Container(height: 1, width: 100, color: PdfColors.black)
        ]),
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text('Diketahui oleh,'),
          pw.SizedBox(height: 50),
          pw.Text('HILMA FARDIDA'),
          pw.Container(height: 1, width: 100, color: PdfColors.black),
          pw.Text('Manajer Pemasaran'),
        ]),
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text('Diterima oleh,'),
          pw.SizedBox(height: 50),
          pw.Text(invoiceData.delivery.purchaseOrder.customersName),
          pw.Container(height: 1, width: 100, color: PdfColors.black)
        ]),
      ]);

  static Widget buildPaymentInfo(pw.Font font) => pw.Container(
      padding: pw.EdgeInsets.only(top: 10, bottom: 10, right: 20),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(color: PdfColors.black),
          left: pw.BorderSide(color: PdfColors.white),
          right: pw.BorderSide(color: PdfColors.black),
          bottom: pw.BorderSide(color: PdfColors.black),
        ),
      ),
      child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text('Pembayaran dapat dilakukan pada rekening : '),
        SizedBox(height: 10 * PdfPageFormat.mm),
        pw.Text(
          'SAGE MASHLAHAT INDONESIA BCA - 5111835111',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        )
      ]));

  static Widget InvoiceHeader(invoiceData, pw.MemoryImage img) => pw.Row(
        // crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          pw.Padding(
            padding: pw.EdgeInsets.only(right: 10),
            child: pw.Image(img, height: 50, width: 50),
          ),
          pw.Column(children: [
            pw.Text(
              "PT SAGE MASHLAHAT INDONESIA",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            pw.Text(
              "Jl. Senopati, Tapanrejo Kec. Muncar Kab. Banyuwangi - Jawa Timur",
              style: TextStyle(fontSize: 14),
            ),
            pw.Text(
              'Telp (+62 812-3063-8671)' +
                  ' Email: sagemashlahat.bwi@gmail.com',
              style: TextStyle(fontSize: 14),
            ),
            pw.Text(
              "SALES INVOICE",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ])
        ],
      );

  static Widget buildHeader(invoiceData, pw.Font font) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildInvoiceInfo(invoiceData, font),
              buildCustomerAddress(invoiceData, font),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(invoiceData, pw.Font font) {
    final titles = <String>[
      'Customer:',
      'Contact:',
      'Tujuan:',
    ];
    final data = <String>[
      '${invoiceData.delivery.purchaseOrder.customersName}',
      '${invoiceData.delivery.purchaseOrder.phone}',
      '${invoiceData.delivery.purchaseOrder.address}',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 170, font: font);
      }),
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(
    //       customer.name,
    //       style: TextStyle(fontWeight: FontWeight.bold, font: font),
    //     ),
    //     Text(customer.contact, style: TextStyle(font: font)),
    //     Text(customer.tujuan, style: TextStyle(font: font)),
    //   ],
    // );
  }

  static Widget buildInvoiceInfo(invoiceData, pw.Font font) {
    final titles = <String>[
      'Tanggal Kirim:',
      'Pembayaran:',
    ];
    final data = <String>[
      Utils.formatDate(invoiceData.delivery.purchaseOrder.deliveryDate),
      'Tranfer',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 150, font: font);
      }),
    );
  }

  // static Widget buildTitle(Invoice invoice, pw.Font font) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Text(
  //         //   'INVOICE',
  //         //   style: TextStyle(
  //         //       fontSize: 24, fontWeight: FontWeight.bold, font: font),
  //         // ),
  //         // SizedBox(height: 0.8 * PdfPageFormat.cm),
  //         Text(invoice.info.description, style: TextStyle(font: font)),
  //         SizedBox(height: 0.8 * PdfPageFormat.cm),
  //       ],
  //     );

  static Widget buildInvoice(invoiceData, pw.Font font) {
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
    // final data = invoice.items.map((item) {
    //   final total = item.harga * item.jumlah;

    // return [
    //   "${item.no}",
    //   '${item.produk}',
    //   '${item.unit}',
    //   '${item.qty}',
    //   '${item.tonase}',
    //   '${item.harga}',
    //   '${item.diskon}',
    //   '${item.jumlah}',
    //   ];
    // }).toList();

    final data = [
      [
        "1", // Baris pertama
        '${invoiceData.delivery.purchaseOrder.productName}',
        '${invoiceData.delivery.purchaseOrder.productId.toString()}',
        '${invoiceData.delivery.purchaseOrder.quantity}',
        '${invoiceData.delivery.purchaseOrder.quantity} Kg',
        '${currencyFormatter.format(double.parse(invoiceData.delivery.purchaseOrder.price))}',
        invoiceData.delivery.purchaseOrder.discountType == "nominal"
            ? '${currencyFormatter.format(double.tryParse(invoiceData.delivery.purchaseOrder.discount)?.toInt())}'
            : '${invoiceData.delivery.purchaseOrder.discount.toString()}',
        '${currencyFormatter.format(double.parse(invoiceData.delivery.purchaseOrder.totalPrice))}',
      ]
    ];

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

  static Widget buildTotal(invoiceData, pw.Font font) {
    // final total = invoice.items
    //     .map((item) => item.harga * item.jumlah)
    //     .reduce((item1, item2) => item1 + item2);
    final total = int.parse(invoiceData.delivery.purchaseOrder.totalPrice);

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
                  value: currencyFormatter.format(total),
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

  static Widget buildFooter(pw.Font font) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Divider(),
          pw.Text(
            "PT SAGE MASHLAHAT INDONESIA",
          ),
          // SizedBox(height: 1 * PdfPageFormat.mm),
          // buildSimpleText(
          //     title: 'Address', value: invoice.supplier.address, font: font),
          // SizedBox(height: 1 * PdfPageFormat.mm),
          // buildSimpleText(
          //     title: 'SAGE MASHLAHAT INDONESIA BCA - ',
          //     value: invoice.supplier.paymentInfo,
          //     font: font),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
    required pw.Font font,
  }) {
    final style =
        TextStyle(fontWeight: FontWeight.bold, font: font, fontSize: 14);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold, font: font, fontSize: 14)),
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
