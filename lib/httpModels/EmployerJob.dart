
import 'package:bakole/httpModels/Job.dart';
import 'package:flutter/material.dart';

class EmployerJob{

  final String status;
  final Job job;

  EmployerJob({@required this.status, @required this.job});

  factory EmployerJob.fromJson(Map<String, dynamic> map){
    return EmployerJob(
      status: map["status"],
      job: Job.fromJson(map["job"])
    );

  }

  Map<String , dynamic> toJson(){

    Map<String, dynamic> json = {
      "status" : status,
      "job" : job.toJson()
    };

    return json;
  }

}