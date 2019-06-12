import 'package:flutter/material.dart';
import 'dart:math';

class PageReveal extends StatelessWidget{
  final double circpercent;
  final Widget child;

  PageReveal(this.circpercent, this.child);

  @override
  Widget build(BuildContext context) {
    return new ClipOval(
      child: this.child,
      clipper: new _CircleClipper(this.circpercent),
    );
  }
}

class _CircleClipper extends CustomClipper<Rect> {

  final double circpercent;

  _CircleClipper(this.circpercent);

  @override
  Rect getClip(Size size) {
    final Offset epicenter = new Offset(size.width/2, size.height*0.9);

    final double distancetocorner = sqrt(pow(epicenter.dx, 2)+pow(epicenter.dy, 2));
    final double radius =distancetocorner*this.circpercent;

    return new Rect.fromLTWH(epicenter.dx-radius, epicenter.dy-radius, radius*2, radius*2);

  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
  return true;
  }
}
