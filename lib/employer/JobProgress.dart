import 'dart:convert';

import 'package:bakole/constants/Constants.dart';
import 'package:bakole/httpModels/Job.dart';
import 'package:bakole/httpModels/Worker.dart';
import 'package:bakole/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final Map<bool, double> opacityMap = {
    true : 1.0,
    false : 0.0
  };

  JobProgressState({@required this.job, @required this.inProgress});

  @override
  Widget build(BuildContext context) {

    final Worker worker = widget.worker;
    final _key = GlobalKey<ScaffoldState>();

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

          Positioned.fill(
              child: Column(
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
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
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
                              if(updatedJob != null){
                                job = updatedJob;
                                inProgress = getProgressInBool(updatedJob.progress);

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

                            });
                          }
                          else{
                            await setProgressChange(job.id, Progress.FINISHED);
                            final Job updatedJob = await getUpdatedJob(_key, job.id);

                            setState(() {
                              if(updatedJob != null){
                                inProgress = getProgressInBool(updatedJob.progress);
                                job = updatedJob;

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
                              }
                              else{
                                showErrorSnackBar(_key);
                              }
                            });
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
          )

        ],
      ),
    );
  }
}