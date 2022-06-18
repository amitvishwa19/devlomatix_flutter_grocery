import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    int counter = 5;

    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              print('Minus Items');
              if (counter > 0) {
                setState(() {
                  counter - 1;
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
            width: 5,
          ),
          Text(
            counter.toString(),
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print('Plus Items');
              if (counter < 20) {
                setState(() {
                  counter + 1;
                  print(counter.toString());
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
