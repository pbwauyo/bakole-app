import 'package:bakole/widgets/ReviewList.dart';
import 'package:flutter/material.dart';

class Reviews extends StatelessWidget{
  final String email;
  final String userType;

  Reviews({@required this.email, @required this.userType});

  @override
  Widget build(BuildContext context) {

    return ReviewList(userEmail: email, userType: userType);
  }
}