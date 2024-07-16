import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pt_sage/page/Pengiriman_barang.dart';
import 'package:pt_sage/page/Purchase_page.dart';
import 'package:pt_sage/page/feedback_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    PengirimanBarangPage(),
    PurchasePage(),
    FeedBackPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
            gap: 8,
            onTabChange: _onTabTapped,
            padding: EdgeInsets.all(16),
            tabBackgroundColor: Color(0xff7CD154),
            tabs: [
              GButton(
                icon: Icons.delivery_dining_outlined,
                text: "Pengiriman",
              ),
              GButton(
                icon: Icons.shopping_cart_outlined,
                text: "Purchase Order",
              ),
              GButton(
                icon: Icons.feedback_outlined,
                text: "Feedback ",
              ),
              GButton(
                icon: Icons.file_copy_outlined,
                text: "Invoice ",
              ),
            ]),
      ),
    );
  }
}
