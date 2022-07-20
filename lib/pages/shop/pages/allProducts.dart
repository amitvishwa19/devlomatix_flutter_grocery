import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/pages/shop/pages/product_details.dart';
import 'package:devlomatix/pages/shop/widgets/cart.dart';
import 'package:devlomatix/pages/shop/widgets/product_display_list.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/constant.dart';
import 'package:devlomatix/utils/strings.dart';
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
                  var item = productProvider.allProducts[index];
                  return InkWell(
                    onTap: () {
                      productProvider.product = item;
                      Navigator.pushNamed(context, ProductDetails.routeName);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: primaryColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: boxshadow,
                      ),
                      child: Center(
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Product
                                Product(
                                  url: item.image.toString(),
                                  title: item.title.toString(),
                                ),

                                //Product Meta
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      (item.discount! > 0)
                                          ? Row(
                                              children: [
                                                Text(
                                                  Strings.currencySign +
                                                      item.price.toString(),
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  Strings.currencySign +
                                                      item.netPrice.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                )
                                              ],
                                            )
                                          : Text(
                                              item.price.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800),
                                            ),

                                      //Add to cart function
                                      item.quantity != 0
                                          ? AddToCart(
                                              item: item,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                )
                              ],
                            ),

                            //Favourite item Icon
                            FavouriteIcon(
                              product: item,
                              fav: true,
                            ),

                            //Discount badge
                            DiscountBadge(
                              discount: item.discount!,
                            ),
                            item.quantity == 0
                                ? Center(
                                    child: Container(
                                    height: 30,
                                    width: double.infinity,
                                    color: Colors.white.withOpacity(0.8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Out of Stock',
                                          style: TextStyle(
                                              color:
                                                  primaryColor.withOpacity(0.8),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  ))
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : const Center(
                child: Text('No products found'),
              ),
      ),
    );
    ;
  }
}
