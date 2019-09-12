import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

class Login extends StatefulWidget{
  @override
  State<Login> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login>{
  final emailTxt = TextEditingController(); 
  final pswdTxt = TextEditingController(); 

  @override
  Widget build(BuildContext context){
    final radius = 10.0;

    return ListView(
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
                child: TextField(
                  controller: emailTxt,
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
                child: TextField(
                  controller: pswdTxt,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
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
                          Navigator.pushNamed(context, '/home');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                          child: Text("LOGIN"),
                        )
                      ),
                   ),
                 
              ],
            ),
          )
        ],
    );
  }
}