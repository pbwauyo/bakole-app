import 'package:bakole/constants/Constants.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget{
  final double _bottomMargin = 5.0;
  final double _topMargin = 5.0;
  final Color _iconColor = Colors.blueAccent;
  final double _iconLeftPadding = 5.0;

  final String userType;

  final String name;
  final String rating;
  final String email;
  final String phone;
  final String sex;
  final String averagePay;
  final String skillStatus;
  final String category;

  Profile({this.userType, this.name, this.rating, this.email, this.phone, this.sex, this.averagePay, this.skillStatus, this.category});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: _topMargin, bottom: _bottomMargin),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: _iconLeftPadding),
                      child: IconTheme(
                        data: IconThemeData(
                            color: _iconColor
                        ),
                        child: Icon(Icons.email),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(email),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: _topMargin),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: _iconLeftPadding),
                      child: IconTheme(
                        data: IconThemeData(
                            color: _iconColor
                        ),
                        child: Icon(Icons.phone),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(phone),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: _iconLeftPadding),
                margin: EdgeInsets.only(top: _topMargin),
                child: Row(
                  children: <Widget>[
                    IconTheme(
                      data: IconThemeData(
                          color: _iconColor
                      ),
                      child: Icon(Icons.person),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(sex),
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: userType == UserType.WORKER,
                child: Container(
                  padding: EdgeInsets.only(left: _iconLeftPadding),
                  margin: EdgeInsets.only(top: _topMargin),
                  child: Row(
                    children: <Widget>[
                      IconTheme(
                        data: IconThemeData(
                            color: _iconColor
                        ),
                        child: Icon(Icons.attach_money),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("UGX 25000"),
                      ),
                    ],
                  ),
                ),
              ),

              Visibility(
                visible: userType == UserType.WORKER,
                child: Container(
                  padding: EdgeInsets.only(left: _iconLeftPadding),
                  margin: EdgeInsets.only(top: _topMargin, bottom: _bottomMargin),
                  child: Row(
                    children: <Widget>[
                      IconTheme(
                        data: IconThemeData(
                            color: _iconColor
                        ),
                        child: Icon(Icons.star),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("ELite Worker"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        Visibility(
          visible: userType == UserType.WORKER,
          child: Container(
            margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15.0)
            ),
            child: Text("Categories",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

        Visibility(
          visible: userType == UserType.WORKER,
          child: Card(
            elevation: 8.0,
            child: Container(
              padding: EdgeInsets.only(left: _iconLeftPadding),
              margin: EdgeInsets.only(top: _topMargin, bottom: _bottomMargin),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                    child: Chip(
                      avatar: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage("assets/images/moving.jpg"),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                      label: Text(category,
                        style: TextStyle(
                            color: Colors.white
                        ),),
                      backgroundColor: Colors.purple,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}