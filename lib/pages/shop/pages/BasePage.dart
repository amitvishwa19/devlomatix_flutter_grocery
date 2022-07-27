import 'package:devlomatix/pages/shop/pages/home.dart';

import 'package:devlomatix/pages/profile/profile.dart';
import 'package:devlomatix/pages/setting/settings.dart';
import 'package:devlomatix/pages/shop/pages/orders.dart';
import 'package:devlomatix/pages/shop/pages/wishlist.dart';
import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BasePage extends StatelessWidget {
  static String routeName = "/base";
  BasePage({Key? key}) : super(key: key);

  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    final List<Widget> _childrens = [
      const GroceryHome(),
      const Orders(),
      const Profile(),
      const Wishlist(),
      const Setting()
    ];

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= const Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            //show snackbar

            if (provider.bottonNavIndex == 0) {
              Fluttertoast.showToast(msg: "Press back again to exit the App");
            } else {
              provider.changeBottomNav(0);
            }

            return false;
          } else {
            return true;
          }
        },
        child: _childrens[provider.bottonNavIndex],
      ),
      bottomNavigationBar: buidBottomNavBar(context),
    );
  }
}
