import 'dart:ui' as prefix0;

import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/employer/SearchWorkers.dart';
import 'package:bakole/employer/EmployerActivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget{
  final Employer employer;
  Home({@required this.employer});

  @override
  createState() => HomeState();
}

class HomeState extends State<Home>{
  final List <String> images = ["cleaning.jpg", "construction.jpg", "handyman.jpg", "moving.jpg", "painting.jpg", "laundry.jpg"];
  final List<String> imageNames = ["Cleaning services", "Construction work", "Handyman services", "Moving goods", "Painting work", "Laundry work"];

  List<Item> items = []; 

  @override
  build(context){ 
    items = buildItems();

    return GridView.count(
        crossAxisCount: 2,
        children: List.generate(items.length, (index){
          return Categories(items.elementAt(index).image, items.elementAt(index).caption, employer: Provider.of<EmployerProvider>(context).employer,);
        }),
      );
  }

  List<Item> buildItems(){
    List<Item> list = []; 

    for(var i=0; i<images.length; i++){
      list.add(Item(images[i], imageNames[i]));
    }

    return list;
  } 
}

class Categories extends StatefulWidget{
  final String imageUrl, caption;
  final Employer employer;
  Categories(this.imageUrl, this.caption, {@required this.employer});

  @override
  createState() => CategoriesState(imageUrl, caption);
}

class CategoriesState extends State<Categories>{
  final String imageUrl, caption;
  final radius = 16.0;

  CategoriesState(this.imageUrl, this.caption);

  @override
  build(context) => Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
              ),
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(radius)),
                          child: Image(image: AssetImage("assets/images/$imageUrl"), fit: BoxFit.cover, ),
                        ),
                      ),
                    ),
                    
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                        color: Colors.white.withOpacity(0.0),
                        child: InkWell(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                          splashColor: Colors.amber,              
                          onTap: (){
                            Navigator.push(context, PageRouteBuilder(
                              pageBuilder: (context, anim, secondAnim){
                                return SearchWorkers(category: caption, employer: widget.employer,);
                              },
                              transitionsBuilder: (context, anim, secondAnim, child){
                                final begin = Offset(1, 0);
                                final end = Offset(0, 0);
                                final tween = Tween(begin: begin, end: end);

                                return SlideTransition(
                                  position: anim.drive(tween.chain(CurveTween(curve: Curves.decelerate))),
                                  child: child,
                                );
                              }
                            ));
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                            ),
                            
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: BackdropFilter(
                                  filter: prefix0.ImageFilter.blur(
                                    sigmaX: 10.0,
                                    sigmaY: 10.0
                                  ),
                                  child: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(caption,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white
                                          ),
                                        ),

                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            IconTheme(
                                              data: IconThemeData(
                                                color: Colors.white
                                              ),
                                              child: Icon(Icons.search),
                                            ),
                                            Text("Find workers",
                                              style: TextStyle(
                                                color: Colors.white
                                              ),
                                            ),
                                          ],
                                        )  
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ), 
                  ],
                ),
            ),
          );
}

class Item{
  String image, caption;

  Item(String image, String caption){
    this.image = image;
    this.caption = caption;
  }

}