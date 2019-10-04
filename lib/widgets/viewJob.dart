import 'package:bakole/clippers/rectClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class JobPreview extends StatelessWidget{
  @override
  build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ListView(
        children: <Widget>[
          Card(
            elevation: 2.0,
            child: Container(
              width: double.infinity,
              height: 300,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: 150.0,
                        child: Image(
                          image: AssetImage("assets/images/pizza.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Papa Peter's Pizza",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),

                              RatingBar(
                                initialRating: 4,
                                direction: Axis.horizontal,
                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemCount: 5,
                                itemSize: 30.0,
                                itemBuilder: (context, _)=>Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating){

                                },
                              ),

                              Text("Delivery"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: Colors.lime[200],
                      backgroundImage: AssetImage("assets/images/profile_pic.jpg"),
                      radius: 50.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Card(
            elevation: 2.0,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.amber,
                          ),
                        ),

                        Text(
                          "Wed, Sep 19 - Thu, Sep 19", 
                        ),
                      ],
                    ),

                     Row(                      
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.access_time,
                            color: Colors.amber,
                            
                          ),
                        ),

                        Text(
                          "2:00 pm - 6:00 pm", 
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.cached,
                            color: Colors.amber,
                          ),
                        ),

                        Text(
                          "One day job", 
                        ),
                      ],
                    ),
                  ],
                ),

                Align(
                  alignment: Alignment.topRight,
                  child: ClipPath(
                    clipper: RectClipper(),
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: 50,
                      height: 60,
                      color: Colors.amber,
                      child: Column(
                        children: <Widget>[
                          Text("UGX"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text("800,000"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          Card(
            elevation: 2.0,
            child: Container(
              width: double.infinity,

              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("WHAT YOU WILL BE DOING"),
                    ),
                    Text("Use your cell phone to navigate to locations and complete deliveries with our delivery app. Use your own car to deliver 10-15 meals within a 5 mile radius of our location. Communicate clearly and professionally with customers upon arrival with their meal. NOTE: Mileage and tolls will be added into the final pay after route is complete. Keeep your own tips!",
                      maxLines: null,
                      style: TextStyle(color: Color(0XFF808080)),
                    ),
                  ],
                ),
              ),
            ),
            
          ),

          Card(
            elevation: 2.0,
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Column(
                  children: <Widget>[
                     Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("REQUIREMENTS"),
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.done_all,
                            color: Colors.amber,
                          ),
                        ),

                        Flexible(
                          fit: FlexFit.loose,
                          child: Text("Must have a valid Driver's License and Vehicle Insurance",
                            maxLines: null,
                            style: TextStyle(
                              color: Color(0XFF808080),
                            ),
                          ),
                        )

                      ],
                    ),

                    Row(
                      
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.done_all,
                          color: Colors.amber,
                        ),
                      ),

                      Flexible(
                        fit: FlexFit.loose,
                        child: Text("Bring your own car(clean and with gas)",
                          maxLines: null,
                          style: TextStyle(
                            color: Color(0XFF808080),
                          ),
                        ),
                      )

                    ],
                  ),

                     Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.done_all,
                            color: Colors.amber,
                          ),
                        ),

                        Flexible(
                          fit: FlexFit.loose,
                          child: Text("Have access to GPS or Google Maps for navigation, bring a car charger",
                            maxLines: null,
                            style: TextStyle(
                              color: Color(0XFF808080),
                            ),
                          ),
                        )

                      ],
                    ),

                    Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.done_all,
                          color: Colors.amber,
                        ),
                      ),

                      Flexible(
                        fit: FlexFit.loose,
                        child: Text("Strong customer service skills, be polite",
                          maxLines: null,
                          style: TextStyle(
                            color: Color(0XFF808080),
                          ),
                        ),
                      )

                    ],
                  ),

                    Row(

                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.done_all,
                          color: Colors.amber,
                        ),
                      ),

                      Flexible(
                        fit: FlexFit.loose,
                        child: Text("Detailed focussed, and responds quickly to new orders",
                          maxLines: null,
                          style: TextStyle(
                            color: Color(0XFF808080),
                          ),
                        ),
                      )

                    ],
                  ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}



