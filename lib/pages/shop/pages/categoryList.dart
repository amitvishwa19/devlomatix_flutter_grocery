import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/productProvider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

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
                'Popular Category',
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
            height: 100,
            alignment: Alignment.centerLeft,
            child:
                Consumer<ProductProvider>(builder: (context, provider, child) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: provider.category.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print(
                          'Category item clicked  ${provider.category[index].title}');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            width: 50,
                            height: 35,
                            alignment: Alignment.center,
                            child: Image.network(
                                provider.category[index].image.toString()),
                          ),
                          Text(
                            provider.category[index].title.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
