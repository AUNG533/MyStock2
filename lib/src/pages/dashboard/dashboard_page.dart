// dashboard_page.dart
import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('appbarTitle'),
      ),
      body: const Center(
        child: FlutterLogo(
          size: 150,
        ),
      ),
    );
  }
}
