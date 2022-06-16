// home_page.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stock/src/constants/assets.dart';
import 'package:my_stock/src/pages/home/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Workshop'),
      ),
      drawer: const CustomDrawer(), // Drawer
      body: Image.asset(Assets.logoIMAGE),
    );
  }
}
