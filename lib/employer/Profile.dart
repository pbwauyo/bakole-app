import 'package:bakole/employer/EmployerActivity.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Profile extends StatefulWidget{
  final Employer employer;
  Profile({@required this.employer});

  @override
  createState ()=> ProfileState();
}

class ProfileState extends State<Profile>{
  final double radius = 20.0;

  @override
  build(context) {

    final Employer _employer = widget.employer;

    return Container(

      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/cleaning_mop.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 15.0),
                              child: Text(_employer.lastName,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            margin: EdgeInsets.only(top: 30.0),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 8.0),
                            child: Text(_employer.email),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    child: Image(
                      image: AssetImage("assets/images/default_pic.png"),
                      fit: BoxFit.cover,
                    ),
                    radius: 40.0,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                      border: Border.all(
                        color: Colors.black26,
                        width: 2.0,
                      )
                  ),
                  margin: EdgeInsets.only(top: 60.0, right: 8.0),
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                    child: InkWell(
                      onTap: (){

                      },
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                      splashColor: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0, bottom: 8.0),
                        child: Text("Edit Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(

                          ),

                        ),
                      ),
                    ),
                  ),

                ),
              )
            ],
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 8.0),
            child: RatingBar(
              onRatingUpdate: (rating){

              },
              itemCount: 5,
              itemBuilder: (context, item){
                return Icon(Icons.star,
                  color: Colors.lightBlue,
                );
              },
              glow: true,
              glowRadius: 3.0,
              glowColor: Colors.white,
              initialRating: _employer.ratingExists() ? double.parse(_employer.rating) : 0.0,
              allowHalfRating: true,
              ignoreGestures: true,
              itemSize: 25.0,
              unratedColor: Colors.grey,
            ),
          )
        ],
      ),

  );
  }
}