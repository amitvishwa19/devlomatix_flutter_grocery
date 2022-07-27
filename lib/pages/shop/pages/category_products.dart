import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/pages/shop/widgets/cart.dart';
import 'package:devlomatix/pages/shop/widgets/gridview_product_tile.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProducts extends StatelessWidget {
  static String routeName = "/category_products";
  const CategoryProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    productProvider.getCategoryProducts(productProvider.categoryProductTitle);

    return Consumer<ProductProvider>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(data.categoryProductTitle),
          titleSpacing: 0,
          actions: const [
            SCart(),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: data.categoryProducts.isEmpty
            ? NoData(
                title: productProvider.categoryProductTitle,
              )
            : DataGrid(products: data.categoryProducts),
      );
    });
  }
}

class NoData extends StatelessWidget {
  final String title;
  const NoData({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.face_outlined,
              size: 60,
              color: primaryColor,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Oh Snap, There is no products in $title, we will notify as soon as product is avaliable ',
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class DataGrid extends StatelessWidget {
  final List<ProductModel> products;
  const DataGrid({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return GridViewProductTile(product: products[index]);
          }),
    );
  }
}
