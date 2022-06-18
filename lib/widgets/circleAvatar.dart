import 'package:flutter/material.dart';

class CAvatar extends StatelessWidget {
  const CAvatar(
      {Key? key, required this.radius, required this.text, required this.url})
      : super(key: key);

  final double? radius;
  final String? text;
  final String? url;

  //CachedNetworkImageProvider(url)
  @override
  Widget build(BuildContext context) {
    // GetX<UserController>(init: UserController(),builder: (_){
    //   return Text('${_.userModel.value.type}');
    // });

    return CircleAvatar(
        radius: radius,
        backgroundImage: url != null ? NetworkImage(url.toString()) : null,
        backgroundColor: url != null ? Colors.transparent : null,
        child: url != null
            ? Text(''
                '')
            : Text('$text'));
  }
}
