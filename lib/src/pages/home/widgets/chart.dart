// ignore_for_file: prefer_const_constructors
// chart.dart
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterLogo(
        style: FlutterLogoStyle.horizontal, size: 450,
      ),
    );
  }
}

