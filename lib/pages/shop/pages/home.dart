// ignore_for_file: avoid_unnecessary_containers

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:devlomatix/pages/shop/pages/categoryList.dart';
import 'package:devlomatix/pages/shop/widgets/location.dart';
import 'package:devlomatix/pages/shop/widgets/product_display_list.dart';
import 'package:devlomatix/pages/shop/widgets/slider.dart';
import 'package:devlomatix/pages/shop/pages/productLists.dart';
import 'package:devlomatix/pages/shop/pages/search.dart';
import 'package:devlomatix/pages/shop/widgets/cart.dart';
import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/providers/locationProvider.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroceryHome extends StatefulWidget {
  static String routeName = "/groceryHome";
  const GroceryHome({Key? key}) : super(key: key);

  @override
  State<GroceryHome> createState() => _GroceryHomeState();
}

class _GroceryHomeState extends State<GroceryHome> {
  @override
  void initState() {
    super.initState();

    //Provider.of<LocationProvider>(context).getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider groceryProvider =
        Provider.of<ProductProvider>(context, listen: false);
    groceryProvider.getSlider();
    groceryProvider.getCategory();
    groceryProvider.hotProducts();
    groceryProvider.products('trending');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Location(),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Search.routeName);
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(
            width: 10,
          ),
          const SCart(),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white10,
          child: Column(
            children: [
              const HomeSlider(),
              const CategoryList(),
              Consumer<ProductProvider>(builder: (context, provider, child) {
                var item = provider.hotProd;
                return Column(
                  children: [
                    ProductList(
                      title: "Hot Products",
                      length: 4,
                      products: provider.hotProd,
                    ),
                    ProductDisplayList(
                      title: "Trending",
                      category: 'trending',
                      length: 3,
                      products: provider.trending,
                    )
                  ],
                );
              }),
              //const HotProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
