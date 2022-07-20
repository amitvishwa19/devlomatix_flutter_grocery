import 'package:devlomatix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Counter extends StatefulWidget {
  final int count;
  final int id;
  const Counter({
    Key? key,
    required this.count,
    required this.id,
  }) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  var counter = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        //color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              if (counter > 1) {
                //fontSize: 16.0);
                setState(() {
                  counter--;

                  //Fluttertoast.showToast(msg: "Decrese cart count cart item");
                });
              } else {
                print('Delete is clicked');
              }

              // if (counter == 1) {
              //   widget.delete;
              //   Fluttertoast.showToast(msg: "Delete cart item");
              // }
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(color: primaryColor.withOpacity(0.2)),
              child: counter == 1
                  ? const Icon(
                      Icons.delete,
                      size: 20,
                      color: primaryColor,
                    )
                  : const Icon(
                      Icons.horizontal_rule,
                      size: 20,
                      color: primaryColor,
                    ),
            ),
          ),
          const SizedBox(
            width: 0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(3)),
            child: Text(
              counter.toString(),
              style: const TextStyle(fontSize: 16, color: primaryColor),
            ),
          ),
          const SizedBox(
            width: 0,
          ),
          GestureDetector(
            onTap: () {
              if (counter < 20) {
                setState(() {
                  counter++;
                  // widget.add;
                  // Fluttertoast.showToast(msg: "Increase cart count cart item");
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(color: primaryColor.withOpacity(0.2)),
              child: const Icon(
                Icons.add,
                size: 20,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
