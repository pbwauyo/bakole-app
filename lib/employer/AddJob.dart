import 'dart:convert';

import 'package:bakole/constants/Constants.dart';
import 'package:bakole/employer/EmployerActivity.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/httpModels/EmployerJob.dart';
import 'package:bakole/httpModels/Worker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../httpModels/Job.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:uuid/uuid.dart';

Future<bool> postJob(Job job, EmployerJob employerJob, List<Worker> workersList) async {
  final String employerUrl = "$AWS_SERVER_URL/employers/jobs";
  final String url = "$AWS_SERVER_URL/jobs/";
  final Map<String, String> headers = {
    "Content-Type": "application/json"
  };

  var task;
  var task2;
  try{

    print(json.encode(employerJob.toJson()));

    task2 = await httpClient.post(employerUrl, headers: headers, body: json.encode(employerJob.toJson()));

    print(task2.statusCode);
    if(task2.statusCode == 200){
      for (Worker worker in workersList) {
        job.setWorkerId = worker.id;
        task = await httpClient.post(url, body: job.toJson());

        print(task.statusCode);
        if(!(task.statusCode == 200)){
          return false;
        }
      }
      return true;
    }
    else{
      return false;
    }

  }catch(e){
    print(e);
    return false;
  }
  
}

class AddJob extends StatefulWidget{
  final String category;
  final List<Worker> workersList;
  final Employer employer;

  AddJob({this.category, this.workersList, @required this.employer});

  @override
  AddJobState createState() => AddJobState();
}

class AddJobState extends State<AddJob>{
  final _formKey = GlobalKey<FormState>();
  final _titleRadius = 30.0;
  final _emptyFieldError = "field cannot be empty";
  final feeTxt = TextEditingController(); 
  final locationTxt = TextEditingController();
  final descriptionTxt = TextEditingController();
  
  @override 
  Widget build(BuildContext context){


    return Scaffold(
              appBar: AppBar(
                title: Text(widget.category),
              ),
              body: MultiProvider(
                providers: [
                  ChangeNotifierProvider(builder: (context) => Date(),),
                  ChangeNotifierProvider(builder: (context) => Time(),),
                ],
                child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(_titleRadius))
                                      ),
                                      child: Container(
                                        width: 120,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                                        child: Text(
                                          "Description",
                                          style: TextStyle(color: Colors.cyan),
                                          )
                                        ),
                                    ),
                                    
                                    Card(
                                      elevation: 2,
                                      child: Container(
                                        height: 150,
                                        child: TextFormField(
                                          controller: descriptionTxt,
                                          validator: (string){
                                            if(string.trim()!=""){
                                              return null;
                                            }
                                            else{
                                              return _emptyFieldError;
                                            }
                                          }, 
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,     
                                          ),
                                        ),
                                      ),
                                  ),
                                
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(_titleRadius))
                                      ),
                                      child: Container(
                                        width: 120,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Fee",
                                          style: TextStyle(color: Colors.cyan),
                                          ),
                                        padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                                        ),
                                    ),

                                    Card(
                                      elevation: 2,
                                      child: Container(
                                        child: TextFormField(
                                          validator: (string){
                                            if(string.trim()!=""){
                                              return null;
                                            }
                                            else{
                                              return _emptyFieldError;
                                            }
                                          }, 
                                          controller: feeTxt,
                                          decoration: InputDecoration(border: InputBorder.none),
                                        ),
                                      ),
                                    ),  
                                    
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(_titleRadius))
                                      ),
                                      child: Container(
                                        width: 120,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Location",
                                          style: TextStyle(color: Colors.cyan),
                                          ),
                                        padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                                      ),
                                    ),

                                    Card(
                                      elevation: 2,
                                      child: Container(
                                        child: TextFormField(
                                          controller: locationTxt,
                                          validator: (string){
                                            if(string.trim()!=""){
                                              return null;
                                            }
                                            else{
                                              return _emptyFieldError;
                                            }
                                          }, 
                                          decoration: InputDecoration(border: InputBorder.none),
                                        ),
                                      ),
                                    ),  
                                    
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(_titleRadius))
                                      ),
                                      child: Container(
                                        width: 120,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Start time",
                                          style: TextStyle(color: Colors.cyan),
                                          ),
                                        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                                      ),
                                    ), 

                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 8.0),
                                      child: DateTimeWidget()
                                      ),
                                    
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: PostButton(
                                  formKey: _formKey,
                                  descriptionTxt: descriptionTxt,
                                  locationTxt: locationTxt,
                                  feeTxt: feeTxt,
                                  category: widget.category,
                                  workersList: widget.workersList,
                                  employer: widget.employer,
                                ),
                              ),
                            ],
                      ),
            ),
        ),
                    ),
                ),
      ),
    );
  }

   @override
  dispose(){
   descriptionTxt.dispose();
   feeTxt.dispose();
   locationTxt.dispose();
   super.dispose();
  }
}

