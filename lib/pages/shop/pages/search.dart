import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  static String routeName = "/search";
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text('Search'),
        ),
      ),
    );
  }
}
