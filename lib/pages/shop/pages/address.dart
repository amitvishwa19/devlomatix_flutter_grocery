import 'package:devlomatix/models/addressModel.dart';
import 'package:devlomatix/pages/shop/pages/add_address.dart';
import 'package:devlomatix/pages/shop/pages/checkout.dart';
import 'package:devlomatix/providers/checkoutProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../utils/constant.dart';

class Address extends StatefulWidget {
  static String routeName = "/address";
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  int addressSelect = 0;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context, listen: false);
    checkoutProvider.getAddress();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Address'),
        titleSpacing: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddAddress.routeName);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
      body: Consumer<CheckoutProvider>(builder: (context, data, child) {
        return Container(
          child: data.addresses.isEmpty
              ? const Center(
                  child: Text(
                    'No delivery address found,please add atleast one delivery address to proceed',
                    style: TextStyle(color: primaryColor, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: data.addresses.length,
                  itemBuilder: (context, index) {
                    var address = data.addresses[index];
                    return AddressTile(
                      index: index,
                      address: address,
                      selectedIndex: addressSelect,
                      click: () {
                        setState(() {
                          addressSelect = index;
                          checkoutProvider.deliveryAddress =
                              data.addresses[index];
                        });
                      },
                    );
                  }),
        );
      }),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (checkoutProvider.addresses.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please add atleast one address to proceed to checkout");
          } else {
            if (checkoutProvider.deliveryAddress.house == null) {
              checkoutProvider.deliveryAddress = checkoutProvider.addresses[0];
              Navigator.pushNamed(context, Checkout.routeName);
            } else {
              Navigator.pushNamed(context, Checkout.routeName);
            }
          }
        },
        child: Container(
            margin: const EdgeInsets.all(10),
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: primaryColor,
            ),
            child: const Center(
              child: Text(
                'Proceed to Checkout',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  final int index;
  final Function click;
  final int selectedIndex;
  final AddressModel address;
  const AddressTile(
      {Key? key,
      required this.index,
      required this.click,
      required this.selectedIndex,
      required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: boxshadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Radio(
            value: selectedIndex,
            groupValue: index,
            onChanged: (e) {
              click();
            },
          ),
          GestureDetector(
            onTap: () {
              click();
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.house.toString() +
                        ',' +
                        address.locality.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                      address.landmark.toString() +
                          ',' +
                          address.city.toString(),
                      style: const TextStyle(fontSize: 16)),
                  Text(
                      address.state.toString() +
                          ',' +
                          address.pincode.toString(),
                      style: const TextStyle(fontSize: 16))
                ],
              ),
            ),
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  address.type![0].toUpperCase() +
                      address.type!.substring(1).toLowerCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  checkoutProvider.deleteAddress(address.id);
                },
                child: const Icon(
                  Icons.delete,
                  size: 20,
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
