// app.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/constants/setting.dart';
import 'package:my_stock/src/config/route.dart' as custom_route;
import 'package:my_stock/src/pages/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: custom_route.Route.getAll(), // รับ path ทังหมดมาจาก route.dart
      title: 'My Stock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(), // รับค่า SharedPreferences
          builder: (context, snapshot) {
            // ตรวจสอบว่ามีการ login หรือไม่
            if (snapshot.hasData) {
              // ถ้ามีค่าจะดึงค่าจาก SharedPreferences
              final token = snapshot.data?.getString(Setting.tokenPref) ?? '';
              if (token.isNotEmpty) {
                return const HomePage(); // ถ้ามี token แสดงหน้า HomePage
              }
              return const LoginPage(); // ถ้าไม่มี token ให้ไปที่ login page
            }
            return const SizedBox(); // ถ้าไม่มีข้อมูลจะแสดงหน้าว่าง
          }),
    );
  }
}
