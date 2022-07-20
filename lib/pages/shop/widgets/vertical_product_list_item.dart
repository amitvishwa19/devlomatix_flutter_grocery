import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/pages/shop/pages/product_details.dart';
import 'package:devlomatix/providers/cartProvider.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/providers/wishlistProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class VerticalListItem extends StatefulWidget {
  final ProductModel product;
  const VerticalListItem({Key? key, required this.product}) : super(key: key);

  @override
  State<VerticalListItem> createState() => _VerticalListItemState();
}

class _VerticalListItemState extends State<VerticalListItem> {
  bool favrouite = false;

  @override
  Widget build(BuildContext context) {
    ProductProvider provider =
        Provider.of<ProductProvider>(context, listen: false);
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    WishlistProvider wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        provider.product = widget.product;
        Navigator.pushNamed(context, ProductDetails.routeName);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
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
                                  '₹ ${widget.product.price.toString()}',
                                  style: const TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w800,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '₹ ${widget.product.netPrice.toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            )
                          : Text(
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
              GestureDetector(
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
                          msg:
                              " ${widget.product.title} removed from wishlist");
                      wishlistProvider.removeFromWishList(widget.product.id);
                    }
                  });
                },
                child: Icon(
                  favrouite ? Icons.favorite : Icons.favorite_border,
                  color: primaryColor,
                ),
              ),
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
