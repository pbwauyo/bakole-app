import 'dart:convert';

import 'package:bakole/constants/Constants.dart';
import 'package:bakole/employer/AddJob.dart';
import 'package:bakole/employer/JobDetails.dart';
import 'package:bakole/httpModels/EmployerJob.dart';
import 'package:bakole/utils/Utils.dart';
import 'package:flutter/material.dart';

Future <List<EmployerJob>> getPostedJobs(String email) async{
  final url = "$AWS_SERVER_URL/employers/jobs/$email";

  try {
    final response = await httpClient.get(url);
    if(response.statusCode == 200){
      final List<Map<String, dynamic>> parsedResponse = json.decode(response.body).cast<Map<String, dynamic>>();
      final List<EmployerJob> jobs = parsedResponse.map((json)=>EmployerJob.fromJson(json)).toList();
      print(jobs);
      return jobs;
    }
    else {
      return [];
    }
  }catch(error){
    print(error);
    return [];
  }

}

class ViewJobs extends StatefulWidget{
  final String email;

  ViewJobs({@required this.email});

  @override
  createState() => ViewJobsState();
}

class ViewJobsState extends State<ViewJobs>{
  final Map<String, int> statusIndices = {
    Status.PENDING : 0,
    Status.ACTIVE : 1
  };

  Future<List<EmployerJob>> future;

  @override
  void initState() {
    super.initState();

    final String email = widget.email;
    future = getPostedJobs(email);
  }

  @override
  build(context) {

    return Container(
      child: FutureBuilder<List<EmployerJob>>(
        future: future,
        builder: (context, snapshot) {
          if(snapshot.data == null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          else if(snapshot.hasError){
            return Center(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: "Error: ",
                      style: TextStyle(color: Colors.red)
                    ),
                    TextSpan(
                      text: "${snapshot.error.toString()}"
                    )
                  ]
                ),
              ),
            );
          }

          else if(snapshot.data.length == 0){
            return Center(
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: "No ",
                          style: TextStyle(color: Colors.red)
                      ),
                      TextSpan(
                          text: "jobs to show"
                      )
                    ]
                ),
              ),
            );
          }


          final List<EmployerJob> employerJobs = snapshot.data;

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder:(context, index) {
              EmployerJob employerJob = employerJobs[index];
              //print(employerJob.job.getJobId);
              print(employerJob.job);


              return Container(
                margin: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 5.0, right: 5.0),
                child: Material(
                  borderRadius: BorderRadius.circular(8.0),
                  elevation: 5.0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    splashColor: Colors.black12,
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute<JobDetails>(
                        builder: (context) => JobDetails(jobId: employerJob.job.jobId,)
                      ));
                    },
                    child: Stack(
                      children: <Widget>[
                        Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          //row with the icon and job description
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: IconTheme(
                                    data: IconThemeData(
                                      size: 48.0,
                                      color: Colors.lightBlue
                                    ),
                                    child: Icon(Icons.business_center),
                                  )
                                ),
                              ),

                              Container(
                                child: Text(employerJob.job.description,
                                  style: TextStyle(fontSize: 16,),
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),

                          //faded line
                          FadedLine(),

                          //widget with the bottom fields
                          Container(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("UGX ${employerJob.job.fee}")
                                  ],
                                ),

                                Bids(),

                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Dot(statusIndex: statusIndices[employerJob.status],),
                                    ),

                                    Text(employerJob.status,
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            )
                          )
                        ],
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 2.0, right: 8.0),
                            child: Text("Just now",
                              style: TextStyle(fontSize: 12.5, color: Colors.black45),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        },
      ),
    );
  }
}


//will indicate the number of bids e.g 0 Bids
class Bids extends StatefulWidget{

  final int numberOfBids = 0;

  @override
  createState() => BidsState();
}

class BidsState extends State<Bids>{

  @override
  Widget build(BuildContext context) {

    return Container(
      child: RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: "${widget.numberOfBids} ",
                  style: TextStyle(color: Colors.green)
              ),
              TextSpan(
                  text: "BIDS"
              )
            ]
        ),
      )
    );
  }
}

//will show elapsed time
class ElapsedTime extends StatefulWidget{
    final String startDate, startTime;
    ElapsedTime({@required this.startDate, @required this.startTime});
    final String elapsedTime = "0";

    @override
    State<ElapsedTime> createState() {

    return ElapsedTimeState();
    }
}

class ElapsedTimeState extends State<ElapsedTime>{

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Text("${widget.elapsedTime} mins ago"),
    );
  }
}

