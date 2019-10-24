import 'dart:convert';
import 'package:bakole/constants/Constants.dart';
import 'package:bakole/employer/AddJob.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/employer/WorkerInfo.dart';
import 'package:flutter/material.dart';
import '../httpModels/Worker.dart';
import 'package:http/http.dart' as http;

Future<List<Worker>> getWorkers(String query) async{

  Map<String, String> requestHeaders = {
       'Content-type': 'application/json',
       'Accept': 'application/json',
  };

  print("Future start");
  
  final url = "$AWS_SERVER_URL/workers/";

  try{
    print("before await");

    final response = await http.get(url+query, headers: requestHeaders);
    print("response status code");
    print(response.statusCode);
    
    if(response.statusCode == 200){
      final responseBody = json.decode(response.body);

      final parsed = responseBody.cast<Map<String, dynamic>>();
      
      return parsed.map<Worker>((json) =>Worker.fromJson(json)).toList();
    }
    return [];
    
  }catch(e){
    print("Exception occurred");
    print(e);
    return [];
    
  }
}

class SearchWorkers extends StatefulWidget{
  final String category;
  final Employer employer;

  SearchWorkers({this.category, @required this.employer});
  

  @override
  createState() => SearchWorkersState();
}

class SearchWorkersState extends State<SearchWorkers>{
  bool _showSearchBar = false;
  final _queryTxt = TextEditingController();
  final FocusNode _queryNode = FocusNode();
  int _count = 0;
  bool _beginSearch = false;
  Future<List<Worker>> workers;

  @override
  build(context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: _showSearchBar ?
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only( right: 4.0),
                        child: TextField(
                          focusNode: _queryNode,
                          textInputAction: TextInputAction.search,
                          controller: _queryTxt,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none),
                          showCursor: true,  
                          maxLines: 1,
                          autofocus: true,
                          onSubmitted: (value){
                            setState(() {
                              _beginSearch = true;
                              workers = getWorkers(value.trim());
                            });
                          },    
                        ),
                      ),
                    ) :

                    Container(
                      child: Text(
                      "Search by location",
                      style: TextStyle(fontSize: 16),),
                    )
                 
        ),
      
      actions: <Widget>[
        Material(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.blue,   
              child: Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: AnimatedSwitcher(
                   transitionBuilder: (Widget child, Animation<double> animation){
                      return ScaleTransition(child: child, scale: animation,);
                   },
                   duration: Duration(seconds: 1),
                   child: _showSearchBar ? 
                        InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          key: ValueKey<int>(_count),
                          splashColor: Colors.black38,
                          onTap: (){
                            setState(() {
                              _showSearchBar = false;
                              _count+=1; 
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.clear,),
                          ),
                        ) :

                        InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          key: ValueKey<int>(_count),
                          splashColor: Colors.black38,
                          onTap: (){
                            setState(() {
                              _showSearchBar = true; 
                              _count+=1; 
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.search,),
                          ),
                        )
                          ) 
                        ) 
          ),
        
      ],
    ),
    body: SafeArea(
        child: _beginSearch ? 
              WorkersList(workers: workers, category: widget.category, employer: widget.employer,) :
              Container(),
      ),
    
  );

  @override
  void dispose() {
    _queryNode.dispose();
    _queryTxt.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

}

class WorkersList extends StatelessWidget{
  final Future<List<Worker>> workers;
  final String category;
  final Employer employer;

  final Map<String, Color> skillColors = {
    "Elite Worker": Colors.green[700],
    "Pro Worker": Colors.amber,
    "Basic Worker": Colors.cyan
  };

  WorkersList({Key key, @required this.workers, @required this.category, @required this.employer}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return FutureBuilder<List<Worker>>(
      future: workers,
      builder: (context, snapshot){
        
        if(snapshot.data == null){
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                semanticsLabel: "Loading...",
              ),
            ),
          );
        }
        else 
          return Stack(
            children: <Widget>[

              Positioned.fill(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index){
                      
                      if(snapshot.hasError){
                        return Center(child: Text("${snapshot.error}"));
                      }

                      else if(snapshot.data != []){
                        return Material(
                          child: InkWell(
                            splashColor: Colors.black45,
                            onTap: (){
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, amimation, secondAnimation)=>WorkerInfo(
                                    workerId: snapshot.data[index].id, category: category, 
                                    employer: employer,
                                  ),
                                  transitionsBuilder: (context, animation, secondAnim, child){
                                    var begin = Offset(1, 1);
                                    var end = Offset(0, 0);
                                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeIn));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  }
                                )
                                );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: skillColors[snapshot.data[index].skillStatus],
                                            width: 2.0        
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                          image: DecorationImage(
                                            image: AssetImage("assets/images/default_pic.png"), 
                                            fit: BoxFit.cover,
                                          )
                                        ), 
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(snapshot.data.elementAt(index).firstName),
                                          ),

                                          Container(
                                            child: Text(snapshot.data.elementAt(index).phoneNumber),
                                          ),

                                          Container(
                                            child: Text("starting from UGX ${snapshot.data.elementAt(index).averagePay}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                        }
                        else {
                          return Center(
                            child: Text("Data is empty"),
                          );
                        }
                      },
                    ),
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    elevation: 4.0,                    
                      child: IconTheme(
                        data: IconThemeData(
                          color: Colors.white
                        ),
                        child: Icon(Icons.send),
                      ),
                    
                    onPressed: (){
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, anim, secondAnim){
                            return AddJob(
                              category: category,
                              employer: employer,
                              workersList: snapshot.data,
                            );
                          },
                          transitionsBuilder: (context, anim, secondAnim, child){
                            final begin = Offset(1, 0);
                            final end = Offset(0, 0);
                            final tween = Tween(begin: begin, end: end);

                            return SlideTransition(
                              position: anim.drive(tween.chain(CurveTween(curve: Curves.decelerate))),
                              child: child,
                            );
                          }
                        )
                      );
                    },
                  ),
                ),
              )
            ],
          );
      },
    );
  }

  int getWorkersCount(){
    int count;
    workers.then((value){
      count = value.length;
    }).catchError((error){
      print(error);
    });
    return count;
  }

  
}


