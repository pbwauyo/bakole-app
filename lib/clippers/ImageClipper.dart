import 'package:flutter/material.dart';

class ImageClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();

    var firstEndPoint = Offset(size.width/2.25, size.height-30.0);
    var firstControlPoint = Offset(size.width/4, size.height);
    
    var secondEndPoint = Offset(size.width, size.height-40);
    var secondControlPoint = Offset(size.width-(size.width/3.25), size.height-60);

    path.lineTo(0.0, size.height);
    //path.lineTo(0.0, size.height-20);
    //path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    //path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height-40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

  double getPercentage(double size, double offset){
    return offset * size;
  }

}