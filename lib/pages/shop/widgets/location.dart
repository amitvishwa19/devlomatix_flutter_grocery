import 'package:devlomatix/pages/shop/pages/setLocation.dart';
import 'package:devlomatix/providers/appProvider.dart';
import 'package:devlomatix/providers/locationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Location extends StatelessWidget {
  const Location({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    return Row(
      children: [
        const Icon(Icons.place),
        const SizedBox(width: 5),
        locationProvider.location
            ? GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SetLocation.routeName);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Text(
                        locationProvider.city,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(locationProvider.pincode.toString(),
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  print('Set Location');
                  Navigator.pushNamed(context, SetLocation.routeName);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: const Text('Set Location'),
                ),
              ),
      ],
    );
  }
}
