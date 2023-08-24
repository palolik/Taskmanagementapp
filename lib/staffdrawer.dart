import 'package:flutter/material.dart';
import 'package:k9k10connect/pages/report.dart';
import 'package:k9k10connect/staff_pages/newspage_staff.dart';
import 'package:k9k10connect/staff_pages/status_staff.dart';
import 'package:k9k10connect/staffhomepage.dart';
import 'pages/profile.dart';

class MyStaffDrawer extends StatelessWidget{
  const MyStaffDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.grey,),
            accountName: Text(
              "Nur Amirah",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              "amirah@gmail.com",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: FlutterLogo(),
          ),

          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StaffHomepage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
            ),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserProfilePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.pending_actions,
            ),
            title: const Text('Status'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StatusStaffPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.warning,
            ),
            title: const Text('Report'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const report()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.article,
            ),
            title: const Text('News'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsStaffPage()),
              );
            },
          ),
        ],
      ),
    );
  }

}