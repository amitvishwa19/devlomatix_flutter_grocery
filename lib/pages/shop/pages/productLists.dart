import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/pages/shop/pages/allProducts.dart';
import 'package:devlomatix/pages/shop/pages/product_details.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  final String title;
  final int length;
  final List<ProductModel> products;
  const ProductList(
      {Key? key,
      required this.title,
      required this.products,
      required this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider groceryProvider = Provider.of<ProductProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          //Top row for title and display all
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Title
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: primaryColor),
              ),

              //Explore All Button
              InkWell(
                onTap: () {
                  HapticFeedback.vibrate();
                  print('Explore all clicked');
                  Navigator.pushNamed(context, AllProducts.routeName);
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
          const SizedBox(height: 5),
          Container(
              height: 200,
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: products.take(length).toList().length,
                  itemBuilder: (context, i) {
                    var item = products[i];
                    return GestureDetector(
                        onTap: () {
                          print('Item clicked :' + item.title.toString());
                          groceryProvider.product = item;
                          Navigator.pushNamed(
                              context, ProductDetails.routeName);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: primaryColor.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: boxshadow,
                          ),
                          width: 140,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                                    item.price.toString(),
                                                    style: const TextStyle(
                                                        color: primaryColor,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        decoration:
                                                            TextDecoration
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
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),

                                        //Add to cart function
                                        AddToCart(
                                          item: item,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),

                              //Favourite item Icon
                              const FavouriteIcon(),

                              //Discount badge
                              DiscountBadge(
                                discount: item.discount!,
                              )
                            ],
                          ),
                        ));
                  })),
        ],
      ),
    );
  }
}

class Product extends StatelessWidget {
  final String title;
  final String url;
  const Product({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      //color: Colors.blueGrey,
      height: 120,
      width: double.infinity,
      child: Column(
        children: [
          Image(
            image: NetworkImage(url),
            height: 100,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}

class DiscountBadge extends StatelessWidget {
  final int discount;
  const DiscountBadge({Key? key, required this.discount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //Discount badge
        (discount > 0)
            ? Positioned(
                top: 5,
                left: 5,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    '$discount%',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: primaryColor,
                  ),
                ))
            : Container();
  }
}

class FavouriteIcon extends StatefulWidget {
  const FavouriteIcon({Key? key}) : super(key: key);

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  bool favrouite = true;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 5,
        right: 5,
        child: GestureDetector(
          onTap: () {
            print(' added to favourite');
            HapticFeedback.vibrate();
            setState(() {
              print(favrouite.toString());
              favrouite = !favrouite;
            });
          },
          child: Icon(
            favrouite ? Icons.favorite_outline : Icons.favorite,
            color: primaryColor,
          ),
        ));
  }
}

class AddToCart extends StatelessWidget {
  final ProductModel item;
  const AddToCart({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(item.title.toString() + ' added to cart');
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(10)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
