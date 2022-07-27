import 'dart:convert';

import 'package:devlomatix/models/cartModel.dart';
import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/pages/shop/pages/address.dart';
import 'package:devlomatix/pages/shop/pages/address_selection.dart';
import 'package:devlomatix/pages/shop/pages/checkout.dart';
import 'package:devlomatix/pages/shop/widgets/counter.dart';
import 'package:devlomatix/providers/cartProvider.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  static String routeName = "/cart";
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    cartProvider.cartSummary();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        titleSpacing: 0,
      ),
      body: Consumer<CartProvider>(builder: (context, item, child) {
        return Container(
          child: item.cartItems.isNotEmpty
              ? ListView.builder(
                  itemCount: item.cartItems.length,
                  itemBuilder: (context, index) {
                    var product = item.cartItems[index].product;
                    ProductModel prdct = new ProductModel();
                    prdct.id = product!.id;
                    prdct.title = product.title.toString();
                    prdct.image = product.image.toString();
                    prdct.sku = product.sku.toString();
                    prdct.discount = product.discount;
                    prdct.price = product.price;
                    prdct.netPrice = product.netPrice;
                    return CartItem(
                      cartItem: item.cartItems[index],
                    );
                  })
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 100,
                        color: primaryColor.withOpacity(1),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Empty Cart',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Looks like you did not added any items yet',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .90,
                        child: MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: primaryColor,
                            child: const Text(
                              "Let's Shop",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      )
                    ],
                  ),
                ),
        );
      }),
      bottomNavigationBar:
          Consumer<CartProvider>(builder: (context, item, child) {
        return item.cartItems.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  border: Border.all(color: primaryColor.withOpacity(0.2)),
                ),
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      //color: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 120,
                      //color: Colors.green.withOpacity(0.5),
                      child: Column(
                        children: [
                          SummaryItem(
                              title: 'Total MRP',
                              amnt: item.totalPrice,
                              bold: false),
                          const SizedBox(height: 10),
                          SummaryItem(
                              title: 'Total Discount on MRP',
                              amnt: item.totalDiscount,
                              bold: false),
                          Divider(),
                          SummaryItem(
                              title: 'Net Amount',
                              amnt: item.netPrice,
                              bold: true),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        HapticFeedback.vibrate();
                        Navigator.pushNamed(context, Address.routeName);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, right: 10, left: 10),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            'Continue to Checkout',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 1,
              );
      }),
    );
  }
}

class CartItem extends StatefulWidget {
  final CartModel cartItem;

  const CartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int counter = 1;

  getCount() {
    setState(() {
      counter = widget.cartItem.quantity!;
    });
  }

  @override
  void initState() {
    getCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        print('Cart item clicked');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          title: Row(
            children: [
              SizedBox(
                width: 60,
                child: Image(
                  image:
                      NetworkImage(widget.cartItem.product!.image.toString()),
                  height: 50,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cartItem.product!.title.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(widget.cartItem.product!.sku.toString()),
                  (widget.cartItem.product!.discount! > 0)
                      ? Row(
                          children: [
                            Text(
                              '₹ ${widget.cartItem.product!.price.toString()}',
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '₹ ${widget.cartItem.product!.netPrice.toString()}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w800),
                            )
                          ],
                        )
                      : Text(
                          widget.cartItem.product!.price.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        )
                ],
              ),
            ],
          ),

          //Cart Counter
          trailing: Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              //color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Delete//Remove button
                GestureDetector(
                  onTap: () {
                    HapticFeedback.vibrate();
                    if (counter > 1) {
                      //fontSize: 16.0);

                      setState(() {
                        cartProvider.updateCart(false, widget.cartItem.cartId);
                        counter--;
                        //Fluttertoast.showToast(msg: "Decrese cart count cart item");
                      });
                    } else {
                      cartProvider.deleteCartItem(widget.cartItem.cartId);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration:
                        BoxDecoration(color: primaryColor.withOpacity(0.2)),
                    child: counter == 1
                        ? const Icon(
                            Icons.delete,
                            size: 20,
                            color: primaryColor,
                          )
                        : const Icon(
                            Icons.horizontal_rule,
                            size: 20,
                            color: primaryColor,
                          ),
                  ),
                ),
                const SizedBox(
                  width: 0,
                ),

                // Item count area
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(3)),
                  child: Text(
                    counter.toString(),
                    style: const TextStyle(fontSize: 16, color: primaryColor),
                  ),
                ),
                const SizedBox(
                  width: 0,
                ),

                //Add Button
                GestureDetector(
                  onTap: () {
                    HapticFeedback.vibrate();
                    if (counter < 20) {
                      setState(() {
                        counter++;
                        cartProvider.updateCart(true, widget.cartItem.cartId);
                        // Fluttertoast.showToast(msg: "Increase cart count cart item");
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration:
                        BoxDecoration(color: primaryColor.withOpacity(0.2)),
                    child: const Icon(
                      Icons.add,
                      size: 20,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SummaryItem extends StatelessWidget {
  final String title;
  final int amnt;
  final bool bold;

  const SummaryItem(
      {Key? key, required this.title, required this.amnt, required this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title :',
            style: TextStyle(
              fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
              fontSize: 16,
            ),
          ),
          Text('₹ $amnt',
              style: TextStyle(
                fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
                fontSize: 16,
              )),
        ],
      ),
    );
  }
}
