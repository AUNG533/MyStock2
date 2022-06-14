// single_sign_on_view_model.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SingleSignOn {
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onPressed;

  SingleSignOn({
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
  });
}

class SingleSignOnViewModel {
  List<SingleSignOn> get items => <SingleSignOn>[
        SingleSignOn(
          icon: FontAwesomeIcons.apple,
          backgroundColor: Color(0xFF323232),
          onPressed: () {
            // todo
          },
        ),
        SingleSignOn(
          icon: FontAwesomeIcons.google,
          backgroundColor: Color(0xFFd7483b),
          onPressed: () {
            // todo
          },
        ),
        SingleSignOn(
          icon: FontAwesomeIcons.facebook,
          backgroundColor: Color(0xFF4063ae),
          onPressed: () {
            // todo
          },
        ),
        SingleSignOn(
          icon: FontAwesomeIcons.line,
          backgroundColor: Color(0xFF21b54d),
          onPressed: () {
            // todo
          },
        ),
      ];
}
