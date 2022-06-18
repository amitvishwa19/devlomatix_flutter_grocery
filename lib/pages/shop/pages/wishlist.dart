import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  static String routeName = "/wishlist";
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text('Wishlist'),
        ),
      ),
    );
  }
}
