// home_page.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stock/src/pages/home/widgets/chart.dart';
import 'package:my_stock/src/pages/home/widgets/custom_drawer.dart';
import 'package:my_stock/src/pages/home/widgets/custom_tabbar.dart';
import 'package:my_stock/src/pages/home/widgets/report.dart';
import 'package:my_stock/src/pages/home/widgets/stock.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Workshop'),
          bottom: const CustomTabBar(), // TabBar
        ),
        drawer: const CustomDrawer(), // Drawer
        body: const TabBarView(
          children: [
            Stock(),
            Chart(),
            Report(),
          ],
        ),
      ),
    );
  }
}
