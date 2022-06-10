// header.dart
import 'package:flutter/material.dart';
import 'package:my_stock/src/constants/assets.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80, bottom: 38),
      child: Image.asset(
        Assets.headerIMAGE,
        height: 100,
      ),
    );
  }
}