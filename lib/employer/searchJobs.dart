import 'package:flutter/material.dart';

class SearchJobs extends StatefulWidget{
  @override
  createState() => SearchJobsState();
}

class SearchJobsState extends State<SearchJobs>{
  @override
  build(context) => Container(
    child: Text("Search jobs"),
  );
}