//class Tasks extends StatefulWidget{
//
//  @override
//  TasksState createState() {
//    return TasksState();
//  }
//}
//
//class TasksState extends State<Tasks>{
//  int taskCount = 0;
//  final List<String> tasksList = [];
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Container(
//
//      width: double.infinity,
//      child: Column(
//
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              Flexible(
//                fit: FlexFit.loose,
//                child: Container(
//                  color: Colors.blue[300],
//                  child: Center(
//                    child: Icon(Icons.add),
//                  )
//                ),
//              )
//            ],
//          ),
//
//          taskCount==0 ?
//          Container():
//          Container(
//            child: Card(
//
//            ),
//          ),
//        ],
//      ),
//
//    );
//  }
//}
//
//class TaskBody extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//
//    return Container(
//      child: Row(
//        children: <Widget>[
//          Icon(Icons.done_outline),
//          TextFormField(
//
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//
////not used yet
//class CategoriesMenu extends StatefulWidget{
//  @override
//  createState()=>CategoriesMenuState();
//}
//
//class CategoriesMenuState extends State<CategoriesMenu>{
//  var _dropDownValue = 1;
//
//  @override
//  Widget build(BuildContext context){
//
//    return Container(
//            height: 80,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.all(Radius.circular(8.0)),
//            ),
//
//            child: Align(
//              alignment: Alignment.center,
//              child: Material(
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                      ),
//                      elevation: 3,
//                      child: Padding(
//                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                        child: DropdownButtonHideUnderline(
//                          child: DropdownButton<int>(
//                            value: _dropDownValue,
//                            isExpanded: true,
//                            onChanged: (int value){
//                              setState(
//                                (){
//                                  _dropDownValue = value;
//                                }
//                              );
//                            },
//
//                            hint: Text("Please select an option"),
//                            items: [
//                              DropdownMenuItem(
//                                value: 1,
//                                child: Text("Warehousing"),
//                              ),
//
//                              DropdownMenuItem(
//                                value: 2,
//                                child: Text("Driving & Delivery"),
//                              ),
//
//                              DropdownMenuItem<int>(
//                                value: 3,
//                                child: Text("Washing & Cleaning"),
//                              ),
//
//                              DropdownMenuItem<int>(
//                                value: 4,
//                                child: Text("Stocking"),
//                              ),
//
//                              DropdownMenuItem<int>(
//                                value: 5,
//                                child: Text("Painting"),
//                              ),
//
//                              DropdownMenuItem<int>(
//                                value: 6,
//                                child: Text("Other"),
//                              ),
//                            ]
//                    ),
//                        ),
//                      ),
//              ),
//            ),
//        );
//  }
//
//}

class DateTimeWidget extends StatelessWidget{
  final DateFormat dateFormat = DateFormat("dd - MM - yyyy");
  final DateFormat timeFormat = DateFormat("hh : mm a");

  @override
  build(context){

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Consumer<Date>(
          builder: (context, _date, _) => Card(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: IconTheme(
                            child: Icon(Icons.calendar_today),
                            data: IconThemeData(
                              color: Colors.lightGreen,
                            ),
                          ),
                        ),

                        Text(_date.getDate == "" ? "Not Set" : _date.getDate,
                          style: TextStyle(
                            color: Colors.lightGreen
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Material(
                      color: Colors.lightGreen,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        splashColor: Colors.black12,
                        onTap: (){
                          DatePicker.showDatePicker(context,
                            minTime: DateTime.now(),
                            maxTime: DateTime(DateTime.now().year+2),
                            currentTime: DateTime.now(),
                            showTitleActions: true,
                            onConfirm: (date){
                              _date.date = dateFormat.format(date);
                            }
                          );
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                            child: Text("Change",
                            style: TextStyle(
                              color: Colors.white,
                            ),),
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),

        ),

        Consumer<Time>(
          builder: (context, _time, _) => Card(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: IconTheme(
                            data: IconThemeData(
                              color: Colors.lightGreen,
                            ),
                            child: Icon(Icons.access_time),
                          ),
                        ),

                        Text(_time.getTime == "" ? "Not Set" : _time.getTime,
                          style: TextStyle(
                              color: Colors.lightGreen
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Material(
                      color: Colors.lightGreen,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      child: InkWell(
                        onTap: (){
                          DatePicker.showTimePicker(context,
                            showTitleActions: true,
                            currentTime: DateTime.now(),
                            onConfirm: (time){
                              _time.time = timeFormat.format(time);
                              
                            }
                          );

                        },
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        splashColor: Colors.black12,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                            child: Text("Change",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),

        ),

      ],
    );
  }
}

class Date with ChangeNotifier{
  String _date = "";

  //getter
  String get getDate{
    return this._date;
  }

  //setter
  set date(String d){
    this._date = d;
    notifyListeners();
  }

}

class Time with ChangeNotifier{
  String _time = "";

  //getter
  String get getTime{
    return this._time;
  }

  //setter
  set time(String time){
    this._time = time;
    notifyListeners();
  }

}

class PostButton extends StatefulWidget{
  
  final GlobalKey<FormState> formKey;
  final TextEditingController descriptionTxt, locationTxt, feeTxt;
  final String category;
  final List<Worker> workersList;
  final Employer employer;

  PostButton({@required this.formKey, @required this.descriptionTxt, @required this.locationTxt, @required this.feeTxt, @required this.category, @required this.workersList, @required this.employer});

  @override
  _PostButtonState createState() => _PostButtonState();
}

class _PostButtonState extends State<PostButton> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context){

    return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  elevation: 2,
                  color: Colors.cyan,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    splashColor: Colors.black45,
                    onTap: () async{
                      final time = Provider.of<Time>(context);
                      final date = Provider.of<Date>(context);
                      final Employer employer = widget.employer;
                      final String jobId = Uuid().v1().toString();

                      if (time.getTime != "" || date.getDate != ""){
                        print("time and date");
                        if(widget.formKey.currentState.validate()){

                          Job job = Job(
                            jobId: jobId,
                            employerName: employer.lastName,
                            employerEmail: employer.email,
                            employerDeviceToken: employer.deviceToken,
                            description: widget.descriptionTxt.text,
                            category: widget.category,
                            fee: widget.feeTxt.text,
                            location: widget.locationTxt.text,
                            startTime: time.getTime,
                            startDate: date.getDate
                          );

                          EmployerJob employerJob = EmployerJob(
                            status: Status.PENDING,
                            job: job
                          );

                          print(job.toString());

                          setState(() {
                            _isLoading = true;
                          });
                          
                          final bool isSuccess = await postJob(job, employerJob, widget.workersList);

                          if(isSuccess){
                            setState(() {
                              _isLoading = false;
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Success!"),
                                duration: Duration(seconds: 4),
                                backgroundColor: Colors.amber,
                              ));

                              widget.descriptionTxt.text = "" ;
                              widget.locationTxt.text = "";
                              widget.feeTxt.text = "";
                            });
                          }
                          else{
                            setState(() {
                              _isLoading = false; 
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Failure!"),
                                duration: Duration(seconds: 4),
                              )); 
                            });
                          }
                        }
                    }
                    else{
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill the date correctly"),
                          duration: Duration(seconds: 2),
                        )
                      );
                    }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                      child: _isLoading? CircularProgressIndicator() : Text(
                        "POST",
                        style: TextStyle(fontSize: 14, color: Colors.white),

                      ),
                    ),
                  ),
                )
              ],
            );
  }
}