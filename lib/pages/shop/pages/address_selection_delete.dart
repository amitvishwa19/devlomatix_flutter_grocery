import 'package:devlomatix/pages/shop/pages/address_selection.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';

class AddressSelection extends StatefulWidget {
  static String routeName = "/selectAddress";
  const AddressSelection({Key? key}) : super(key: key);

  @override
  State<AddressSelection> createState() => _AddressSelectionState();
}

class _AddressSelectionState extends State<AddressSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
        titleSpacing: 0,
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Text('Cart'),
        ),
      ),
      bottomNavigationBar: ListTile(
        trailing: Container(
          width: double.infinity,
          child: MaterialButton(
            onPressed: () {
              //Navigator.pushNamed(context, SelectAddress.routeName);
            },
            color: primaryColor,
            child: const Text(
              'Checkout',
              style: TextStyle(color: Colors.white),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          ),
        ),
      ),
    );
  }
}
