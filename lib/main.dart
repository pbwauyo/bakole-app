import 'package:bakole/employer/AddJob.dart';
import 'package:bakole/employer/SearchWorkers.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/worker/JobPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'fragments/trending.dart';
import 'fragments/cleaning.dart';
import 'fragments/handyman.dart';
import 'fragments/moving.dart';
import './widgets/FormBackground.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  String deviceToken;

  @override
  void initState() {
    super.initState();
    _configureFirebaseNotifications();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.blue));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context){
          return FirebaseDeviceToken();
        }),
      ],
      child: MaterialApp(
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
      ),
    );
  }

  void _configureFirebaseNotifications() {

    _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async{
        print("Notification received in onLaunch");
        print(message);

      },
      onMessage: (Map<String, dynamic> message) async{
        print("Notification received in onMessage");
        print(message);
      },
      onResume: (Map<String, dynamic> message)async{
        print("Notification received in onMessage");
        print(message);
      },
      // onBackgroundMessage: (context){

      // }
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

class FirebaseDeviceToken with ChangeNotifier{
  String _fbToken;

  get firebaseToken{
    return this._fbToken;
  }

 set setFirebaseToken(String token){
   this._fbToken = token;
   notifyListeners();
 }
}