// ignore_for_file: prefer_const_constructors
// lib/src/config/route.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/pages/pages.dart'; // รับ path ทังหมดมาจาก pages.dart

class Route {
  static const home = '/home';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const management = '/management';

  static Map<String, WidgetBuilder> getAll() => _route;

  static final Map<String, WidgetBuilder> _route = {
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    dashboard: (context) => DashBoardPage(),
    management: (context) => ManagementPage(),
  };
}