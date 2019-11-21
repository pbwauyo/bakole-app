import 'dart:convert';

import 'package:bakole/constants/Constants.dart';
import 'package:bakole/employer/JobProgress.dart';
import 'package:bakole/httpModels/Job.dart';
import 'package:bakole/httpModels/Worker.dart';
import 'package:bakole/utils/Utils.dart';
import 'package:flutter/material.dart';

Future<List<Map<String, dynamic>>> findJobWorkers(String jobId) async{
  final String url = "$AWS_SERVER_URL/employers/jobs/find/$jobId";
  print("jobId");
  print(jobId);
  final List <Map<String, dynamic>> results = [];
  try{
    final response = await httpClient.get(url);

    if(response.statusCode == 200){
      final List <Map <String, dynamic>> parsedResponse = json.decode(response.body).cast<Map<String, dynamic>>();
      Job job;
      String workerId, workerUrl;

      for(var map in parsedResponse){
        job = Job.fromJson(map);
        workerId = job.getWorkerId;
        workerUrl = "$AWS_SERVER_URL/workers/ids/$workerId";

        final res = await httpClient.get(workerUrl);

        if(res.statusCode == 200){
          final List<Map<String , dynamic>> parsedRes = json.decode(res.body).cast<Map<String , dynamic>>();
          final Worker worker = Worker.fromJson(parsedRes[0]);
          results.add(
            {
              "worker" : worker,
              "job" : job
            }
          );
        }

      }
      print("results: ");
      print(results);
      return results;
    }
    else{
      print("results2: ");
      print(results);
      return results;
    }
  }catch(error){
    print(error);
    print("results3: ");
    print(results);
    return results;
  }
}

class JobDetails extends StatefulWidget{
  final jobId;
  JobDetails({@required this.jobId});

  @override
  State<JobDetails> createState() {
    return JobDetailsState();
  }
}

class JobDetailsState extends State<JobDetails>{
  Future<List<Map<String, dynamic>>> future;

  @override
  void initState() {
    super.initState();

    future = findJobWorkers(widget.jobId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Job details"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: future,
        builder:(context, snapshot) {
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
                  children: [
                    TextSpan(
                      text: "Error: ",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16
                      )
                    ),

                    TextSpan(
                      text: "${snapshot.error}"
                    )
                  ]
                ),
              ),
            );
          }

          else if(snapshot.data.length == 0){
            return Center(
              child: Container(
                child: Text("No details available",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              final Worker worker = snapshot.data[index]["worker"];
              final Job job = snapshot.data[index]["job"];

              return ListRow(job: job, worker: worker,);
            }
        );
        }
      ),
    );
  }
}


//this will be the row for each job in the list
class ListRow extends StatefulWidget{
  final Job job;
  final Worker worker;
  ListRow({@required this.job, @required this.worker});

  @override
  State<ListRow> createState() {

    return  ListRowState(job: job, worker: worker);
  }
}

class ListRowState extends State<ListRow>{
  final Job job;
  final Worker worker;

  ListRowState({@required this.job, @required this.worker});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Material(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          splashColor: Colors.black12,
          onTap: (){
            Navigator.push(context, MaterialPageRoute<JobProgress>(
              builder: (context) => JobProgress(
                job: job,
                worker: worker,
              )
            ));
          },
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      //profile pic
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: AssetImage("assets/images/default_pic.png"),
                            )
                          ),
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
//                          Text(job.description,
//                            maxLines: 1,
//                            style: TextStyle(
//                                fontSize: 15.0,
//
//                            ),
//                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                            child: Text(job.getWorkerId,
                            maxLines: 1,),
                          ),
                          Text(worker.lastName,
                          maxLines: 1,)
                        ],
                      )
                    ],
                  ),

                  FadedLine(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            //check icon
                            Container(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: StatusIcon(job.status),
                            ),

                            Text(job.status == null || job.status == "" ? Status.PENDING : capitaliseFirstLetter(job.status),
                              style: TextStyle(fontSize: 14.0),
                            )
                          ],
                        ),
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Dot(statusIndex: 1,),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                            child: Text(job.getProgress),
                          )
                        ],
                      ),

                    ],

                  ),
                ],
              ),

              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.only(top: 2.0, right: 5.0),
                  child: Text("Just now",
                  style: TextStyle(color: Colors.black45,
                    fontSize: 12.5),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StatusIcon extends StatelessWidget{
  final String status;

  StatusIcon(this.status);

  @override
  Widget build(BuildContext context) {
      if(status.toLowerCase() == Status.ACCEPTED.toLowerCase()){
        return IconTheme(
          data: IconThemeData(
            color: Colors.green,
            size: 15
          ),
          child: Icon(Icons.check_circle),
        );
      }
      else if(status.toLowerCase() == Status.DECLINED.toLowerCase()){
        return IconTheme(
          data: IconThemeData(
              color: Colors.red,
              size: 15
          ),
          child: Icon(Icons.cancel),
        );
      }
      else{
        return IconTheme(
          data: IconThemeData(
              color: Colors.orange,
              size: 15
          ),
          child: Icon(Icons.error),
        );
      }

  }

}