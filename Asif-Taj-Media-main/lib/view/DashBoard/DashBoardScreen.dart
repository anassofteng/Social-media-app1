import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/ViewModel/Services/Sessionmanager.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'Profile.dart';
import 'Users/User_list_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

final controler = PersistentTabController(initialIndex: 0);

class _DashBoardState extends State<DashBoard> {
  List<Widget> _buildScren() {
    return [
      SafeArea(
        child: Text(
          'Home',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      Text('Chat'),
      Text('Add'),
      UserListScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        inactiveIcon: Icon(
          Icons.home,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        inactiveIcon: Icon(
          Icons.message,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add),
        inactiveIcon: Icon(
          Icons.add,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        inactiveIcon: Icon(
          Icons.home,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outline),
        inactiveIcon: Icon(
          Icons.person_outline,
          color: Colors.grey.shade100,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScren(),
      items: _navBarItem(),
      controller: controler,
      backgroundColor: AppColors.inputTextBorderColor,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.red,
        borderRadius: BorderRadius.circular(1),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
