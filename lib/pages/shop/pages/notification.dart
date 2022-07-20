import 'package:flutter/material.dart';

class Notify extends StatelessWidget {
  static String routeName = "/Notify";
  const Notify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: const Text('Notification'),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text('Notification'),
        ),
      ),
    );
  }
}
