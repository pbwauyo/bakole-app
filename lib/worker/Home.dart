import 'dart:ui';

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
    width: double.infinity,
    
    decoration: BoxDecoration(
      
      image: DecorationImage(
        image: AssetImage("assets/images/home.jpg"),
        fit: BoxFit.cover
      )
    ),
    child: Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),   
                    color: Colors.grey.shade400.withOpacity(0.5),
                  ),
                  width: 300,
                  height: 300,
                  
                  child: Center(
                    child: Text("Welcome", 
                      style: TextStyle(fontSize: 50, color: Colors.white),),
                  ),
                ),
              ),
            ),
          )
  );
}