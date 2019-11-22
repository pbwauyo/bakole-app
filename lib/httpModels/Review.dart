
import 'package:flutter/cupertino.dart';

class Review {
  final String reviewId;
  final String reviewerEmail;
  final String revieweeEmail;
  final String message;
  final String rating;
  final String date;

  Review({this.reviewId, @required this.reviewerEmail, @required this.revieweeEmail, @required this.message, @required this.rating, this.date});

  factory Review.fromJson(Map<String , dynamic> json){
    return Review(
      reviewId: json["_id"],
      reviewerEmail: json["reviewerEmail"],
      revieweeEmail: json["revieweeEmail"],
      message: json["message"],
      rating: json["rating"],
      date: json["date"]
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "reviewerEmail" : reviewerEmail,
      "revieweeEmail" : revieweeEmail,
      "message" : message,
      "rating" : rating,
      "date" : date
    };
  }

  String toString(){
    return "\nreviewId: $reviewId\n reviewerEmail: $reviewerEmail\n revieweeEmail: $revieweeEmail\n message: $message\n rating: $rating\n";
  }
}