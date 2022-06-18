import 'package:flutter/material.dart';

class AllProducts extends StatelessWidget {
  static String routeName = "/allProduct";
  const AllProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text('All Products'),
        ),
      ),
    );
  }
}
