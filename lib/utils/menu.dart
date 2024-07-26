import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Menu extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String imageAsset;

  Menu({
    required this.onTap,
    required this.title,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 127,
        width: 150,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(4, 5),
              ),
            ],
            border: Border.all(
              color: Color(0xff9E0507), // Warna border
              width: 2.0, // Lebar border
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcATop,
                        ),
                        image: AssetImage(imageAsset))),
              ),
              Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    // color: Color(0xff9E0507)),
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
