import 'package:devlomatix/pages/auth/auth.dart';
import 'package:devlomatix/pages/base/BasePage.dart';
import 'package:devlomatix/pages/shop/pages/address_selection.dart';
import 'package:devlomatix/pages/shop/pages/allCategories.dart';
import 'package:devlomatix/pages/shop/pages/allProducts.dart';
import 'package:devlomatix/pages/shop/pages/cart.dart';
import 'package:devlomatix/pages/shop/pages/home.dart';
import 'package:devlomatix/pages/shop/pages/product_details.dart';

import 'package:devlomatix/pages/home/home.dart';
import 'package:devlomatix/pages/onboard/onboard.dart';
import 'package:devlomatix/pages/profile/profile.dart';
import 'package:devlomatix/pages/setting/settings.dart';
import 'package:devlomatix/pages/shop/pages/search.dart';
import 'package:devlomatix/pages/shop/pages/setLocation.dart';
import 'package:devlomatix/pages/shop/pages/wishlist.dart';
import 'package:flutter/material.dart';

import 'package:devlomatix/pages/splash/splash.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => Splash(),
  Onboard.routeName: (context) => Onboard(),
  Auth.routeName: (context) => Auth(),
  BasePage.routeName: (context) => BasePage(),
  Home.routeName: (context) => Home(),
  Setting.routeName: (context) => Setting(),
  Profile.routeName: (context) => Profile(),
  GroceryHome.routeName: (context) => GroceryHome(),
  ProductDetails.routeName: (context) => ProductDetails(),
  AllProducts.routeName: (context) => AllProducts(),
  AllCategories.routeName: (context) => AllCategories(),
  AllCategories.routeName: (context) => AllCategories(),
  Cart.routeName: (context) => Cart(),
  Wishlist.routeName: (context) => Wishlist(),
  Search.routeName: (context) => Search(),
  SetLocation.routeName: (context) => SetLocation(),
  AddressSelection.routeName: (context) => AddressSelection()
};
