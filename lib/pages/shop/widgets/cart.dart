import 'package:devlomatix/pages/shop/pages/cart.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SCart extends StatelessWidget {
  const SCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Cart.routeName);
        },
        child: Consumer<ProductProvider>(builder: (context, provider, child) {
          return Container(
            //color: Colors.white,
            width: 50,
            child: Row(
              children: [
                const Icon(Icons.shopping_cart),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(provider.cartCount.toString())
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
