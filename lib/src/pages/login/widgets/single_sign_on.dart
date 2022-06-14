// single_sign_on.dart
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:my_stock/src/viewmodels/single_sign_on_view_model.dart';

class SingleSignOn extends StatelessWidget {
  const SingleSignOn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivider(),
        SizedBox(height: 12),
        _buildSingleSignOnButton(), // แถวปุ่มการเข้าสู่ระบบด้วยบัญชีอื่น
      ],
    );
  }

  Row _buildDivider() {
    const gradientColor = [Colors.white10, Colors.white];
    // ignore: prefer_function_declarations_over_variables
    final line = (List<Color> colors) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0],
            ),
          ),
          width: 80.0,
          height: 1.0,
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        line(gradientColor),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text('or',
              style: TextStyle(color: Colors.white60, fontSize: 16.0)),
        ),
        line(gradientColor.reversed.toList()),
      ],
    );
  }

  // สร้างปุ่มการเข้าสู่ระบบด้วยบัญชีอื่น (Single Sign On)
  Padding _buildSingleSignOnButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // เรียกใช้ค่า view model จาก single_sign_on_view_model.dart
          children: SingleSignOnViewModel()
              .items
              .map(
                (item) => FloatingActionButton(
                  heroTag: item.icon
                      .toString(), //ใชชื่อ icon แทนชื่อที่ใช้ในการสร้าง hero tag
                  onPressed: item.onPressed,
                  backgroundColor: item.backgroundColor,
                  child: Icon(
                    item.icon,
                    color: Colors.white,
                  ),
                ),
              )
              .toList(),
        ),
      );
}
