import 'package:devlomatix/pages/shop/widgets/cart.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static String routeName = "/productDetails";

  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int count = 0;
  var stars = 5;
  @override
  Widget build(BuildContext context) {
    ProductProvider provider = Provider.of<ProductProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                print('Search Clicked');
              },
              child: const Icon(Icons.search),
            ),
            const SizedBox(
              width: 10,
            ),
            const SCart(),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Consumer<ProductProvider>(builder: (context, provider, child) {
            var item = provider.product;
            var rating = provider.product.rating.toString();
            return Column(
              children: [
                //Top curved container for image
                AspectRatio(
                  aspectRatio: 1.2,
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      //height: 100,
                      //width: 100,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 240, 236, 236),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            image: NetworkImage(item.image.toString()),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                //Name and favourite row
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: primaryColor),
                          ),
                          Text(
                            item.sku.toString(),
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Favourite icon clicked');
                        },
                        child: const Icon(
                          Icons.favorite,
                          color: primaryColor,
                          size: 28,
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                //Addition icon and price
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      //Custom Counter
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (count > 0) {
                                  setState(() {
                                    count = count - 1;
                                  });
                                }
                              },
                              child: Container(
                                child: const Icon(
                                  Icons.horizontal_rule,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              count.toString(),
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (count < 20) {
                                  setState(() {
                                    count = count + 1;
                                  });
                                }
                              },
                              child: Container(
                                child: const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      //Price
                      Row(
                        children: [
                          Text(
                            item.price.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: primaryColor,
                                decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            item.price.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                //About Products
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About Product',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      Text(item.description.toString())
                    ],
                  ),
                ),

                //Review Area
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Rating',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800)),
                      Row(
                        children: [
                          for (int i = 0; i < stars; i++)
                            const Icon(
                              Icons.star_border,
                              color: Colors.amber,
                            )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
        bottomNavigationBar: Row(
          children: [
            BottomActionBar(
              backgroundColor: Colors.black87,
              color: Colors.grey,
              iconColor: Colors.grey,
              title: "Add to wish list",
              icon: Icons.favorite_outline,
              onClick: () {
                provider.addToWishList(provider.product);
              },
            ),
            BottomActionBar(
              backgroundColor: primaryColor,
              color: Colors.white,
              iconColor: Colors.white,
              title: "Add to Cart",
              icon: Icons.shopping_cart,
              onClick: () {
                provider.addToCart(provider.product);
              },
            )
          ],
        ));
  }
}

class BottomActionBar extends StatelessWidget {
  final Color iconColor;
  final Color backgroundColor;
  final Color color;
  final String title;
  final IconData icon;
  final Function onClick;

  const BottomActionBar(
      {Key? key,
      required this.iconColor,
      required this.backgroundColor,
      required this.color,
      required this.title,
      required this.icon,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title.toString(),
              style: TextStyle(color: color),
            )
          ],
        ),
      ),
    ));
  }
}

class CustomCounter extends StatefulWidget {
  const CustomCounter({Key? key}) : super(key: key);

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              print('Minus Items');
              if (count > 0) {
                setState(() {
                  count = count - 1;
                });
              }
            },
            child: Container(
              child: const Icon(
                Icons.horizontal_rule,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            count.toString(),
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              print('Plus Items');
              if (count < 20) {
                setState(() {
                  count = count + 1;
                  print(count.toString());
                });
              }
            },
            child: Container(
              child: const Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
