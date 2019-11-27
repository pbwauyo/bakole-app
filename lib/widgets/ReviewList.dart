import 'dart:convert';
import 'package:bakole/constants/Constants.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/httpModels/Review.dart';
import 'package:bakole/httpModels/Worker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Future<List<Map<String, dynamic>>> getReviews(String userEmail, String userType) async{
  final reviewsUrl = "$AWS_SERVER_URL/reviews/$userEmail";
  final reviewerProfileUrl = userType == UserType.EMPLOYER ? "$AWS_SERVER_URL/workers/search" : "$AWS_SERVER_URL/employers/search";
  final List<Map<String, dynamic>> list = [];
  String name;
  String imageUrl;

  try{

    final reviewResponse = await httpClient.get(reviewsUrl); //get user reviews

    if(reviewResponse.statusCode == 200){

      final List<Map<String, dynamic>> reviewsJson = json.decode(reviewResponse.body).cast<Map<String, dynamic>>();

      for(var res in reviewsJson){
        final Review rev = Review.fromJson(res);

        try {
          final reviewerResponse = await httpClient.get("$reviewerProfileUrl/${rev.reviewerEmail}"); //get reviewers details

          if(reviewerResponse.statusCode == 200) {
            final List<Map<String, dynamic>> users = json.decode(reviewerResponse.body).cast<Map<String, dynamic>>();
            final user = userType == UserType.EMPLOYER ? Worker.fromJson(users[0]) : Employer.fromJson(users[0]);

            if (userType == UserType.EMPLOYER) {
              Worker worker = user as Worker;
              name = "${worker.firstName ?? ""} ${worker.lastName ?? ""}";
              imageUrl = "";
            }
            else {
              Employer employer = user as Employer;
              name = "${employer.firstName ?? ""} ${employer.lastName ?? ""}";
              imageUrl = "";
            }

            list.add(
                {
                  "name": name,
                  "imageUrl": imageUrl,
                  "review": rev
                }
            );

          }
          else{
            print("USER STATUS CODE ${reviewerResponse.statusCode}");
            return list;
          }
        }catch(error){
          print("ERROR IN FINDING USER $error");
          return [];
        }
      }
      return list;

    }
    else {
      print("REVIEW STATUS CODE: ${reviewResponse.statusCode}");
    }
    return list;

  }catch(error){
    print("ERROR IN GETTING REVIEWS: $error");
    return [];
  }

}

class ReviewList extends StatefulWidget {
  final String userEmail;
  final String userType;
  

  ReviewList({@required this.userEmail, @required this.userType});

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  Future<List<Map<String, dynamic>>> future;
  
  _ReviewListState();
  
  @override
  void initState() {
    super.initState();
    future = getReviews(widget.userEmail, widget.userType);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: future,
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data.length > 0) {
          final List<Map<String, dynamic>> list = snapshot.data;
          
          return ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final Review review = list[index]["review"];
                final String name = list[index]["name"];
                final String imageUrl = list[index]["imageUrl"];

                return Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                child: Image(
                                  image: AssetImage(
                                      "assets/images/default_pic.png"),
                                  fit: BoxFit.cover,
                                ),
                                radius: 20.0,
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: RatingBar(
                                    itemCount: 5,
                                    allowHalfRating: true,
                                    initialRating: double.parse(
                                        review.rating ?? "0.0"),
                                    itemBuilder: (context, index) {
                                      return IconTheme(
                                        data: IconThemeData(
                                            color: Colors.yellow
                                        ),
                                        child: Icon(Icons.star),
                                      );
                                    },
                                    itemSize: 20.0,
                                    onRatingUpdate: (value) {},
                                    ignoreGestures: true,
                                    unratedColor: Colors.grey,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                                  child: Container(
                                    child: Text(name,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,

                                      ),
                                    ),
                                  ),
                                ),

                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Container(
                                    width: 250,
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Text(review.message,
                                      maxLines: null,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 5.0, right: 5.0),
                            child: Text(review.date,
                              style: TextStyle(
                                  fontSize: 12.5,
                                  color: Colors.black54
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          );
        }
        else if (snapshot.hasError){
          return Center(
            child: Container(
              child: Text("ERROR: ${snapshot.error}"),
            ),
          );
        }
        else if(snapshot.data?.length == 0){
          return Center(
            child: Container(
              child: Text("No reviews available"),
            ),
          );
        }
        
        return Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        );
      }
    );
  }
}
