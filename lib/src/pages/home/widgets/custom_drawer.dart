// custom_drawer.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_stock/src/config/route.dart' as custom_route;
import 'package:my_stock/src/constants/setting.dart';
import 'package:my_stock/src/viewmodels/menu_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// convert to StatefulWidget
class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfile(),
          ..._buildMainMenu(), // List Menu ListTile
          const Spacer(), // ดัน widget ให้อยู่ด้านล่าง
          // ListTile Logout
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.grey,
            ),
            title: const Text('Logout'),
            onTap: showDialogLogout, // dialog สำหรับ logout
          ),
        ],
      ),
    );
  }

  void showDialogLogout() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            // ปุ่มยกเลิก
            FlatButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // ปิด dialog
              },
            ),
            // ปุ่มตกลง Logout
            FlatButton(
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove(Setting.tokenPref); // ลบค่า token
                  // prefs.clear(); // ลบค่าทั้งหมดออกจาก SharedPreferences
                  Navigator.of(dialogContext).pop(); // ปิด dialog
                  // ไปหน้า login และ ลบหน้าทั้งหมดออก
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    custom_route.Route.login,
                    (route) => false,
                  );
                });
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  UserAccountsDrawerHeader _buildProfile() => UserAccountsDrawerHeader(
        // decoration: BoxDecoration(color: Colors.red),
        accountName: Text('John Doe'),
        accountEmail: Text('hongsar@gmail.com'),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://cdn-images-1.medium.com/max/280/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png'),
        ),
      );

  // สำหรับการสร้าง ListTile ของ menu
  List<ListTile> _buildMainMenu() => MenuViewModel().items.map((item) {
        return ListTile(
          leading: FaIcon(
            item.icon,
            color: item.iconColor,
          ),
          title: Text(
            item.title!,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          onTap: () {
            // Navigator.of(context).pop(); // ปิด drawer
            item.onTap!(context);
          },
        );
      }).toList();
}
