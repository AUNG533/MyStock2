// app.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/pages/login/login_page.dart';
import 'package:my_stock/src/config/route.dart' as custom_route;

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
      home: const LoginPage(),
    );
  }
}
