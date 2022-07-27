import 'package:devlomatix/models/orderModel.dart';
import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/providers/checkoutProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  static String routeName = "/orders";
  const Orders({Key? key}) : super(key: key);

  getCount(List items) {
    return items.length.toString();
  }

  totalPrice(items) {
    Cart cart;
    int price = 0;
    for (var e in items) {
      cart = e;
      //price = price + cart.product!.price;
      price += cart.product!.price!;
    }
    return price;
  }

  netPrice(items) {
    Cart cart;
    int price = 0;
    for (var e in items) {
      cart = e;
      //price = price + cart.product!.price;
      price += cart.product!.netPrice!;
    }
    return price;
  }

  allItems(items) {
    Cart cart;
    String itemlist = '';
    for (var e in items) {
      cart = e;
      itemlist = itemlist +
          cart.product!.title! +
          '(' +
          cart.quantity.toString() +
          '*' +
          cart.product!.sku.toString() +
          '), ';
    }

    return itemlist;
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    CheckoutProvider checkoutProvider = Provider.of(context, listen: false);
    checkoutProvider.allOrders();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              appProvider.changeBottomNav(0);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Order History'),
        titleSpacing: 0,
      ),
      body: Consumer<CheckoutProvider>(builder: (context, data, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: data.orders.isEmpty
              ? const Center(
                  child: Text(
                    'No order history found',
                    style: TextStyle(color: primaryColor, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: data.orders.length,
                  itemBuilder: (context, index) {
                    var item = data.orders[index];
                    int tPrice = totalPrice(item.cart);
                    int nPrice = netPrice(item.cart);
                    String items = allItems(item.cart);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(10),
                      height: 220,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.date.toString(),
                                  ),
                                  Text(
                                    Strings.currencySign + nPrice.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                              Text('Order #' + item.id.toString()),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.shopping_bag),
                                  const SizedBox(width: 20),
                                  Flexible(
                                      child: Text(
                                    items,
                                    textAlign: TextAlign.start,
                                  ))
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.join_right_rounded,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(item.status![0].toUpperCase() +
                                      item.status!.substring(1).toLowerCase())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //Cancel order button
                                  GestureDetector(
                                    onTap: () {
                                      if (item.status == 'ordered') {
                                        checkoutProvider
                                            .cancelOrder(item.id)
                                            .then((value) {
                                          if (value == 'success') {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Your order cancelled successfully');
                                            checkoutProvider.allOrders();
                                          }
                                        });
                                      } else {
                                        checkoutProvider
                                            .orderAgain(item.id)
                                            .then((value) {
                                          if (value == 'success') {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Repeat Order placed successfully');
                                            checkoutProvider.allOrders();
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Center(
                                        child: (item.status == 'ordered')
                                            ? const Text(
                                                'Cancel Order',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              )
                                            : const Text('Order Again',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                      ),
                                    ),
                                  ),

                                  //Track Order Button
                                  GestureDetector(
                                    onTap: () {
                                      print('Track Order');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: const Center(
                                        child: Text(
                                          'Track your order',
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }),
        );
      }),
    );
  }
}
