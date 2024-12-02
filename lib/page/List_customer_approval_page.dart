import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/controllers/approved_controller.dart';
import 'package:pt_sage/models/approvelPo.dart';
import 'package:pt_sage/models/purchase_order.dart';
import 'package:pt_sage/page/detail_po_approve_page.dart';
import 'package:pt_sage/page/invoice_page.dart';
import 'package:pt_sage/page/po_detail_page.dart';
import '../controllers/purchase_order_controller.dart';
import '../models/approveCustomer.dart';
import 'detail_approve_customer.dart';
import 'home_page.dart';

class ListCustomerApprovel extends StatefulWidget {
  const ListCustomerApprovel({Key? key}) : super(key: key);

  @override
  State<ListCustomerApprovel> createState() => _ListCustomerApprovelState();
}

class _ListCustomerApprovelState extends State<ListCustomerApprovel> {
  late Future<List<Customer>?> customers;

  @override
  void initState() {
    super.initState();
    customers = fetchApprovalCustomer();
    print(customers);
  }

  Future<List<Customer>?> fetchApprovalCustomer() async {
    final poController = ApprovedController();
    List<Customer>? fetchedCustomer = await poController.getCustomerData();
    return fetchedCustomer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pelanggan Approval",
          style: TextStyle(
            color: Color(0xffBF1619),
            fontFamily: GoogleFonts.rubik().fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => HomePage());
          },
          icon: Image.asset('assets/LineRed.png'),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: FutureBuilder<List<Customer>?>(
        future: customers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Error: ${snapshot.error}")); // Show error if any
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada data")); // No data case
          } else {
            final customerList = snapshot.data!;
            return ListView.builder(
              itemCount: customerList.length,
              itemBuilder: (context, index) {
                final customer = customerList[index];
                return ListTile(
                  leading: Container(
                    width: 40, // Set width to keep it within the leading slot
                    alignment: Alignment
                        .center, // Centers the icon within the container
                    child: Icon(Icons.person),
                  ), // Center the icon vertically
                  title: Text("No MoU: ${customer.noMoU}"),
                  subtitle: Text(customer.customersName),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(() => DetailCustomerApprovalPage(),
                        arguments: customer);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
