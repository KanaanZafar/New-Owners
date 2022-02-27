import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';

class ContainerWithShadow extends StatelessWidget {
  Widget child;

  ContainerWithShadow({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(5),
      // height: 50,
      // width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: NaguaraColors.shadowColor,
          // color: Colors.black,
          offset: Offset(0, 6),
          blurRadius: 10,
          // spreadRadius: 10,
        ),
      ]),
      child: child,
    );
  }
}
