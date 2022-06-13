// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// login_page.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/config/theme.dart' as custom_theme;
import 'package:my_stock/src/pages/login/widgets/header.dart';
import 'package:my_stock/src/pages/login/widgets/login_form.dart';
import 'package:my_stock/src/pages/login/widgets/single_sign_on.dart';

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
              LoginForm(), // เรียกใช Widget จาก lib/src/pages/login/widgets/login_form.dart
              Text('forgot password', style: TextStyle(color: Colors.white)),
              SingleSignOn(), // เรียกใช Widget จาก lib/src/pages/login/widgets/single_sign_on.dart
              Text('register', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}

