import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/pages/shop/pages/address_selection.dart';
import 'package:devlomatix/pages/shop/widgets/counter.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  static String routeName = "/cart";
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    ProductProvider provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CartItem(product: provider.product),
            CartItem(product: provider.product),
            CartItem(product: provider.product),
            CartItem(product: provider.product),
            CartItem(product: provider.product),
            CartItem(product: provider.product),
            CartItem(product: provider.product),
            CartItem(product: provider.product),
            CartItem(product: provider.product),
          ],
        ),
      ),
      bottomNavigationBar: ListTile(
        title: const Text(
          'Total Amount',
          style: TextStyle(fontWeight: FontWeight.w900, color: primaryColor),
        ),
        subtitle: const Text(
          '₹ 8000',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              print('select address page');
              Navigator.pushNamed(context, AddressSelection.routeName);
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

class CartItem extends StatelessWidget {
  final ProductModel product;
  const CartItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Cart item clicked');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          title: Row(
            children: [
              Image(
                image: NetworkImage(product.image.toString()),
                height: 50,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(product.sku.toString())
                ],
              ),
            ],
          ),
          trailing: const Counter(),
        ),
      ),
    );
  }
}
