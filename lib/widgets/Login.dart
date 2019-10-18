import 'dart:convert';
import 'package:bakole/constants/Constants.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/httpModels/Worker.dart';
import 'package:bakole/employer/EmployerActivity.dart';
import 'package:bakole/worker/WorkerActivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> findUser(String email, String password) async{
  final url = "$LOCAL_HOST/users/$email/$password";
  try{
    final response = await http.get(url);
    
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

class Login extends StatefulWidget{
  @override
  LoginState createState() {
    
    return LoginState();
  }
}

class LoginState extends State<Login>{
  final emailTxt = TextEditingController(); 
  final pswdTxt = TextEditingController();
  final _formKey = GlobalKey<FormState>() ;
  bool _isLoggingIn = false;

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
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: InputBorder.none,
                        prefixIcon: IconTheme(
                          data: IconThemeData(size: 25.0, color: Colors.cyan),
                          child: Icon(Icons.lock),
                        ),
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

                              if(_formKey.currentState.validate()){
                                final email = emailTxt.text;
                                final pswd = pswdTxt.text;
                                print("email: $email password: $pswd");
                                final begin = Offset(1, 0);
                                final end = Offset(0, 0);
                                final tween = Tween(begin: begin, end: end);
                                final Map<String, dynamic> response = await findUser(email, pswd);

                                if(response["userType"] == "worker"){
                                  print("userType: ${response["userType"]}");
                                  Navigator.push(context, PageRouteBuilder(
                                    pageBuilder: (context, animation, secondAimation){
                                      return WorkerActivity(worker: response["user"],);
                                    },
                                    transitionsBuilder: (context, animation, secondAnimation, child){
                                      return SlideTransition(
                                        position: animation.drive(tween.chain(CurveTween(curve: Curves.easeIn))),
                                        child: child,
                                      );
                                    },
                                  ));
                                }
                                else if (response["userType"] == "employer"){

                                  Navigator.push(context, PageRouteBuilder(
                                    pageBuilder: (context, anim, secondAnim){
                                      Employer employer = response["user"];
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