import 'dart:convert';

import 'package:bakole/constants/Constants.dart';
import 'package:bakole/employer/AddJob.dart';
import 'package:bakole/employer/EmployerActivity.dart';
import 'package:bakole/employer/SearchWorkers.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/httpModels/Worker.dart';
import 'package:bakole/utils/Utils.dart';
import 'package:bakole/worker/JobPreview.dart';
import 'package:bakole/worker/WorkerActivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'fragments/trending.dart';
import 'fragments/cleaning.dart';
import 'fragments/handyman.dart';
import 'fragments/moving.dart';
import './widgets/FormBackground.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MyApp());
}

Future<Map<String,  dynamic>> _getLoggedInUser() async{
  final String id = await getPhoneId();
  final String url = "$AWS_SERVER_URL/users/$id";
  print("url: $url");
  var user;

  try{
    final response = await http.get(url);

    if(response.statusCode == 200){
      final userType = response.headers["user-type"];
      final parsedResponse = json.decode(response.body);
      final list = parsedResponse.cast<Map<String, dynamic>>();

      if(userType == WORKER){
        user = Worker.fromJson(list[0]);

        return {
          "user-type" : WORKER,
          "user" : user
        };
      }
      else if (userType == EMPLOYER){
        user = Employer.fromJson(list[0]);
        return {
          "user-type" : EMPLOYER,
          "user" : user
        };
      }
      else{
        return {};
      }
    }

    else{
      return {};
    }
  }catch(err){
    print(err);
    return {};
  }

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  String deviceToken;
  Future<Map<String, dynamic>> loggedInUserFuture;

  @override
  void initState() {
    super.initState();
    _configureFirebaseNotifications();
    loggedInUserFuture = _getLoggedInUser();
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
          '/': (context) => FutureBuilder<Map<String, dynamic>>(
            future: loggedInUserFuture,
            builder: (context, snapshot){
              if(snapshot.data == null){
                return Scaffold(
                  body: SafeArea(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
              else if(snapshot.data.length == 0){
                return FormBackground();
              }
              else{
                final user = snapshot.data;
                if(user["user-type"] == WORKER){
                  return WorkerActivity(
                    worker: user["user"],
                  );
                }else{
                  return EmployerActivity(user["user"]);
                }
              }
            }

          ),
          '/home': (context) => HomePage("How can we help you?"),
          '/login' : (context) => FormBackground(),
          
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