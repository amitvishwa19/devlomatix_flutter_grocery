import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/pages/shop/pages/product_details.dart';
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

class GridViewProductTile extends StatefulWidget {
  final ProductModel product;
  const GridViewProductTile({Key? key, required this.product})
      : super(key: key);

  @override
  State<GridViewProductTile> createState() => _GridViewProductTileState();
}

class _GridViewProductTileState extends State<GridViewProductTile> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context, listen: false);
    return GestureDetector(
      onTap: () {
        productProvider.product = widget.product;
        Navigator.pushNamed(context, ProductDetails.routeName);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: boxshadow,
        ),
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Product
                  Product(
                    url: widget.product.image.toString(),
                    title: widget.product.title.toString(),
                  ),

                  //Product Meta
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (widget.product.discount! > 0)
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800),
                              ),

                        //Add to cart function
                        widget.product.quantity != 0
                            ? AddToCart(
                                item: widget.product,
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),

              //Favourite item Icon
              FavouriteIcon(
                product: widget.product,
                fav: true,
              ),

              //Discount badge
              DiscountBadge(
                discount: widget.product.discount!,
              ),
              widget.product.quantity == 0
                  ? Center(
                      child: Container(
                      height: 30,
                      width: double.infinity,
                      color: Colors.white.withOpacity(0.8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Out of Stock',
                            style: TextStyle(
                                color: primaryColor.withOpacity(0.8),
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class Product extends StatelessWidget {
  final String title;
  final String url;
  const Product({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      //color: Colors.blueGrey,
      height: 120,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(url),
            height: 100,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          )
        ],
      ),
    );
  }
}

class DiscountBadge extends StatelessWidget {
  final int discount;
  const DiscountBadge({Key? key, required this.discount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //Discount badge
        (discount > 0)
            ? Positioned(
                top: 5,
                left: 5,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    '$discount%',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: primaryColor,
                  ),
                ))
            : Container();
  }
}

class FavouriteIcon extends StatefulWidget {
  final ProductModel product;
  final bool fav;
  const FavouriteIcon({Key? key, required this.product, required this.fav})
      : super(key: key);

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  bool favrouite = false;

  getFavourite() {
    setState(() {
      favrouite = widget.fav;
    });
  }

  @override
  void initState() {
    getFavourite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    return Positioned(
        top: 5,
        right: 5,
        child: GestureDetector(
          onTap: () {
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
            favrouite ? Icons.favorite : Icons.favorite_outline,
            color: primaryColor,
          ),
        ));
  }
}

class AddToCart extends StatelessWidget {
  final ProductModel item;
  const AddToCart({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        //print(item.title.toString() + ' added to cart');
        if (item.quantity == 0) {
          Fluttertoast.showToast(msg: " ${item.title} is out of stock");
        } else {
          HapticFeedback.vibrate();
          Fluttertoast.showToast(msg: " ${item.title} added to cart");
          await cartProvider.addToCart(item.id, 1);
          await cartProvider.getCartData();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)),
        child: const Icon(
          Icons.add,
          color: primaryColor,
          size: 18,
        ),
      ),
    );
  }
}
