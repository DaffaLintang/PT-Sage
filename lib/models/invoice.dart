import 'package:pt_sage/models/customer.dart';
import 'package:pt_sage/models/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  // final String number;
  final DateTime TanggalKirim;
  final String Pembayaran;

  const InvoiceInfo({
    required this.description,
    // required this.number,
    required this.TanggalKirim,
    required this.Pembayaran,
  });
}

class InvoiceItem {
  final int no;
  final String produk;
  final int unit;
  final int qty;
  final double tonase;
  final double harga;
  final double diskon;
  final double jumlah;

  const InvoiceItem({
    required this.no,
    required this.produk,
    required this.unit,
    required this.qty,
    required this.tonase,
    required this.harga,
    required this.diskon,
    required this.jumlah,
  });
}
