import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/models/wishlistModel.dart';
import 'package:devlomatix/pages/shop/pages/cart.dart';
import 'package:devlomatix/pages/shop/pages/product_details.dart';
import 'package:devlomatix/pages/shop/widgets/cart.dart';
import 'package:devlomatix/pages/shop/widgets/vertical_product_list_item.dart';
import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/providers/cartProvider.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/providers/wishlistProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatefulWidget {
  static String routeName = "/wishlist";
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  late AppProvider appProvider =
      Provider.of<AppProvider>(context, listen: false);

  late WishlistProvider wishlistProvider =
      Provider.of<WishlistProvider>(context, listen: false);

  @override
  void initState() {
    wishlistProvider.getWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider provider =
        Provider.of<ProductProvider>(context, listen: false);
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              appProvider.changeBottomNav(0);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Wishlist'),
        titleSpacing: 0,
        actions: const [
          SCart(),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Consumer<WishlistProvider>(builder: (context, wishlist, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: wishlist.wishlist.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        size: 100,
                        color: primaryColor.withOpacity(1),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'No Items in Wishlist',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Looks like you did not added any items to your Wishlist',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: wishlist.wishlist.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = wishlist.wishlist[index];
                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.vibrate();
                        //provider.product = product;
                        // Navigator.pushNamed(context, ProductDetails.routeName);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 10),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: primaryColor.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: boxshadow,
                        ),
                        height: 80,
                        child: ListTile(
                          title: Row(
                            children: [
                              SizedBox(
                                width: 60,
                                child: Image(
                                  image: NetworkImage(
                                      item.product!.image.toString()),
                                  height: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.product!.title.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(item.product!.sku.toString()),
                                  item.product!.quantity == 0
                                      ? Container(
                                          child: const Text(
                                            'Out of Stock',
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14),
                                          ),
                                        )
                                      : item.product!.discount! > 0
                                          ? Row(
                                              children: [
                                                Text(
                                                  '₹ ${item.product!.price.toString()}',
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '₹ ${item.product!.netPrice.toString()}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                )
                                              ],
                                            )
                                          : Text(
                                              item.product!.price.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800),
                                            )
                                ],
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FavouriteIcon(
                                wishlist: item,
                              ),
                              item.product!.quantity == 0
                                  ? const Icon(
                                      Icons.mood_bad,
                                      color: primaryColor,
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        HapticFeedback.vibrate();
                                        Fluttertoast.showToast(
                                            msg:
                                                " ${item.product!.title} added to cart");
                                        await cartProvider.addToCart(
                                            item.product!.id, 1);
                                        await cartProvider.getCartData();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color:
                                                primaryColor.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Icon(
                                          Icons.add,
                                          color: primaryColor,
                                          size: 18,
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      }),
    );
  }
}

class FavouriteIcon extends StatefulWidget {
  final WishlistModel wishlist;
  const FavouriteIcon({
    Key? key,
    required this.wishlist,
  }) : super(key: key);

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  bool favrouite = true;
  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    //wishlistProvider.getWishList();

    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();

        setState(() {
          favrouite = !favrouite;
          if (!favrouite) {
            Fluttertoast.showToast(
                msg:
                    " ${widget.wishlist.product!.title} removed from wishlist");
            wishlistProvider.removeFromWishList(widget.wishlist.id);
          }
        });
      },
      child: Icon(
        favrouite ? Icons.favorite : Icons.favorite_border,
        color: primaryColor,
      ),
    );
  }
}
