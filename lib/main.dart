import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fragments/trending.dart';
import 'fragments/cleaning.dart';
import 'fragments/handyman.dart';
import 'fragments/moving.dart';
import './widgets/formBackground.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.blue));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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





