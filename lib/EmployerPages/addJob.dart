import 'package:bakole/httpModels/employer.dart';
import 'package:flutter/material.dart';
import '../httpModels/job.dart';
import 'package:http/http.dart' as http;

Future<bool> postJob(Job job, String id) async {
  final url = "http://localhost:3000/jobs/$id";

  try{
    var task = await http.post(url, body: job.toJson());
    print(task.statusCode);
    if(task.statusCode == 200){
      
      return true;
    }
    else return false;

  }catch(e){
    print(e);
    return false;
  }
  
  
  
}

class AddJob extends StatefulWidget{
  final String category;
  final String workerId;
  final Employer employer;

  AddJob({this.category, this.workerId, @required this.employer});

  @override
  AddJobState createState() => AddJobState();
}

class AddJobState extends State<AddJob>{
  final _formKey = GlobalKey<FormState>();
  final _titleRadius = 30.0;
  final _emptyFieldError = "field cannot be empty";
  var _isLoading = false;
  final feeTxt = TextEditingController(); 
  final locationTxt = TextEditingController();
  final startTimeTxt = TextEditingController();
  final descriptionTxt = TextEditingController();
  
  @override 
  Widget build(BuildContext context){

    return Scaffold(
            appBar: AppBar(
              title: Text(widget.category),
            ),
            body: SafeArea(
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
                                      "Start time",
                                      style: TextStyle(color: Colors.cyan),
                                      ),
                                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                                  ),
                                ),

                                Card(
                                  elevation: 2,
                                  child: Container(
                                    child: TextFormField(
                                      controller: startTimeTxt,
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

                          Row(
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
                                    
                                    if(_formKey.currentState.validate()){
                                      Job job = Job(
                                        employerEmail: widget.employer.email,
                                        description: descriptionTxt.text,
                                        category: widget.category,
                                        fee: feeTxt.text,
                                        location: locationTxt.text,
                                        startTime: startTimeTxt.text
                                      );

                                      setState(() {
                                        _isLoading = true;
                                      });
                                      
                                      bool isSuccess = await postJob(job, widget.workerId);

                                      if(isSuccess){
                                        setState(() {
                                          _isLoading = false;
                                          Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text("Success!"),
                                            duration: Duration(seconds: 2),
                                            backgroundColor: Colors.amber,
                                          )); 
                                        });
                                      }
                                      else{
                                        setState(() {
                                          _isLoading = false; 
                                          Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text("Failure!"),
                                            duration: Duration(seconds: 2),
                                          )); 
                                        });
                                      }
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
                          )
                        ],
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
   startTimeTxt.dispose(); 
   super.dispose();
  }
}

class Tasks extends StatefulWidget{

  @override
  TasksState createState() {
    return TasksState();
  }
}

class TasksState extends State<Tasks>{
  int taskCount = 0;
  final List<String> tasksList = [];

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Row( 
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  color: Colors.blue[300],
                  child: Center(
                    child: Icon(Icons.add),
                  )
                ),
              )
            ],
          ),

          taskCount==0 ? 
          Container():
          Container(
            child: Card(

            ),
          ),
        ],
      ),

    );
  }
}


//not used yet
class CategoriesMenu extends StatefulWidget{
  @override
  createState()=>CategoriesMenuState();
}

class CategoriesMenuState extends State<CategoriesMenu>{
  var _dropDownValue = 1;

  @override
  Widget build(BuildContext context){

    return Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),

            child: Align(
              alignment: Alignment.center,
              child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(  
                            value: _dropDownValue,
                            isExpanded: true,
                            onChanged: (int value){
                              setState(
                                (){
                                  _dropDownValue = value;
                                }
                              );
                            },
                            
                            hint: Text("Please select an option"),
                            items: [
                              DropdownMenuItem(
                                value: 1,
                                child: Text("Warehousing"),
                              ),

                              DropdownMenuItem(
                                value: 2,
                                child: Text("Driving & Delivery"),
                              ),

                              DropdownMenuItem<int>(
                                value: 3,
                                child: Text("Washing & Cleaning"),
                              ),

                              DropdownMenuItem<int>(
                                value: 4,
                                child: Text("Stocking"),
                              ),

                              DropdownMenuItem<int>(
                                value: 5,
                                child: Text("Painting"),
                              ),

                              DropdownMenuItem<int>(
                                value: 6,
                                child: Text("Other"),
                              ),
                            ]
                    ),
                        ),
                      ),
              ),
            ),
        );
  }

  
}