
import 'dart:io';
import 'package:flutter/material.dart';
import '../httpModels/Employer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<Employer> postEmployer (Employer employer) async{
  final url = "http://localhost:3000/users";

  final response = await http.post(url, body: Employer().toMap(employer)).then((response){
    if(response.statusCode == 200){
      print("Connection ok");
      print(response);
      return Employer.fromJson(json.decode(response.body)); 
    }
    else{
      print("error while connecting");
      return Employer(firstName: "empty", lastName:"empty", sex:"empty",email:"empty", phoneNumber:"empty", password:"empty");
    }
  }).catchError((error){
    print("error");
    print(error);
    print("toString" + error.toString());
  });

  return Employer.fromJson({
    "firstname": response.firstName,
    "lastName": response.lastName,
    "sex": response.sex,
    "email": response.email,
    "phoneNumber": response.phoneNumber,
    "password": response.password
  }); 
}

Future<Employer> getEmployer() async{
  final url="";
  final response = await http.get(url);
  if(response.statusCode==200){
    return Employer.fromJson(json.decode(response.body));
  }
  else{
    throw Exception("Error while fetching data");
  }
}


Future<Employer> testGet() async {
  var response = await http.get("https://jsonplaceholder.typicode.com/posts/1");

  int code = response.statusCode;

  if(code == 200){
    print("connection successful");
    return Employer(firstName: "empty", lastName:"empty", sex:"empty",email:"empty", phoneNumber:"empty", password:"empty");
  }
  else{
    
    print("Erro while connecting");
    throw Exception("problem connecting");
  }
  
}

class WorkerSignUp extends StatefulWidget{
  @override
  WorkerSignUpState createState() {  
    return WorkerSignUpState();
  }
}

class WorkerSignUpState extends State<WorkerSignUp>{
  final firstNameTxt = TextEditingController(); 
  final lastNameTxt = TextEditingController();
  final sexTxt = TextEditingController();
  final emailTxt = TextEditingController();
  final phoneNumTxt = TextEditingController();  
  final pswdTxt = TextEditingController();  
  final confirmPswdTxt = TextEditingController();

  String firstName, lastName, sex, email, phoneNum, pswd, confirmPswd;
  final _formKey = GlobalKey<FormState>();
  final emptyFieldMsg = "Field cannot be empty";

  @override
  Widget build(BuildContext context){
    final radius = 10.0;

    return Form(
            key: _formKey,

            child: SingleChildScrollView(

            child: Column(
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
                          controller: firstNameTxt,
                          validator: (string){
                          
                          if(string.trim() == ""){
                            return emptyFieldMsg;
                          }
                          return null;
                        },
                        
                        decoration: InputDecoration(
                          labelText: "First name",
                          border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                ),

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
                        controller: lastNameTxt,
                        validator: (string){
                          if(string.trim() == ""){
                            return emptyFieldMsg;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Last name",
                          border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                ),

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
                        controller: sexTxt,
                        validator: (string){
                          if(string.trim().isEmpty){
                            return emptyFieldMsg;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Sex",
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
                      borderRadius: BorderRadius.all(Radius.circular(radius))
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextFormField(
                        controller: emailTxt,
                        validator: (string){
                          if(string.trim().isEmpty){
                            return emptyFieldMsg;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
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
                      borderRadius: BorderRadius.all(Radius.circular(radius))
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextFormField(
                        controller: phoneNumTxt,
                        validator: (string){
                          if(string.trim().isEmpty){
                            return emptyFieldMsg;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone number",
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
                      borderRadius: BorderRadius.all(Radius.circular(radius))
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextFormField(
                        validator: (string){
                          if(string.trim().isEmpty){
                            return emptyFieldMsg;
                          }
                          else if(!(confirmPswdTxt.text == string)){
                            return "fields don't match";
                          }
                          return null;
                        },
                        obscureText: true,
                        controller: pswdTxt,
                        decoration: InputDecoration(
                          labelText: "Password",
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
                      borderRadius: BorderRadius.all(Radius.circular(radius))
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextFormField(
                        controller: confirmPswdTxt,
                        validator: (string){
                          if(string.trim().isEmpty){
                            return emptyFieldMsg;
                          }
                          else if(!(pswdTxt.text == string)){
                            return "fields don't match";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Confirm password",
                          border: InputBorder.none,
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
                              borderRadius: BorderRadius.all(Radius.circular(radius)),
                              splashColor: Colors.black26,
                              onTap: (){

                                if(_formKey.currentState.validate()){
                                  
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Uploading details"),
                                      backgroundColor: Colors.cyan,
                                      duration: Duration(seconds: 2),
                                  ));

                                  postEmployer(Employer(
                                    firstName: firstNameTxt.text,
                                    lastName: lastNameTxt.text,
                                    sex: sexTxt.text,
                                    email: emailTxt.text,
                                    phoneNumber: phoneNumTxt.text,
                                    password: pswdTxt.text,
                                  ));

                                
                                }
                                else{
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Invalid fields"),
                                      backgroundColor: Colors.amber,
                                      duration: Duration(seconds: 2),
                                  ));
                                }  
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                                child: Text("SIGN UP"),
                              )
                            ),
                        ),
                    ],
                  ),
                )
              ],
            ),
      ),
    );
  }

  @override
  void dispose(){
    firstNameTxt.dispose();
    lastNameTxt.dispose();
    sexTxt.dispose();
    emailTxt.dispose();
    phoneNumTxt.dispose();
    pswdTxt.dispose();
    confirmPswdTxt.dispose();

    super.dispose();
  }
}