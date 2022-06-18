import 'package:devlomatix/providers/userProvider.dart';
import 'package:devlomatix/utils/colors.dart';
import 'package:devlomatix/widgets/circleAvatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar buildappBar() {
  return AppBar(
    automaticallyImplyLeading: true, // hides leading widget
    backgroundColor: primaryColor,
    title: Consumer<UserProvider>(builder: (context, value, child) {
      return Text('${value.user.firstname}, ${value.user.lastname}');
    }),
    actions: [
      GestureDetector(onTap: () {
        //avatarClickrd();
      }, child: Consumer<UserProvider>(builder: (context, value, child) {
        return CAvatar(
            radius: 20,
            url: null,
            // ignore: unnecessary_string_interpolations
            text:
                '${(value.user.firstname.toString().substring(0, 1))}${value.user.lastname.toString().substring(0, 1)}');
      })),
      const SizedBox(
        width: 20,
      )
    ],
  );
}
