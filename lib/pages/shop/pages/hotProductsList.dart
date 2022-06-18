import 'package:devlomatix/pages/shop/pages/product_details.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../providers/productProvider.dart';

class HotProducts extends StatelessWidget {
  const HotProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Popular category title
              const Text(
                'Hot Products',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: primaryColor),
              ),

              //Explore All Button
              InkWell(
                onTap: () {
                  print('Explore all clicked');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'View All',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          //List View
          Container(
              height: 200,
              alignment: Alignment.centerLeft,
              child: Consumer<ProductProvider>(
                  builder: (context, provider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.hotProd.length,
                  itemBuilder: (context, index) {
                    var item = provider.hotProd[index];

                    return GestureDetector(
                      onTap: () {
                        print('Item clicked :' + item.title.toString());
                        provider.product = item;
                        Navigator.pushNamed(context, ProductDetails.routeName);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        height: 200,
                        width: 130,
                        decoration: BoxDecoration(
                          //border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            //Item Container
                            Container(
                              height: 200,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5),

                                //color: Colors.grey,
                              ),
                            ),

                            //Image Container
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    //color: Colors.greenAccent,
                                  ),
                                  height: 100,
                                  //width: 40,
                                  child: Image(
                                      image:
                                          NetworkImage(item.image.toString())),
                                ),

                                //Item Sku
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(item.title.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800)),
                                    // Text(item.sku.toString(),
                                    //     style: const TextStyle(
                                    //         fontWeight: FontWeight.w800,
                                    //         color: Colors.grey)),
                                  ],
                                ),

                                //Item Price and Add Button
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    (item.discount! > 0)
                                        ? Row(
                                            children: [
                                              Text(
                                                item.price.toString(),
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w800,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
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
                                    GestureDetector(
                                      onTap: () {
                                        print(item.title.toString() +
                                            ' added to cart');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            ),

                            //Discount badge
                            (item.discount! > 0)
                                ? Positioned(
                                    top: 5,
                                    left: 5,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Text('${item.discount}%'),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green,
                                      ),
                                    ))
                                : Container(),

                            //Favourite item Icon
                            Positioned(
                                top: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    print(item.title.toString() +
                                        ' added to favourite');
                                  },
                                  child: const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.red,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                );
              })),
        ],
      ),
    );
  }
}
