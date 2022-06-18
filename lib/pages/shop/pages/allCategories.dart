import 'package:flutter/material.dart';

class AllCategories extends StatelessWidget {
  static String routeName = "/allCategories";
  const AllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text('All Categories'),
        ),
      ),
    );
  }
}
