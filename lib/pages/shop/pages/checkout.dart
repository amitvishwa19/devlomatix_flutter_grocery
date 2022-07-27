import 'package:devlomatix/models/addressModel.dart';
import 'package:devlomatix/pages/shop/pages/BasePage.dart';
import 'package:devlomatix/pages/shop/widgets/cart.dart';
import 'package:devlomatix/providers/cartProvider.dart';
import 'package:devlomatix/providers/checkoutProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  static String routeName = "/checkout";
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int paymentType = 1;
  int addressesCount = 8;
  int addressSelect = 0;

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context, listen: false);
    CartProvider cartProvider = Provider.of(context, listen: false);
    checkoutProvider.getAddress();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        titleSpacing: 0,
        actions: const [
          SCart(),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddressDisplay(
              address: checkoutProvider.deliveryAddress,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SummaryItem(
                      leading: 'Total Items',
                      traling: cartProvider.cartItems.length.toString()),
                  SummaryItem(
                      leading: 'Total Price',
                      traling: Strings.currencySign +
                          cartProvider.totalPrice.toString()),
                  SummaryItem(
                      leading: 'Delivery Charges',
                      traling: Strings.currencySign +
                          cartProvider.deliveryCharge.toString()),
                  SummaryItem(
                      leading: 'Total Discount',
                      traling: Strings.currencySign +
                          cartProvider.totalDiscount.toString()),
                  const Divider(
                    height: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SummaryItem(
                      leading: 'Total Bill',
                      traling: Strings.currencySign +
                          cartProvider.netPrice.toString()),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          //border: Border.all(color: primaryColor.withOpacity(0.2)),
        ),
        height: 280,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 210,
              //color: Colors.green.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: paymentType,
                        onChanged: (e) {
                          setState(() {
                            paymentType = 1;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            paymentType = 1;
                          });
                        },
                        child: const Text('Credit card / Debit Card / UPI'),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: paymentType,
                        onChanged: (e) {
                          setState(() {
                            paymentType = 2;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            paymentType = 2;
                          });
                        },
                        child: const Text('Google Pay'),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 3,
                        groupValue: paymentType,
                        onChanged: (e) {
                          setState(() {
                            paymentType = 3;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            paymentType = 3;
                          });
                        },
                        child: const Text('Cash on Delivery'),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 4,
                        groupValue: paymentType,
                        onChanged: (e) {
                          setState(() {
                            paymentType = 4;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            paymentType = 4;
                          });
                        },
                        child: const Text('Pay Later'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                var data = {
                  'address': checkoutProvider.deliveryAddress,
                  'cart': cartProvider.cartItems,
                  'status': 'ordered',
                  'payment_id': 'kkdd8d88dnnnnndyd665'
                };

                HapticFeedback.vibrate();
                checkoutProvider.checkout(data).then((value) {
                  if (value == 'success') {
                    Fluttertoast.showToast(msg: 'Order places successfully');
                    cartProvider.getCartData();
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(BasePage.routeName));
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    'Checkout and Pay',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddressDisplay extends StatelessWidget {
  final AddressModel address;
  const AddressDisplay({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(
              Icons.place,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.house.toString() +
                    ', ' +
                    address.locality.toString() +
                    ', ' +
                    address.landmark.toString()),
                Text(address.city.toString() +
                    ', ' +
                    address.state.toString() +
                    ', ' +
                    address.pincode.toString()),
                Text('Mb: ' + address.mobile.toString())
              ],
            ),
            trailing: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(5)),
              child: Text(
                address.type![0].toUpperCase() +
                    address.type!.substring(1).toLowerCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}

class SummaryItem extends StatelessWidget {
  final String leading;
  final String traling;
  const SummaryItem({Key? key, required this.leading, required this.traling})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leading,
            style: const TextStyle(
                fontWeight: FontWeight.w800, color: primaryColor),
          ),
          Text(traling,
              style: const TextStyle(
                  fontWeight: FontWeight.w800, color: primaryColor)),
        ],
      ),
    );
  }
}
