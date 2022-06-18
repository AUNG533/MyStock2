// custom_tabbar.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_stock/src/viewmodels/tabbar_view_model.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {

  final List<TabMenu> tabMenu; // List of tab menu

  const CustomTabBar(this.tabMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabMenu
          .map(
            (item) => Tab(
              child: Row(
                children: [
                  FaIcon(item.icon),
                  const SizedBox(width: 12), // Space between icon and text
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
