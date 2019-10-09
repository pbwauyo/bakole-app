import 'dart:convert';
import 'package:bakole/clippers/rectClipper.dart';
import 'package:bakole/constants/constants.dart';
import 'package:bakole/httpModels/job.dart';
import 'package:bakole/widgets/viewJob.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Job>> getJobs(String workerId) async {
  final String url = "$LOCAL_HOST/jobs/$workerId";
  final response = await http.get(url);

  try{
    if(response.statusCode == 200){
      final List<Map<String, dynamic>>responseBody = json.decode(response.body).cast<Map<String, dynamic>>();

      return responseBody.map<Job>((json)=>Job.fromJson(json)).toList();
    }
    else return [];
  }catch(e){
    print(e);
    return [];
  }
}

class Jobs extends StatelessWidget{
  final String workerId;
  final Future<List<Job>> future;
  
  Jobs({@required this.workerId}) : future = getJobs(workerId);

  @override
  build(context) => FutureBuilder<List<Job>>(
    future: future,
    builder: (context, snapshot){
      if(snapshot.data == null){
        return Center(
          child: CircularProgressIndicator()
          );
      }
      else {
        if(snapshot.hasError){
          return Center(
            child: Text("${snapshot.error}"),
          );
        }
        else{
          return JobList(
            jobs: snapshot.data,
        );
        }
        
      }
     
    },
  );
}


class JobList extends StatelessWidget{
  
  final List<Job> jobs;
  JobList({this.jobs});

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index){
        return JobRow(jobs[index]);
      },
      
    );
  }
}

class JobRow extends StatelessWidget{
  final Job job;
  JobRow(this.job);

  @override
  Widget build(BuildContext context) {
    print("Job");
    print(job);
   
    return Card(
      elevation: 8.0, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Container(
        height: 100.0,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            splashColor: Colors.black38,
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context){
                    return JobPreview(job: job,);
                  },
                )
              );
            },
            child: Stack(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: "avatar",
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/default_pic.png"),
                          radius: 30.0,
                        ),
                      ),
                    ),

                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(job.employerName),
                          ),
                          
                        ],
                      ),
                    )
                  ],
                ),

                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipPath(
                      clipper: RectClipper(),
                      child: Container(
                        alignment: Alignment.center,
                        width: 50.0,
                        height: 60.0,
                        color: Colors.amber,
                        child: Column(
                          children: <Widget>[
                            Text("UGX"),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(job.fee),
                            ),
                          ],
                        ),
                      ), 
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}