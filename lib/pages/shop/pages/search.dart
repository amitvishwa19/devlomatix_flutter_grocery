import 'package:devlomatix/models/productModel.dart';
import 'package:devlomatix/pages/shop/widgets/cart.dart';
import 'package:devlomatix/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_tile.dart';

class Search extends StatefulWidget {
  static String routeName = "/search";
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    //ProductProvider productProvider = Provider.of(context, listen: false);
    //productProvider.setDefaultSearchItems();

    //print(productProvider.searchDefaultItems.length);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          titleSpacing: 0,
          actions: const [
            SCart(),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Container(
            child: Column(
          children: [
            //Search Field
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Search for your favourite product',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            query = '';
                          });
                          print('Search field will cleared');
                        },
                        icon: const Icon(Icons.close))),
                onChanged: (text) {
                  setState(() {
                    query = text;
                  });

                  print(query);
                },
              ),
            ),
            Expanded(child:
                Consumer<ProductProvider>(builder: (context, dataprovider, _) {
              return FutureBuilder<List<ProductModel>>(
                future: dataprovider.searchItems(query),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Text('Loading Data'),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ProductTile(product: snapshot.data![index]);
                        });
                  }
                },
              );
            }))
          ],
        )));
  }
}
