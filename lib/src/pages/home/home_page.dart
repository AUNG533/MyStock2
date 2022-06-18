// home_page.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stock/src/pages/home/widgets/custom_drawer.dart';
import 'package:my_stock/src/pages/home/widgets/custom_tabbar.dart';
import 'package:my_stock/src/viewmodels/tabbar_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tabMenu = TabMenuViewModel().items; // List of tab menu

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabMenu.length, // Number of tab
      child: Scaffold(
        appBar: _buildAppBar(), // Method to build app bar
        drawer: const CustomDrawer(), // Drawer
        body: TabBarView(
          children: _tabMenu.map((item) => item.widget!).toList(), 
        ),
      ),
    );
  }

  // Method to build app bar
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('My Workshop'),
      bottom: CustomTabBar(_tabMenu), // TabBar
      // Widget ด้านซ้ายใน AppBar
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark_border),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.qr_code),
          onPressed: () {},
        ),
      ],
    );
  }
}
