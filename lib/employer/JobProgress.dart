import 'dart:convert';
import 'package:bakole/constants/Constants.dart';
import 'package:bakole/constants/Constants.dart' as prefix0;
import 'package:bakole/employer/EmployerActivity.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/httpModels/Job.dart';
import 'package:bakole/httpModels/Review.dart';
import 'package:bakole/httpModels/Worker.dart';
import 'package:bakole/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

Future<bool> setProgressChange(String id, String progress) async {
  final String url = "$AWS_SERVER_URL/jobs/progress/$id/$progress";

  try{
    final response = await httpClient.patch(url);

    if(response.statusCode == 200){
      print('success!');
      return true;
    }
    print('failure!');
    return false;

  }catch(error){
    print(error);
    return false;
  }
}

Future<bool> postReview(Review review)async {
  final url = "$AWS_SERVER_URL/reviews";

  try{
    final response = await httpClient.post(url, body: json.encode(review.toJson()), headers: headers);
    if(response.statusCode == 200){
      print("Status code: ${response.statusCode}");
      return true;
    }
    else{
      print("Status code: ${response.statusCode}");
      return false;
    }

  }catch(err){
    print("ERROR HAS OCCURED: $err");
    return false;
  }
}


Future<Job> getUpdatedJob(key, String id)async{
  final url = "$AWS_SERVER_URL/jobs/retrieve/$id";

  try{
    final response = await httpClient.get(url);

    if(response.statusCode == 200){
      final List<Map<String, dynamic>> results = json.decode(response.body).cast<Map<String, dynamic>>();
      return Job.fromJson(results[0]);
    }
    else{
      return null;
  }

  }catch(err){
    print("ERROR: $err");
    showErrorSnackBar(key, error: err);
    return null;
  }
}

bool getProgressInBool(String progress){
  if(progress == Progress.IN_PROGRESS){
    return true;
  }
  return false;
}

class JobProgress extends StatefulWidget{
  final Job job;
  final Worker worker;
  final bool inProgress;

  JobProgress({@required this.job, @required this.worker}) : inProgress = getProgressInBool(job.getProgress);

  @override
  State<JobProgress> createState() {

    return JobProgressState(job: job, inProgress: inProgress);
  }
}

class JobProgressState extends State<JobProgress>{
  Job job;
  bool inProgress;
  final TextEditingController _reviewTextController = TextEditingController();
  final Map<bool, double> opacityMap = {
    true : 1.0,
    false : 0.0
  };

  JobProgressState({@required this.job, @required this.inProgress});

  @override
  Widget build(BuildContext context) {

    final Worker worker = widget.worker;
    final _key = GlobalKey<ScaffoldState>();
    double rating = 0.0;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Job Progress"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image(
              image: AssetImage("assets/images/default_pic.png"),
              fit: BoxFit.cover,
              color: Color(0XB3000000),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 50.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        image: DecorationImage(
                          image: AssetImage("assets/images/default_pic.png"),
                          fit: BoxFit.cover
                        )
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Text(worker.firstName ?? "" + worker.lastName ?? "",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(job.description,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white
                        ),
                      ),
                    ),

