import 'package:bakole/httpModels/employer.dart';
import 'package:bakole/widgets/availableEmployees.dart';
import 'package:bakole/widgets/employer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget{
  final Employer employer;
  Home({@required this.employer});

  @override
  createState() => HomeState();
}

class HomeState extends State<Home>{
  final List <String> images = ["cleaning.jpg", "construction.jpg", "handyman.jpg", "moving.jpg", "painting.jpg"];
  final List<String> imageNames = ["Cleaning services", "Construction work", "Handyman services", "Moving goods", "Painting work"];

  List<Item> items = []; 

  @override
  build(context){ 
    items = buildItems();

    return Scaffold(
      appBar: AppBar(
        title: Text("How can we help you?"),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(items.length, (index){  
            return Categories(items.elementAt(index).image, items.elementAt(index).caption, employer: Provider.of<EmployerProvider>(context).employer,);
          }),
        ),
      ),

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
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 120,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
                        child: Image(image: AssetImage("assets/images/$imageUrl"), fit: BoxFit.cover, ),
                      ),
                    ),
                    Text(caption),
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                      color: Colors.cyan,
                      
                      child: InkWell(
                        splashColor: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(radius)),
                        onTap: (){
                          Navigator.push(context, PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 10.0, right: 10.0),
                          child: Text("Find workers"),
                        )
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