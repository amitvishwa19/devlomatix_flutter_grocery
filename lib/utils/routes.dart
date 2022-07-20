import 'package:devlomatix/pages/auth/auth.dart';
import 'package:devlomatix/pages/shop/pages/BasePage.dart';
import 'package:devlomatix/pages/shop/pages/add_address.dart';
import 'package:devlomatix/pages/shop/pages/address_selection.dart';
import 'package:devlomatix/pages/shop/pages/allCategories.dart';
import 'package:devlomatix/pages/shop/pages/allProducts.dart';
import 'package:devlomatix/pages/shop/pages/cart.dart';
import 'package:devlomatix/pages/shop/pages/home.dart';
import 'package:devlomatix/pages/shop/pages/notification.dart';
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

import '../pages/shop/pages/checkout.dart';

final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => const Splash(),
  Onboard.routeName: (context) => const Onboard(),
  Auth.routeName: (context) => const Auth(),
  BasePage.routeName: (context) => BasePage(),
  Home.routeName: (context) => const Home(),
  Setting.routeName: (context) => const Setting(),
  Profile.routeName: (context) => const Profile(),
  GroceryHome.routeName: (context) => const GroceryHome(),
  ProductDetails.routeName: (context) => const ProductDetails(),
  AllProducts.routeName: (context) => const AllProducts(),
  AllCategories.routeName: (context) => const AllCategories(),

  Cart.routeName: (context) => const Cart(),
  Wishlist.routeName: (context) => const Wishlist(),
  Search.routeName: (context) => const Search(),
  SetLocation.routeName: (context) => const SetLocation(),
  AddressSelection.routeName: (context) => const AddressSelection(),
  Checkout.routeName: (context) => const Checkout(),
  AddAddress.routeName: (context) => const AddAddress(),
  Notify.routeName: (context) => const Notify(),

  //AllCategories.routeName: (context) => AllCategories(),
  //AllProducts.routeName: (context) => AllProducts()
};
