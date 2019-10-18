import 'package:bakole/employer/AddJob.dart';
import 'package:bakole/employer/SearchWorkers.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/worker/JobPreview.dart';
import 'package:flutter/material.dart';
import 'fragments/trending.dart';
import 'fragments/cleaning.dart';
import 'fragments/handyman.dart';
import 'fragments/moving.dart';
import './widgets/FormBackground.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.blue));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FormBackground(),
        '/home': (context) => HomePage("How can we help you?"), 
        
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget{
  HomePage(this.title);

  final String title;

  Widget build(BuildContext context){
    return DefaultTabController(
              length: 4,
              child: Scaffold(
                  appBar: AppBar(
                    title: Text(title),
                    bottom: PreferredSize(
                      preferredSize: tab.preferredSize,
                      child: Card(
                              elevation: 8,
                              child: tab,
                            ),
                      ),
                  ),
                
                  body: TabBarView(
                    children: <Widget>[
                      Trending(),
                      Cleaning(),
                      Handyman(),
                      Moving(),
                    ],
                  ),       
              )
    );
  }
}

final tab = TabBar(
  tabs: <Tab>[
    Tab(icon: Icon(Icons.whatshot, color: Colors.amber), text: "Trending"),
    Tab(icon: Icon(Icons.brush, color: Colors.amber), text: "Cleaning"),
    Tab(icon: Icon(Icons.build, color: Colors.amber), text: "Handyman"),
    Tab(icon: Icon(Icons.subscriptions, color: Colors.amber), text: "Moving", )
  ],
  labelColor: Colors.black,
  labelStyle: TextStyle(
    fontSize: 13.0,
  ),
  isScrollable: true,
);





