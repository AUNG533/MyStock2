// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_function_declarations_over_variables
// login_form.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_stock/src/config/theme.dart' as custom_theme;

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildForm(),
        _buildSubmitFormButton(),
      ],
    );
  }

  Card _buildForm() => Card(
        margin: EdgeInsets.only(bottom: 22, left: 22, right: 22),
        elevation: 2.0, // เงา
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0) // โคงมุง
            ),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: FormInput(),
        ),
      );

  Container _buildSubmitFormButton() => Container(
        width: 220,
        height: 50,
        decoration: _boxDecoration(),
      );

  BoxDecoration _boxDecoration() {
    const gradientStart = custom_theme.Theme.gradientStart; // ตัวแปรสี
    const gradientEnd = custom_theme.Theme.gradientEnd; // ตัวแปรสี
    // function BoxShadow // เงา รอบนนก
    final boxShadowItem = (Color color) => BoxShadow(
          color: color,
          offset: Offset(1.0, 6.0), // x , y
          blurRadius: 20.0, // เบลือ / จาง
        );

    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5.0)), // โคงมุง
      boxShadow: [
        boxShadowItem(gradientStart),
        boxShadowItem(gradientEnd),
      ],
      // สไลต์สี ซาย ไป ขวา
      gradient: LinearGradient(
        colors: [
          gradientEnd,
          gradientStart,
        ],
        begin: const FractionalOffset(0.0, 0.0), // x , y
        end: const FractionalOffset(1.0, 1.0), // x , y
        stops: [0.0, 1.0],
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
        border: InputBorder.none,
        // ไม่มีเส้นแบง
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
