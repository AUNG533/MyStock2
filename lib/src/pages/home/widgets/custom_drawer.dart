import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          // ปุม logout
          FlatButton(onPressed: () {}, child: const Text('logout')),
        ],
    );
  }
}
