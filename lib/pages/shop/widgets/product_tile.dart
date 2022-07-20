import 'package:devlomatix/pages/shop/pages/product_details.dart';
import 'package:devlomatix/providers/cartProvider.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../models/productModel.dart';
import '../../../providers/wishlistProvider.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/strings.dart';

class ProductTile extends StatefulWidget {
  final ProductModel product;
  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context, listen: false);
    CartProvider cartProvider = Provider.of(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: boxshadow,
      ),
      height: 80,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.vibrate();
          print('Product tile clicked');
          productProvider.product = widget.product;
          Navigator.pushNamed(context, ProductDetails.routeName);
        },
        child: ListTile(
          title: Row(
            children: [
              SizedBox(
                width: 60,
                child: Image(
                  image: NetworkImage(widget.product.image.toString()),
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
                    widget.product.title.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(widget.product.sku.toString()),
                  widget.product.quantity == 0
                      ? Container(
                          child: const Text(
                            'Out of Stock',
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 14),
                          ),
                        )
                      : widget.product.discount! > 0
                          ? Row(
                              children: [
                                Text(
                                  Strings.currencySign +
                                      widget.product.price.toString(),
                                  style: const TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w800,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  Strings.currencySign +
                                      widget.product.netPrice.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            )
                          : Text(
                              Strings.currencySign +
                                  widget.product.price.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w800),
                            )
                ],
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FavouriteIcon(product: widget.product),
              widget.product.quantity == 0
                  ? const Icon(
                      Icons.mood_bad,
                      color: primaryColor,
                    )
                  : GestureDetector(
                      onTap: () async {
                        HapticFeedback.vibrate();
                        Fluttertoast.showToast(
                            msg: " ${widget.product.title} added to cart");
                        await cartProvider.addToCart(widget.product.id, 1);
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
