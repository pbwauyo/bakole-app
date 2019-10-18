import 'package:bakole/httpModels/Worker.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  final Worker worker;
  Home({@required this.worker});

  @override
  createState ()=> HomeState();
}

class HomeState extends State<Home>{

  @override
  build(context) => Container(
    child: Column(
      children: <Widget>[
        Card(
          child: Container(
            decoration: BoxDecoration(
//              image: DecorationImage(
//                  image:
//              ),
            ),
            child: Column(
              children: <Widget>[
                FlutterLogo()
              ],
            )
          ),
        )
      ],
    ),
  );
}