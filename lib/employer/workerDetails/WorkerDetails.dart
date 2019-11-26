import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WorkerDetails extends StatefulWidget{

  @override
  State<WorkerDetails> createState() {

    return WorkerDetailsState();
  }
}

class WorkerDetailsState extends State<WorkerDetails>{
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 3,
        child:Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 160,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/cleaning.jpg"),
                                fit: BoxFit.cover
                              )
                            ),
                          ),

                          Positioned(
                            top: 150,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: Container(
                                height: 100,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        //crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Text("Peter Wauyo"
                                            ),
                                          ),

                                          RatingBar(
                                            onRatingUpdate: (value){
                                            },
                                            itemSize: 25.0,
                                            initialRating: 4.5,
                                            itemBuilder: (context, index){
                                              return IconTheme(
                                                data: IconThemeData(),
                                                child: Icon(Icons.star),
                                              );
                                            },
                                            itemCount: 5,
                                            ignoreGestures: true,
                                          ),

                                          TabBar(
                                            tabs: <Widget>[
                                              Tab(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    IconTheme(
                                                      data: IconThemeData(),
                                                      child: Icon(Icons.person),
                                                    ),
                                                    Container(
                                                      child: Text("Profile"),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              Flexible(
                                                fit: FlexFit.loose,
                                                child: Tab(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      IconTheme(
                                                        data: IconThemeData(),
                                                        child: Icon(Icons.star),
                                                      ),
                                                      Container(
                                                        child: Text("Reviews"),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              Tab(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    IconTheme(
                                                      data: IconThemeData(),
                                                      child: Icon(Icons.business_center),
                                                    ),
                                                    Container(
                                                      child: Text("Job"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),

                                          image: DecorationImage(
                                            image: AssetImage("assets/images/default_pic.png"),
                                            fit: BoxFit.cover,
                                          )
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]
                )
              )
            ],
          ),

        )
    );
  }
}