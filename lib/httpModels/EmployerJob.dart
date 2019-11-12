import 'package:bakole/httpModels/Job.dart';
import 'package:flutter/material.dart';

class EmployerJob{
  String id;
  final String status;
  final Job job;

  EmployerJob({this.id, @required this.status, @required this.job, });

  factory EmployerJob.fromJson(Map<String, dynamic> map){
    return EmployerJob(
      id: map["_id"],
      status: map["status"],
      job: Job.fromJson(map["job"])
    );

  }

  Map<String , dynamic> toJson(){

    Map<String, dynamic> json = {
      "id" : id,
      "status" : status,
      "job" : job.toJson()
    };

    return json;
  }

}