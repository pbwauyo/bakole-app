import 'package:bakole/clippers/RectClipper.dart';
import 'package:bakole/httpModels/Job.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class JobPreview extends StatelessWidget{
  
  final Job job;
  JobPreview({@required this.job});

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
                                job.employerName,
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

                              Text(job.category),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: "avatar",
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/profile_pic.jpg"),
                        radius: 50.0,
                      ),
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
                          job.startDate, 
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
                          job.startTime, 
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
                              child: Text(job.fee),
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
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("WHAT YOU WILL BE DOING"),
                    ),
                    Text(job.description,
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

          Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.green[400],
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    splashColor: Colors.black38,
                    onTap: (){

                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 16.0, left: 16.0),
                      child: Text("ACCEPT", 
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ),
                ),

                Material(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.red[400],
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    splashColor: Colors.black38,
                    onTap: (){

                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 16.0, left: 16.0),
                      child: Text("DECLINE", 
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}



