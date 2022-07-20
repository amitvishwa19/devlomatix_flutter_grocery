import 'package:devlomatix/pages/shop/pages/allProducts.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategories extends StatelessWidget {
  static String routeName = "/allCategories";
  const AllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Categories'),
          titleSpacing: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Consumer<ProductProvider>(builder: (context, provider, child) {
            return GridView.builder(
                itemCount: provider.category.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print('Category clicked');
                      provider.setProductCategory(
                          provider.category[index].title.toString());
                      Navigator.pushNamed(context, AllProducts.routeName);
                    },
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: Image.network(
                                provider.category[index].image.toString()),
                          ),
                          const SizedBox(height: 5),
                          Text(provider.category[index].title.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                  );
                });
          }),
        ));
  }
}
