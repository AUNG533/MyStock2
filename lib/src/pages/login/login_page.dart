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
          // แก่ปัญหา Overflow ด้วย SingleChildScrollView
          SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                LoginForm(),
                SizedBox(height: 30),
                _buildFlatButton('Forgot Password', onPressed: () {}),
                SingleSignOn(),
                SizedBox(height: 30),
                _buildFlatButton("Don't have an Account", onPressed: () {}),
                SizedBox(height: 80),
                // เพื่อให้มีช่องว่างด้านล่าง
              ],
            ),
          ),
        ],
      ),
    );
  }

  FlatButton _buildFlatButton(
    String text, {
    required VoidCallback onPressed,
    double fontSize = 16.0,
  }) =>
      FlatButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
}
