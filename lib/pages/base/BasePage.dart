import 'package:devlomatix/pages/shop/pages/home.dart';

import 'package:devlomatix/pages/home/home.dart';
import 'package:devlomatix/pages/profile/profile.dart';
import 'package:devlomatix/pages/setting/settings.dart';
import 'package:devlomatix/pages/shop/pages/wishlist.dart';
import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasePage extends StatelessWidget {
  static String routeName = "/base";
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    final List<Widget> _childrens = [
      GroceryHome(),
      Profile(),
      Profile(),
      Wishlist(),
      Setting()
    ];

    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            print('Base page on will pop scome');
            return true;
          },
          child: _childrens[provider.bottonNavIndex]),
      bottomNavigationBar: buidBottomNavBar(context),
    );
  }
}
