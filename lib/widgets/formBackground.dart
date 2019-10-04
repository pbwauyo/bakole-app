import 'package:flutter/material.dart';
import './login.dart';
import './signUp.dart';
import '../clippers/imageClipper.dart';

class FormBackground extends StatefulWidget{
  @override
  FormBackgroundState createState(){
    return FormBackgroundState();
  }
}

class FormBackgroundState extends State<FormBackground>{
  final containerRadius = 8.0;
  Widget currentWidget = Login();
  String currentWigdetName = "Login";
  String topButtonTxt = "Not registered?";

  @override
  Widget build(BuildContext context){
    final radius = 10.0;

    return Scaffold(
          body: SafeArea(  
              child: Column(
                children: <Widget>[
                  Stack(
                      children:  <Widget>[
                        ClipPath(
                          clipper: ImageClipper(),
                          child: Container(
                            height: 220,
                            child: Image(
                              colorBlendMode: BlendMode.darken,
                              image: AssetImage("assets/images/cleaning.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Positioned(
                          right: 20,
                          bottom: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          if(currentWigdetName == "Login"){
                                            setState(() {
                                              currentWidget = SignUp();
                                              topButtonTxt = "Already registered?";
                                              currentWigdetName = "Sign up";
                                            });
                                            
                                          }
                                          else{
                                            setState(() {
                                              currentWidget = Login();
                                              topButtonTxt = "Not registered?";
                                              currentWigdetName = "Login";
                                            });
                                          }  
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                                          child: Text(topButtonTxt),
                                        )
                                    ),
                                ),
                              
                            ],
                          ),
                        ),
                    ],
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      child: AnimatedSwitcher(
                        transitionBuilder: (Widget child, Animation<double> animation){
                          return ScaleTransition(
                            child: child,
                            scale: animation,
                          );
                          },
                        child: currentWidget,
                        duration: const Duration(seconds: 1),
                        ),
                    ),
                  ),

          ],
        ),
      ),
    );
  }
}