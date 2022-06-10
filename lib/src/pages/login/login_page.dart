// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// login_page.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/config/theme.dart' as custom_theme;
import 'package:my_stock/src/pages/login/widgets/header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // กระจ่ายเต็ม
        children: [
          // ใช้ Container เพื่อตกแตง // decoration ในการ ตกแตง
          Container(
            decoration: BoxDecoration(
              gradient: custom_theme.Theme.gradient,
            ),
          ),
          Column(
            children: [
              Header(), // เรียกใช Widget จาก lib/src/pages/login/widgets/header.dart
              Text('form', style: TextStyle(color: Colors.white)),
              Text('forgot password', style: TextStyle(color: Colors.white)),
              Text('SSO', style: TextStyle(color: Colors.white)),
              Text('register', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}


