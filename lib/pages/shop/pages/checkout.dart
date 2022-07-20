import 'package:devlomatix/pages/shop/pages/add_address.dart';
import 'package:devlomatix/pages/shop/widgets/cart.dart';
import 'package:devlomatix/providers/cartProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/constant.dart';
import 'package:devlomatix/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  static String routeName = "/checkout";
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int paymentType = 2;
  int addresses = 2;
  int addressSelect = 1;

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: addresses,
                itemBuilder: (context, index) {
                  return Container(
                    child: const Address(),
                  );
                }),
          ),
          InkWell(
            onTap: () {
              print('Add new address');
              Navigator.pushNamed(context, AddAddress.routeName);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.add,
                    color: primaryColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Add New Address',
                    style: TextStyle(color: primaryColor, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border.all(color: primaryColor.withOpacity(0.2)),
        ),
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 230,
              //color: Colors.green.withOpacity(0.5),
              padding: EdgeInsets.all(10),
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
                      const Text('Credit card / Debit Card')
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
                      const Text('Google Pay')
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
                      const Text('Cash on Delivery')
                    ],
                  ),
                  const SizedBox(height: 20),
                  Consumer<CartProvider>(builder: (context, data, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Total ${data.cartItems.length} items in cart',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: primaryColor),
                        ),
                        const SizedBox(width: 100),
                        Text(
                          Strings.currencySign + data.netPrice.toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: primaryColor),
                        ),
                      ],
                    );
                  })
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
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

class Address extends StatelessWidget {
  const Address({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: boxshadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Radio(
            value: 1,
            groupValue: 1,
            onChanged: (e) {},
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '202-10, Rajeshwer Plannet',
                style: TextStyle(fontSize: 16),
              ),
              Text('Harni Road', style: TextStyle(fontSize: 16)),
              Text('Vadodara 390022', style: TextStyle(fontSize: 16))
            ],
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  print('Edit address clicked');
                },
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  print('Delete Address clicked');
                },
                child: const Icon(
                  Icons.delete,
                  size: 16,
                  color: primaryColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
