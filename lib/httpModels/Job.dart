import 'package:bakole/constants/Constants.dart';
import 'package:flutter/cupertino.dart';

class Job {
  String id;
  String jobId;
  String workerId;
  final String employerName;
  final String employerEmail;
  final String employerDeviceToken;
  final String description;
  final String category;
  final String fee;
  final String location;
  final String startTime;
  final String startDate;
  String status;
  String progress;

  Job({this.id, @required this.jobId, this.workerId, this.employerName, this.employerEmail, this.employerDeviceToken, this.description, this.category, this.fee, this.location, this.startTime, this.startDate, this.status, this.progress});

  factory Job.fromJson(Map<String, dynamic> map){
  
    return Job(
      id: map['_id'],
      jobId: map['jobId'],
      workerId: map['workerId'],
      employerName: map['employerName'],
      employerEmail: map['employerEmail'],
      employerDeviceToken: map['employerDeviceToken'],
      description: map['description'],
      category: map['category'],
      fee: map['fee'],
      location: map['place'],
      startTime: map['time'],
      startDate: map['date'],
      status: map['status'],
      progress: map['progress']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "jobId" : jobId,
      "workerId" : workerId,
      'employerName' : employerName,
      'employerEmail' : employerEmail,
      'employerDeviceToken' : employerDeviceToken,
      'description' : description,
      'category' : category,
      'fee' : fee,
      'place' : location,
      'time' : startTime,
      'date' : startDate,
      'status' : status,
      'progress' : progress
    };
  }

  @override
  String toString() {
    
    return "\n id: $id\n jobId : $getJobId\n employerName: $employerName\n employerEmail: $employerEmail\n description: $description\n category: $category\n fee: $fee\n place: $location\n startTime: $startTime\n startDate: $startDate\n status: $status\n progress: $progress";
  }

  String get getWorkerId{
    return this.workerId;
  }

  set setWorkerId(String id){
    this.workerId = id;
  }

  String  get getJobId{
    return this.jobId;
  }

  set setJobId(String id){
    this.jobId = id;
  }

  set setStatus(String status){
    this.status = status;
  }

  get getStatus{
    return this.status;
  }

  set setProgress(String progress){
    this.progress = progress;
  }

  String get getProgress{
    if(progress == null){
      return Progress.NOT_STARTED;
    }
    return progress;
  }
}