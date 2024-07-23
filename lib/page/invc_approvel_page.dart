import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pt_sage/page/invoice_page.dart';
import 'home_page.dart';

class ListInvcApprovePage extends StatefulWidget {
  const ListInvcApprovePage({Key? key}) : super(key: key);

  @override
  State<ListInvcApprovePage> createState() => _ListInvcApprovePageState();
}

class _ListInvcApprovePageState extends State<ListInvcApprovePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Invoice Approvel",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Slidable(
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    // dismissible:
                    //     DismissiblePane(onDismissed: () {}),
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (_) {},
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (_) {},
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.assignment_turned_in_rounded,
                        label: 'Approve',
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: ListTile(
                        title: Text("INVC0001",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff9E0507)))),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
