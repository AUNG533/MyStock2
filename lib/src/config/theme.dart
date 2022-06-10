// https://uigradients.com/#Frost
// #000428 → #004e92 to 0xFF000428 -> 0xFF004e92

import 'package:flutter/cupertino.dart';

class Theme {
  const Theme(); // ให้ตังแปรใน Class นี้ เป็นค่าสิ่นสุด

  static const Color gradientStart = Color(0xFF000428);
  static const Color gradientEnd = Color(0xFF004e92);

  // กำนวด เทพทางสไลต์สี จากบนกลาง ไป ล่างกลาง
  static const gradient = LinearGradient(
      colors: [gradientStart, gradientEnd],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0]); // ค่า จากแข็ง ไป อ่อน
}
