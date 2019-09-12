import 'package:flutter/material.dart';

class SignUp extends StatefulWidget{
  @override
  State<SignUp> createState() {
    // TODO: implement createState
    return SignUpState();
  }
}

class SignUpState extends State<SignUp>{
  final firstNameTxt = TextEditingController(); 
  final lastNameTxt = TextEditingController();
  final sexTxt = TextEditingController();
  final emailTxt = TextEditingController();
  final phoneNumTxt = TextEditingController();  
  final pswdTxt = TextEditingController();  
  final confirmPswdTxt = TextEditingController();

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
                  controller: firstNameTxt,
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
                child: TextField(
                  controller: lastNameTxt,
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
                child: TextField(
                  controller: sexTxt,
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
                  controller: phoneNumTxt,
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
                  controller: confirmPswdTxt,
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
    );
  }
}