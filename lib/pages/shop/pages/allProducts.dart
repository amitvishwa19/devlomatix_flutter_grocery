import 'package:devlomatix/pages/shop/widgets/cart.dart';
import 'package:devlomatix/pages/shop/widgets/gridview_product_tile.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatelessWidget {
  static String routeName = "/allProduct";

  const AllProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(productProvider.productCategory.toString()),
        titleSpacing: 0,
        actions: const [
          SCart(),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: productProvider.allProducts.isNotEmpty
            ? GridView.builder(
                itemCount: productProvider.allProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return GridViewProductTile(
                      product: productProvider.allProducts[index]);
                })
            : const Center(
                child: Text('No products found'),
              ),
      ),
    );
    ;
  }
}
