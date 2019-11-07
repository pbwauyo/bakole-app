class Worker {
  final String id;
  final String firstName; 
  final String lastName;
  final String sex;
  final String category;
  final String phoneNumber;
  final String email;
  final String averagePay;
  final String location;
  final String skillStatus;
  final String rating;
  final String deviceToken;
  
  Worker({this.id, this.firstName, this.lastName, this.sex, this.category, this.phoneNumber, this.email, this.averagePay, this.location, this.skillStatus, this.rating, this.deviceToken});

  factory Worker.fromJson(Map<String, dynamic> map){
    
    return Worker(
      id: map['_id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      sex: map['sex'],
      category: map['category'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      averagePay: map['averagePay'],
      location: map['location'],
      skillStatus: map['skillStatus'],
      rating: map['rating'],
      deviceToken: map['deviceToken']
    );
    }

   Map<String, String> toJson(){
      return {
        "firstName" : firstName,
        "lastName" : lastName,
        "sex" : sex,
        "category" : category,
        "phoneNumber" : phoneNumber,
        "email" : email,
        "averagePay" : averagePay,
        "location" : location,
        "skillStatus" : skillStatus,
        "rating" : rating,
        "deviceToken" : deviceToken
      };
   }

  bool ratingExists(){
    if(this.rating != null && double.parse(this.rating) > 0.0){
      return true;
    }
    else return false;
  }
}