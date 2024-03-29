import 'dart:convert';
import 'package:bakole/constants/Constants.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/httpModels/Worker.dart';
import 'package:bakole/employer/EmployerActivity.dart';
import 'package:bakole/utils/Utils.dart';
import 'package:bakole/worker/WorkerActivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bakole/main.dart';


Future<Map<String, dynamic>> findUser(String email, String password) async{
  final phoneId = await getPhoneId();
  final url = "$AWS_SERVER_URL/users/$phoneId/$email/$password";

  print(url);
  try{
    final response = await httpClient.get(url);
    
    if(response.statusCode == 200){
      final List<Map<String, dynamic>> users = json.decode(response.body).cast<Map<String, dynamic>>();
      
      final String userType = response.headers["user-type"];
      print("type: $userType");
      
      print(users);
      if(userType == "worker"){
        return {
          "userType" : "worker",
          "user" : Worker.fromJson(users[0])
        };
      }
      else if(userType == "employer"){
        return {
          "userType" : "employer",
          "user" : Employer.fromJson(users[0])
        };
      }
      else{
        return {};
      }
    }
    else {
      return {};
    }
  }catch(e){
    print("Exception in finding user");
    print(e);
    throw (e);
  }
}

Future<bool> _postDeviceToken(String deviceToken, String email,  String userType) async{
  final url = "$AWS_SERVER_URL/users/$deviceToken/$email/$userType";
  try{
    final response = await httpClient.patch(url);

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }catch (e){
    print(e);
    return false;
  }
}

 Future<String> _getDeviceToken(FirebaseMessaging _firebaseMessaging, BuildContext context)async{
    String token = "";
    try{
      token = await _firebaseMessaging.getToken();
      print("token in func: $token");
      Provider.of<FirebaseDeviceToken>(context).setFirebaseToken = token;
      return token;
    }catch (e){
      print(e);
      return "";
    }
  }

class Login extends StatefulWidget{
  @override
  LoginState createState() {
    
    return LoginState();
  }
}

class LoginState extends State<Login>{
  final emailTxt = TextEditingController(); 
  final pswdTxt = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _isLoggingIn = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context){
    const radius = 30.0;

    return Form(
      key: _formKey,
            child: ListView(
            shrinkWrap: true,
            children: <Widget>[

              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius))
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextFormField(
                      validator: (string){
                        if(string.isEmpty){
                          return "field cannot be empty";
                        }
                        return null;
                      },
                      controller: emailTxt,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: IconTheme(
                          data: IconThemeData(size: 25.0, color: Colors.cyan),
                          child: Icon(Icons.email),  
                          ),
                        labelText: "Email address",
                        border: InputBorder.none,
                        ),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Card(

                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(radius))
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextFormField(
                      validator: (string){
                        if(string.isEmpty){
                          return "field cannot be empty";
                        }
                        return null;
                      },
                      controller: pswdTxt,
                      obscureText: _obscureText,

                      decoration: InputDecoration(
                        labelText: "Password",
                        border: InputBorder.none,
                        prefixIcon: IconTheme(
                          data: IconThemeData(size: 25.0, color: Colors.cyan),
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: Material(

                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(24.0)),
                            splashColor: Colors.black12,
                            onTap: (){
                              setState(() {
                                if(_obscureText){
                                  _obscureText = false;
                                }
                                else{
                                  _obscureText = true;
                                }
                              });
                            },
                            child: IconTheme(
                              data: IconThemeData(
                                size: 24.0
                              ),
                              child: Icon(Icons.remove_red_eye),
                            ),
                          ),
                        )
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 6.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Material(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(radius))
                          ),
                          color: Colors.amber,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(radius)),
                            splashColor: Colors.indigo,
                            onTap: () async{
                              setState(() {
                               _isLoggingIn = true; 
                              });
                              final deviceToken = await _getDeviceToken(_firebaseMessaging, context);

                              if(_formKey.currentState.validate()){
                                final email = emailTxt.text;
                                final pswd = pswdTxt.text;
                                print("email: $email password: $pswd");
                                final begin = Offset(1, 0);
                                final end = Offset(0, 0);
                                final tween = Tween(begin: begin, end: end);
                                final Map<String, dynamic> response = await findUser(email, pswd);

                                if(response["userType"] == WORKER){
                                  final Worker worker = response["user"];
                                  await _postDeviceToken(deviceToken, worker.email, WORKER);

                                  print("userType: ${response["userType"]}");
                                  Navigator.push(context, PageRouteBuilder(
                                    pageBuilder: (context, animation, secondAnimation){
                                      print("token in login: ${Provider.of<FirebaseDeviceToken>(context).firebaseToken}");

                                      return WorkerActivity(worker: worker,);
                                    },
                                    transitionsBuilder: (context, animation, secondAnimation, child){
                                      return SlideTransition(
                                        position: animation.drive(tween.chain(CurveTween(curve: Curves.easeIn))),
                                        child: child,
                                      );
                                    },
                                  ));
                                }
                                else if (response["userType"] == EMPLOYER){
                                  final Employer employer = response["user"];
                                  await _postDeviceToken(deviceToken, employer.email, EMPLOYER);

                                  Navigator.push(context, PageRouteBuilder(
                                    pageBuilder: (context, anim, secondAnim){
                                      print("token in login: ${Provider.of<FirebaseDeviceToken>(context).firebaseToken}");

                                      return EmployerActivity(employer);
                                    },
                                    transitionsBuilder: (context, anim, secondAnim, child){
                                      return SlideTransition(
                                        position: anim.drive(tween.chain(CurveTween(curve: Curves.easeIn))),
                                        child: child,
                                      );
                                    },
                                  ));

                                }
                                else {
                                  setState(() {
                                    _isLoggingIn = false;
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("No such user"),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.cyan,
                                      )
                                    );    
                                  });
                                }    
                              }
                              else {
                                setState(() {
                                  _isLoggingIn = false; 
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Invalid field details"),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.blue[200],
                                    )
                                  );
                                });          
                              }
                              
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0),
                              child: _isLoggingIn? 
                                      CircularProgressIndicator():
                                      Text("LOGIN"),
                            )
                          ),
                      ),
                    
                  ],
                ),
              )
            ],
      ),
    );
  }
}