                    Visibility(
                      maintainState: true,
                      maintainSize: true,
                      maintainAnimation: true,
                      visible: job.getProgress == Progress.IN_PROGRESS,
                      child: ContinuousTextAnim(job.getProgress)
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: job.getProgress == Progress.FINISHED ?
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.green
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                            child: Text("DONE",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ) :
                        CupertinoSwitch(
                          value: inProgress,
                          onChanged: (value) async{

                            if(value){
                              await setProgressChange(job.id, Progress.IN_PROGRESS);
                              final Job updatedJob = await getUpdatedJob(_key, job.id,);

                              setState(() {
                                job = updatedJob;
                                inProgress = getProgressInBool(updatedJob?.progress);
                              });

                              if(job != null){

                                _key.currentState.showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 4),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          IconTheme(
                                            data: IconThemeData(
                                                color: Colors.green
                                            ),
                                            child: Icon(Icons.done_all),
                                          ),

                                          Text("Progress changed successfully")
                                        ],

                                      ),
                                    )
                                );
                              }else{
                                showErrorSnackBar(_key);
                              }

                            }
                            else{
                              await setProgressChange(job.id, Progress.FINISHED);
                              final Job updatedJob = await getUpdatedJob(_key, job.id);

                              setState(() {
                                inProgress = getProgressInBool(updatedJob.progress);
                                job = updatedJob;
                              });

                              if(job != null){

                                _key.currentState.showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 4),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          IconTheme(
                                            data: IconThemeData(
                                                color: Colors.red
                                            ),
                                            child: Icon(Icons.error),
                                          ),

                                          Text("Progress change failure")
                                        ],
                                      ),
                                    )
                                );

                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context){
                                    return CupertinoAlertDialog(
                                      title: Text("Rate"),
                                      content: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              RatingBar(
                                                itemCount: 5,
                                                itemSize: 25.0,
                                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                onRatingUpdate: (value){
                                                  rating = value;
                                                },
                                                itemBuilder: (context, item){
                                                  return IconTheme(
                                                    data: IconThemeData(
                                                      color: Colors.orange
                                                    ),
                                                    child: Icon(Icons.star),
                                                  );
                                                },
                                                unratedColor: Colors.black45,
                                              ),

                                              Container(
                                                margin: EdgeInsets.only(top: 5.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0)
                                                ),
                                                child: Material(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                    child: TextField(
                                                      showCursor: true,
                                                      autofocus: true,
                                                      controller: _reviewTextController,
                                                      decoration: InputDecoration(
                                                        hintText: "Describe your experience",
                                                        border: InputBorder.none
                                                      ),
                                                      textCapitalization: TextCapitalization.sentences,

                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ]
                                        ),
                                      ),
                                      actions: <CupertinoDialogAction>[
                                        CupertinoDialogAction(
                                            child: Material(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(10.0),
                                                splashColor: Colors.black26,
                                                onTap: () async{


                                                  Review review = Review(
                                                    reviewerEmail: job.employerEmail,
                                                    revieweeEmail: worker.email,
                                                    message: _reviewTextController.text,
                                                    rating: rating.toString()
                                                  );
                                                  print(review.toString());

                                                  final res = await postReview(review);

                                                  if(res){
                                                    print("Success: $res");
                                                    print("Success: $res");
                                                  }
                                                  else{
                                                    print("Success: $res");
                                                  }

                                                  Navigator.pop(context);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                                  child: Text("SUBMIT",
                                                    style: TextStyle(
                                                      color: Colors.white
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                        )
                                      ],
                                    );
                                  },

                                );

                              }
                              else{
                                showErrorSnackBar(_key);
                              }

                            }

                          },
                        ),
                    ),

                    AnimatedOpacity(
                      opacity: opacityMap[inProgress],
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        child: WaveWidget(
                            config: CustomConfig(
                              gradients: [
                                [Colors.red, Color(0xEEF44336)],
                                [Colors.red[800], Color(0x77E57373)],
                                [Colors.orange, Color(0x66FF9800)],
                                [Colors.yellow, Color(0x55FFEB3B)]
                              ],
                              durations: [35000, 19440, 10800, 6000],
                              heightPercentages: [0.20, 0.23, 0.25, 0.30],
                              blur: MaskFilter.blur(BlurStyle.solid, 10),
                              gradientBegin: Alignment.bottomLeft,
                              gradientEnd: Alignment.topRight,
  //                      colors: [
  //                        Colors.white70,
  //                        Colors.white54,
  //                        Colors.white30,
  //                        Colors.white24,
  //                      ],
                            ),
                            waveAmplitude: 0,
                            backgroundColor: Colors.blue,
                            size: Size(
                              double.infinity,
                              20.0,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}