import 'dart:convert';
import 'package:bakole/httpModels/job.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Job>> getJobs(String workerId) async {
  final String url = "http://localhost:3000/jobs/$workerId";
  final response = await http.get(url);

  try{
    if(response.statusCode == 200){
      List<Map<String, dynamic>> responseBody = json.decode(response.body).cast<Map<String, dynamic>>();
      final jobList = responseBody.map((json)=>Job.fromJson(json)).toList();
      return jobList;
    }
    else return [];
  }catch(e){
    throw(e); 
  }
}

class WorkerHomePage extends StatelessWidget{
  final String workerId;
  final Future<List<Job>> future;
  WorkerHomePage({@required this.workerId}) : future = getJobs(workerId);

  @override
  build(context) => FutureBuilder<List<Job>>(
    builder: (context, snapshot){
      if(snapshot.data == null){
        return Center(
          child: CircularProgressIndicator()
          );
      }
      else if(snapshot.connectionState == ConnectionState.done && !snapshot.hasError && snapshot.data != []){
         
        return JobList(
            jobs: snapshot.data,
        );
      }
      else{
        return Center(
          child: Text("No jobs currently available",
            style: TextStyle(fontSize: 20.0),
          ),
        ); 
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
   
    return Card(
      child: Row(
        children: <Widget>[
          Hero(
            tag: "avatar",
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/default_pic.png"),
              radius: 20.0,
            ),
          ),

          Flexible(
            fit: FlexFit.loose,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(job.employerEmail),
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}