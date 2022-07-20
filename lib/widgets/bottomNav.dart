import 'package:devlomatix/pages/home/home.dart';
import 'package:devlomatix/pages/profile/profile.dart';
import 'package:devlomatix/pages/setting/settings.dart';
import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

BottomNavigationBar buidBottomNavBar(context) {
  AppProvider provider = Provider.of<AppProvider>(context);
  final List<Widget> _childrens = [];
  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.house,
            size: 18,
          ),
          label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.solidBell,
            size: 18,
          ),
          label: 'Notifications'),
      BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.solidUser,
            size: 18,
          ),
          label: 'Profile'),
      BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.solidHeart,
            size: 18,
          ),
          label: 'Wishlist'),
      BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.gear,
            size: 18,
          ),
          label: 'Setting'),
    ],
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.shifting,
    currentIndex: provider.bottonNavIndex,
    onTap: (value) {
      provider.changeBottomNav(value);
      switch (value) {
        case 0:
          //Navigator.pushNamed(context, Home.routeName);
          break;

        case 1:
          break;

        case 2:
          //Navigator.pushNamed(context, Profile.routeName);
          break;

        case 3:
          //Navigator.pushNamed(context, Setting.routeName);
          break;

        case 4:
          //Navigator.pushNamed(context, Setting.routeName);
          break;
      }
    },
  );
}
