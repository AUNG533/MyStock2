// home.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/constants/assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.name, required this.age}) : super(key: key);

  // สำหับ ส่ง required และรับค่ากลับมา
  final String name;
  final int age;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          }, child: Text('back')),
          Text(widget.name), // แสดงค่าที่ส่งมาจาก login_form.dart
          Text(widget.age.toString()), // แสดงค่าที่ส่งมาจาก login_form.dart
          // Asset Image
          Image.asset(Assets.logoIMAGE),
          // Network Image
          Image.network('https://www.somkiat.cc/wp-content/uploads/2021/08/flutter-1024x486.png')
        ],
      )
    );
  }
}
