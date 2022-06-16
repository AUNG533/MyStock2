// custom_drawer.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_stock/src/config/route.dart' as custom_route;
import 'package:my_stock/src/constants/setting.dart';
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
}
