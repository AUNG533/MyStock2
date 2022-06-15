// home_page.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stock/src/constants/assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // static Object? argument = ModalRoute.of(context)!.settings.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ปุมกดกลับ
          FlatButton(onPressed: () {
            // เช็คสถานะ ถ้ามีหน้ากลับได้หรือไม่
            if (Navigator.canPop(context)) {
              Navigator.pop(context); // กลับหน้าก่อนหน้า
            }
          }, child: const Text('back')),
          // Asset Image
          Image.asset(Assets.logoIMAGE),
          // Network Image
          Image.network('https://www.somkiat.cc/wp-content/uploads/2021/08/flutter-1024x486.png')
        ],
      )
    );
  }
}
