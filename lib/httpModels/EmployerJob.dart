import 'package:bakole/httpModels/Job.dart';
import 'package:flutter/material.dart';

class EmployerJob{
  String id;
  final String status;
  String numOfWorkers;
  final Job job;

  EmployerJob({this.id, @required this.status, this.numOfWorkers, @required this.job, });

  factory EmployerJob.fromJson(Map<String, dynamic> map){
    return EmployerJob(
      id: map["_id"],
      status: map["status"],
      numOfWorkers: map["numOfWorkers"],
      job: Job.fromJson(map["job"])
    );

  }

  Map<String , dynamic> toJson(){

    Map<String, dynamic> json = {
      "id" : id,
      "status" : status,
      "numOfWorkers" : numOfWorkers,
      "job" : job.toJson()
    };

    return json;
  }

  static String filterNumOfWorkers(String num){
    print("num is: ");
    print(num);
    if(num == null || num.trim() == ""){
      return "0";
    }else{
      return num;
    }
  }

  static int convertStringToInt(String n){
    final int num = int.parse(filterNumOfWorkers(n));
    return num;
  }

}