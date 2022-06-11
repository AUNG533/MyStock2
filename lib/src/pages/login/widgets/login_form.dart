// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: FormInput(),
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  final _color = Colors.black54; // ตัวแปรสี

  const FormInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUsername(), // function return TextField
        // เส้นแบง
        Divider(
          height: 22, // ความสุงรวม (บน + ล่าง)
          thickness: 1, // ความหนา
          indent: 13, // แบงขาง ควา
          endIndent: 13, // แบงขาง ซาย
        ),
        _buildPassword(), // function return TextField
      ],
    );
  }

  // ตัวแปรส style
  TextStyle _textStyle() =>
      TextStyle(fontWeight: FontWeight.w500, color: _color);

  TextField _buildUsername() {
    return TextField(
      // ตกแตงด้วย decoration
      decoration: InputDecoration(
        border: InputBorder.none, // ไม่มีเส้นแบง
        labelText: 'Email Address',
        labelStyle: _textStyle(),
        hintText: 'example@gmail.com',
        icon: FaIcon(
          FontAwesomeIcons.envelope,
          size: 22.0,
          color: _color,
        ),
      ),
    );
  }

  TextField _buildPassword() {
    return TextField(
      // ตกแตงด้วย decoration
      decoration: InputDecoration(
        border: InputBorder.none, // ไม่มีเส้นแบง
        labelText: 'Password',
        labelStyle: _textStyle(),
        icon: FaIcon(
          FontAwesomeIcons.lock,
          size: 22.0,
          color: _color,
        ),
      ),
      obscureText: true, // ซ่อมตัวนังสือ ให้เป็น ....
    );
  }
}
