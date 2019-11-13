import 'package:bakole/clippers/RectClipper.dart';
import 'package:bakole/constants/Constants.dart';
import 'package:bakole/httpModels/Job.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Future<bool> acceptJob(String id) async {
  final String url = "$AWS_SERVER_URL/jobs/accept/$id";

  try {
    final response = await httpClient.post(url);
    if (response.statusCode == 200) {
      return true;
    }
    else{
      return false;
    }
  }
  catch(err){
    print(err);
    return false;
  }
}

Future declineJob(String id) async {
  final String url = "$AWS_SERVER_URL/jobs/decline/$id";

  try {
    final response = await httpClient.post(url);
    if (response.statusCode == 200) {
      return true;
    }
    else{
      return false;
    }
  }
  catch(err){
    print(err);
    return false;
  }
}

class JobPreview extends StatefulWidget{
  
  final Job job;
  final int index;
  JobPreview({@required this.job, @required this.index});

  @override
  _JobPreviewState createState() => _JobPreviewState();
}

class _JobPreviewState extends State<JobPreview> {
  bool acceptButtonClicked = false;

  bool declineButtonClicked = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  build(BuildContext context) => Scaffold(
    key: scaffoldKey,
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
                          image: AssetImage("assets/images/profile_pic.jpg"),
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.hardLight,
                          color: Colors.lightBlue,
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
                                widget.job.employerName,
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

                              Text(widget.job.category),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: "avatar${widget.index}",
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
                          widget.job.startDate,
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
                          widget.job.startTime,
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
                              child: Text(widget.job.fee),
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
                    Text(widget.job.description,
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
                          padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.all(8.0),
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
                          padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.all(8.0),
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
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.green[400],
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    splashColor: Colors.black38,
                    onTap: () async{
                      setState(() {
                        acceptButtonClicked = true;
                      });

                      final result = await acceptJob(widget.job.id);

                      if(result){
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                          duration: Duration(seconds: 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), topLeft: Radius.circular(4.0)),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconTheme(
                                data: IconThemeData(
                                    color: Colors.green
                                ),
                                child: Icon(Icons.check_circle),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("Success!")
                              )
                            ],
                          ),
                        ));
                      }
                      else{
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                          duration: Duration(seconds: 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), topLeft: Radius.circular(4.0)),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconTheme(
                                data: IconThemeData(
                                    color: Colors.red
                                ),
                                child: Icon(Icons.cancel),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text("Failure!")
                              )
                            ],
                          ),
                        ));
                      }

                      setState(() {
                        acceptButtonClicked = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 16.0, left: 16.0),
                      child: acceptButtonClicked ?
                      Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator()
                      ) :
                      Text("ACCEPT",
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
                    onTap: () async{
                      setState(() {
                        declineButtonClicked = true;
                      });

                      final result = await declineJob(widget.job.id);

                      if(result){
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                          duration: Duration(seconds: 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), topLeft: Radius.circular(4.0)),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconTheme(
                                data: IconThemeData(
                                  color: Colors.green
                                ),
                                child: Icon(Icons.check_circle),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("Success!")
                              )
                            ],
                          ),
                        ));
                      }
                      else{
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                          duration: Duration(seconds: 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), topLeft: Radius.circular(4.0)),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconTheme(
                                data: IconThemeData(
                                    color: Colors.red
                                ),
                                child: Icon(Icons.cancel),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text("Failure!")
                              )
                            ],
                          ),
                        ));
                      }

                      setState(() {
                        declineButtonClicked = false;
                      });

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 16.0, left: 16.0),
                      child: declineButtonClicked ?
                      Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator()
                      ) :
                      Text("DECLINE",
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



