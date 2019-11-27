import 'package:bakole/employer/JobProgress.dart';
import 'package:bakole/httpModels/Worker.dart';
import 'package:flutter/material.dart';
import 'package:bakole/httpModels/Job.dart'as _Job;

class JobTab extends StatelessWidget{
  final _Job.Job job;
  final Worker worker;

  JobTab({@required this.job, @required this.worker});
  @override
  Widget build(BuildContext context) {

    return JobProgress(job: job, worker: worker);
  }
}