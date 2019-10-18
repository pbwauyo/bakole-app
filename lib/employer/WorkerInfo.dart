import 'dart:convert';
import 'package:bakole/employer/AddJob.dart';
import 'package:bakole/constants/Constants.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'dart:async';
import 'package:bakole/httpModels/Worker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import "package:http/http.dart" as http;

Future<Worker> getWorker(String workerId) async {
  final url = "$LOCAL_HOST/workers/ids/" + workerId;

  try{
    final response = await http.get(url);

    if(response.statusCode == 200){
      List<Map<String, dynamic >> responseBody = json.decode(response.body).cast<Map<String, dynamic>>();
      return Worker.fromJson(responseBody[0]);
    }
    else{
      
      throw("throwing error");
    }
  }catch(e){
    print("Exception in getting worker");
    print(e);
    throw(e);
  }

}

class WorkerInfo extends StatelessWidget{
  
  final Future<Worker> fetchWorker;
  final String workerId;
  final String category;
  final Employer employer;
  
  
  final Map<String, Color> skillColors = {
    "Elite Worker": Colors.green[700],
    "Pro Worker": Colors.amber,
    "Basic Worker": Colors.cyan
  };

  WorkerInfo({@required this.workerId, @required this.employer, @required this.category}) : fetchWorker = getWorker(workerId);

  @override
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.blue, 
      )
    );

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Worker>(
          future: fetchWorker,
          builder:(context, snapshot) {
            Worker worker = snapshot.data;

            if(worker == null ){
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            
            else 
            return Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    child: Image.asset(
                      "assets/images/cleaning_mop.jpg",
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.darken,
                      color: Color(0XB3000000),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 150,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 160.0,
                                height: 160.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: skillColors[worker.skillStatus],
                                    width: 2.0
                                    
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/default_pic.png"), 
                                    fit: BoxFit.cover,
                                  )
                                ), 
                              ),
                            ),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Card(
                                margin: EdgeInsets.only(top: 8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(worker.skillStatus, 
                                    style: TextStyle(color: skillColors[worker.skillStatus]),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(worker.firstName + " " + worker.lastName,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),

                      Container(
                        child: RatingBar(
                          initialRating: double.parse(worker.rating),
                          allowHalfRating: true,
                          direction: Axis.horizontal,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemCount: 5,
                          ignoreGestures: true,
                          itemSize: 30.0,
                          itemBuilder: (context, _)=>Icon(
                            Icons.star,
                            color: skillColors[worker.skillStatus],
                          ),
                          onRatingUpdate: (rating){

                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  child: Material(
                                    color: Colors.green[400],
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    child: InkWell(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      onTap: (){
                                        Navigator.of(context).push(PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) => AddJob(workerId: workerId, employer: this.employer, category: category,),
                                          transitionDuration: Duration(seconds: 1),
                                          transitionsBuilder: (context, animation, secondaryAnimation, child){
                                            var begin = Offset(0, 1);
                                            var end = Offset(0, 0);
                                            var curve = Curves.ease;
                                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            ); 

                                          }
                                        ));
                                      },
                                      child: Center(child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        child: Text("Hire Me!", style: TextStyle(color: Colors.white,)),
                                      )),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Container(
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Color(0X00FFFFFF),  
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("See Reviews", 
                              style: TextStyle(color: Colors.white, fontSize: 18), ),
                            ),
                            
                            onTap: (){
                            },
                            splashColor: Colors.white24,
                            ),
                          ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  
}

