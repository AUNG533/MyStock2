// ignore_for_file: prefer_const_constructors
// route.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/pages/pages.dart'; // รับ path ทังหมดมาจาก pages.dart

class Route {
  static const String home = '/home';
  static const String login = '/login';

  static Map<String, WidgetBuilder> getAll() => _route;

  static final Map<String, WidgetBuilder> _route = {
    home: (context) => HomePage(age: 30, name: 'John'),
    login: (context) => LoginPage(),
  };
}