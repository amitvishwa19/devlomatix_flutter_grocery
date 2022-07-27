import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/pages/shop/pages/cart.dart';
import 'package:devlomatix/pages/shop/pages/categoryList.dart';
import 'package:devlomatix/pages/shop/widgets/location.dart';
import 'package:devlomatix/pages/shop/widgets/product_display_list.dart';
import 'package:devlomatix/pages/shop/widgets/slider.dart';
import 'package:devlomatix/pages/shop/pages/search.dart';
import 'package:devlomatix/pages/shop/widgets/cart.dart';
import 'package:devlomatix/pages/shop/widgets/recently_viewed.dart';
import 'package:devlomatix/providers/cartProvider.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/providers/wishlistProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.getSlider();
    productProvider.getCategory();
    productProvider.featuredProd();
    productProvider.trendingProd();
    productProvider.getRecentlyViewed();
    productProvider.hotProducts();
    productProvider.getMostViewed();

    //CartProvider cartProvider = Provider.of(context, listen: false);
    //cartProvider.cartSummary();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WishlistProvider wishlistProvider =
    //     Provider.of<WishlistProvider>(context, listen: false);
    // wishlistProvider.getWishList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Location(),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Search.routeName);
              //showSearch(context: context, delegate: SearchPage(mdl));
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child:
                Consumer<ProductProvider>(builder: (context, provider, child) {
              return Column(
                children: [
                  const HomeSlider(),
                  const CategoryList(),

                  //Featured Products
                  ProductDisplayList(
                    title: 'Featured Products',
                    products: provider.featured,
                    length: 10,
                  ),

                  //Recently viewed products
                  RecentlyViewed(
                    title: 'Recently Viewed',
                    recentlyViewed: provider.recentlyViewed,
                    length: 5,
                  ),

                  //Hot Products
                  ProductDisplayList(
                    title: 'Hot Products',
                    products: provider.hotProd,
                    length: 5,
                  ),

                  ProductDisplayList(
                    title: 'Trending Products',
                    products: provider.trending,
                    length: 5,
                  ),

                  RecentlyViewed(
                    title: 'Most Viewed',
                    recentlyViewed: provider.mostViewed,
                    length: 5,
                  ),
                ],
              );
            }),
          ),

          //Cart summary in homepage
          Consumer<CartProvider>(builder: (context, provider, child) {
            return provider.cartItems.isNotEmpty
                ? Positioned(
                    bottom: 10,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(7)),
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  provider.cartItems.length.toString() +
                                      ' Items',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                Strings.currencySign +
                                    provider.netPrice.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          trailing: GestureDetector(
                              onTap: () {
                                HapticFeedback.vibrate();
                                Navigator.pushNamed(context, Cart.routeName);
                              },
                              child: SizedBox(
                                height: 40,
                                width: 90,
                                child: Row(
                                  children: const [
                                    Text(
                                      'View Cart',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ))
                : Container();
          })
        ],
      ),
    );
  }
}
