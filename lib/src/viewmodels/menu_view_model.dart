import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_stock/src/config/route.dart' as custom_route;

// สำหรับ menu ListTile
class Menu {
  final String? title;
  final IconData? icon;
  final Color? iconColor;
  final Function(BuildContext context)? onTap;

  // constructor
  Menu({
    this.title,
    this.icon,
    this.iconColor,
    this.onTap,
  });
}

// Model Menu
class MenuViewModel {
  // List Menu
  List<Menu> get items => <Menu>[
    // Profile
    Menu(
      title: 'Profile',
      icon: FontAwesomeIcons.users,
      iconColor: Colors.deepOrange,
    ),
    // Dashboard
    Menu(
      title: 'Dashboard',
      icon: FontAwesomeIcons.chartPie,
      iconColor: Colors.green,
      onTap: (context) => Navigator.pushNamed(
        context,
        custom_route.Route.dashboard,
      ),
    ),
    // Inbox
    Menu(
      title: 'Inbox',
      icon: FontAwesomeIcons.inbox,
      iconColor: Colors.amber,
    ),
    // Setting
    Menu(
      title: 'Settings',
      icon: FontAwesomeIcons.cogs,
      iconColor: Colors.blueGrey,
    ),
  ];
}