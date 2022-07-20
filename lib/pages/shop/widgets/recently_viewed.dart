import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/pages/shop/pages/allProducts.dart';
import 'package:devlomatix/pages/shop/pages/product_details.dart';
import 'package:devlomatix/pages/shop/widgets/vertical_product_list_item.dart';
import 'package:devlomatix/providers/cartProvider.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/providers/wishlistProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/constant.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RecentlyViewed extends StatelessWidget {
  final String title;
  final int length;
  final List<ProductModel> recentlyViewed;
  const RecentlyViewed(
      {Key? key,
      required this.length,
      required this.recentlyViewed,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);

    return Container(
      child: Consumer<ProductProvider>(builder: (context, item, child) {
        return Column(
          children: [
            recentlyViewed.isNotEmpty
                ? Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Title
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: primaryColor),
                        ),

                        //Explore All Button
                        InkWell(
                          onTap: () {
                            print('Explore all clicked');
                            productProvider
                                .setProductCategory('Recently Viewed');
                            productProvider.allProducts = recentlyViewed;
                            Navigator.pushNamed(context, AllProducts.routeName);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'View All',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            ListView.builder(
              itemCount: recentlyViewed.take(length).toList().length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var product = recentlyViewed[index];
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.vibrate();
                    productProvider.product = product;
                    Navigator.pushNamed(context, ProductDetails.routeName);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.only(right: 15, left: 15, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor.withOpacity(0.2)),
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
                              image: NetworkImage(product.image.toString()),
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
                                product.title.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(product.sku.toString()),
                              product.quantity == 0
                                  ? Container(
                                      child: const Text(
                                        'Out of Stock',
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14),
                                      ),
                                    )
                                  : product.discount! > 0
                                      ? Row(
                                          children: [
                                            Text(
                                              Strings.currencySign +
                                                  product.price.toString(),
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w800,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              Strings.currencySign +
                                                  product.netPrice.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800),
                                            )
                                          ],
                                        )
                                      : Text(
                                          Strings.currencySign +
                                              product.price.toString(),
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
                          FavouriteIcon(product: product),
                          product.quantity == 0
                              ? const Icon(
                                  Icons.mood_bad,
                                  color: primaryColor,
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    HapticFeedback.vibrate();
                                    Fluttertoast.showToast(
                                        msg: " ${product.title} added to cart");
                                    await cartProvider.addToCart(product.id, 1);
                                    await cartProvider.getCartData();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5)),
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
            )
          ],
        );
      }),
    );
  }
}

class FavouriteIcon extends StatefulWidget {
  final ProductModel product;
  const FavouriteIcon({Key? key, required this.product}) : super(key: key);

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  bool favrouite = false;
  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);

    return GestureDetector(
      onTap: () async {
        print(' added to favourite');
        HapticFeedback.vibrate();

        setState(() {
          favrouite = !favrouite;
          if (favrouite) {
            Fluttertoast.showToast(
                msg: " ${widget.product.title} added to wishlist");
            wishlistProvider.addToWishList(widget.product.id);
          } else {
            Fluttertoast.showToast(
                msg: " ${widget.product.title} removed from wishlist");
            wishlistProvider.removeFromWishList(widget.product.id);
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
