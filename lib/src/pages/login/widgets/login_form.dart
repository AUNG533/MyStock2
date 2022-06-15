// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_function_declarations_over_variables, deprecated_member_use, use_build_context_synchronously
// login_form.dart
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_stock/src/config/theme.dart' as custom_theme;
import 'package:my_stock/src/utils/regex_validator.dart';
import 'package:my_stock/src/config/route.dart' as custom_route;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/setting.dart';

// convert to stateful widget
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // สำหรับ รับค่า จาก FormInput (Map กับ controller FormInput)
  TextEditingController? usernameController;
  TextEditingController? passwordController;

  // สำหรับ รับค่า error จาก FormInput
  String? _errorUsername;
  String? _errorPassword;

  // เช็คสทาณะ
  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  // ทิ่ง เมื่อเสร็จ
  @override
  void dispose() {
    usernameController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter, // ให้ Widget อยู่ ล่างกลาง
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
          padding:
              const EdgeInsets.only(top: 20, bottom: 58, left: 28, right: 28),
          child: FormInput(
            // รับค่า username และ password พ่าน controller จาก TextField ใน Class FormInput
            usernameController: usernameController,
            passwordController: passwordController,
            // รับค่า error username และ password จาก FormInput
            errorUsername: _errorUsername,
            errorPassword: _errorPassword,
          ),
        ),
      );

  // Container LoginButton
  Container _buildSubmitFormButton() => Container(
        width: 220,
        height: 50,
        decoration: _boxDecoration(),
        // Login Button
        child: FlatButton(
          onPressed: _onLogin, // กดปุ่ม Login
          child: Text(
            'LOGIN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );

  BoxDecoration _boxDecoration() {
    const gradientStart = custom_theme.Theme.gradientStart; // ตัวแปรสี
    const gradientEnd = custom_theme.Theme.gradientEnd; // ตัวแปรสี
    // function BoxShadow // เงา รอบนอก
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

  void showAlertBar() {
    Flushbar(
      title: "Username or Password is incorrect",
      message: 'Please try again.',
      icon: Icon(
        Icons.error,
        size: 28.0,
        color: Colors.red,
      ),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }

  void showLoadingBar() {
    Flushbar(
      message: 'Please wait.',
      showProgressIndicator: true,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
    ).show(context);
  }

  // กดปุ่ม Login
  void _onLogin() {
    // รับ และ เก็บ ค่าจาก FormInput
    String username = usernameController!.text;
    String password = passwordController!.text;
    // Clear Error Message
    _errorUsername = null;
    _errorPassword = null;
    // Check Username
    if (!EmailSubmitRegexValidator().isValid(username)) {
      _errorUsername = 'The Email must be a valid email email.';
    }
    // Check Password
    if (password.length < 8) {
      _errorPassword = 'Mute be at least 8 characters.';
    }
    // ถ้าไม่มีข้อผิดพลาด
    if (_errorUsername == null && _errorPassword == null) {
      showLoadingBar();
      Future.delayed(Duration(seconds: 2)).then((value) async {
        Navigator.pop(context);
        if (username == 'example@gmail.com' && password == '12345678') {

          final prefs = await SharedPreferences.getInstance();
          prefs.setString(Setting.tokenPref, 'adldieldieldofjappkoasfjie'); // เก็บค่า token
          prefs.setString(Setting.usernamePref, username); // เก็บค่า username

          Navigator.pushReplacementNamed(context, custom_route.Route.home);
        } else {
          showAlertBar();
          setState(() {});
        }
        setState(() {});
      });
    } else {
      setState(() {});
    }
  }
}

class FormInput extends StatefulWidget {
  // สำหรับ ส่งค่า username และ password จาก TextField ไป class LoginForm
  final TextEditingController? usernameController;
  final TextEditingController? passwordController;

  // สำหรับ ส่งค่า error ไป class LoginForm
  final String? errorUsername;
  final String? errorPassword;

  const FormInput({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.errorUsername,
    required this.errorPassword,
  }) : super(key: key);

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  final _color = Colors.black54;

  bool? _obscureTextPassword; // สำหรับ ซ่อม หรือ แสดง รหัสผ่าน
  FocusNode? _passwordFocusNode; // สำหรับ Focus ไปที่ TextField รหัสผ่าน

  // เช็คสถานะ
  @override
  initState() {
    _obscureTextPassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUsername(), // function return TextField
        // เส้นแบง
        Divider(
          height: 22, // ความสุงรวม (บน + ล่าง)
          thickness: 1, // ความหนา
          indent: 13, // แบงขาง ขวา
          endIndent: 13, // แบงขาง ซาย
        ),
        _buildPassword(), // function return TextField
      ],
    );
  }

  // ตัวแปรส style
  TextStyle _textStyle() =>
      TextStyle(fontWeight: FontWeight.w500, color: _color);

  TextField _buildUsername() => TextField(
        controller: widget.usernameController,
        // ส่งค่าออก
        // ตกแตงด้วย decoration
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Email Address',
          labelStyle: _textStyle(),
          hintText: 'example@gmail.com',
          icon: FaIcon(
            FontAwesomeIcons.envelope,
            size: 22.0,
            color: _color,
          ),
          errorText: widget.errorUsername, // ส่งค่า / แสดง error
        ),
        // layout ของ keyboard
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        // กด enter เพื่อ focus ไปที่ password
        onSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
      );

  TextField _buildPassword() => TextField(
        controller: widget.passwordController, // ส่งค่าออก
        // ตกแตงด้วย decoration
        decoration: InputDecoration(
          // ไม่มีเส้นแบง
          border: InputBorder.none,
          labelText: 'Password',
          labelStyle: _textStyle(),
          icon: FaIcon(
            FontAwesomeIcons.lock,
            size: 22.0,
            color: _color,
          ),
          // ส่งค่า / แสดง error
          errorText: widget.errorPassword,
          // ปุ่ม แสดงรหัสผ่าน
          suffixIcon: IconButton(
            icon: Icon(
              _obscureTextPassword!
                  ? FontAwesomeIcons.eye
                  : FontAwesomeIcons.eyeSlash,
              size: 15.0,
              color: _color,
            ),
            onPressed: () {
              setState(() {
                _obscureTextPassword = !_obscureTextPassword!;
              });
            },
          ),
        ),
        obscureText: _obscureTextPassword!, // ซ่อมตัวนังสือ ให้เป็น ....
      );
}
