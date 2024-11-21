import 'package:sp_util/sp_util.dart';

final String MainUrl = "https://0955-103-160-183-15.ngrok-free.app";

final int? roles = SpUtil.getInt('roles');
final String LoginAPI = "${MainUrl}/api/login";
final String PoAPI = roles == 1
    ? "${MainUrl}/api/purchase-orders"
    : "${MainUrl}/api/purchase-order";
final String PoCreateAPI = "${PoAPI}/create";
final String PoStoreAPI = "${PoAPI}/store";
final String KuisionerPosisiBersaingApi = roles == 1
    ? "${MainUrl}/api/posisi-bersaing"
    : "${MainUrl}/api/kuisioner-posisi-bersaing";
final String IndeksAspek = "${MainUrl}/api/indeks-aspek";
final String KepuasanPelanggan = roles == 1
    ? "${MainUrl}/api/kepuasan-pelanggan"
    : "${MainUrl}/api/kuisioner-kepuasan-pelanggan";
final String ApprovelPo =
    roles == 1 ? "${MainUrl}/api/approvel" : "${PoAPI}/approvel";
final String Delivery =
    roles == 1 ? "${MainUrl}/api/delivery" : "${MainUrl}/api/data-delivery";
final String InvoiceApi =
    roles == 1 ? "${MainUrl}/api/invoices" : "${MainUrl}/api/data-invoice";
final String KeluhanApi = roles == 1
    ? "${MainUrl}/api/keluhan-pelanggan"
    : "${MainUrl}/api/data-keluhan-pelanggan";
final String AdminKeluhanApi = roles == 1
    ? "${MainUrl}/api/admin-keluhan-pelanggan"
    : "${MainUrl}/api/data-penanganan-keluhan-pelanggan";
final String PaymentApi =
    roles == 1 ? "${MainUrl}/api/payment" : "${MainUrl}/api/data-payment";
final String ApprovelPO = roles == 1
    ? "${MainUrl}/api/purchase-orders"
    : "${MainUrl}/api/purchase-order/get-approvel-po";
final String MenuApi = "${MainUrl}/api/menus";
final String DataProductLot = roles == 1
    ? "${MainUrl}/api/product-lot"
    : "${MainUrl}/api/data-product-lot";
final String DataApproveCustomer = roles == 1
    ? "${MainUrl}/api/approval-customer"
    : "${MainUrl}/api/data-approval-customer";
final String TransaksiPo = roles == 1
    ? "${MainUrl}/api/delivery"
    : "${MainUrl}/api/data-purchase-order";
