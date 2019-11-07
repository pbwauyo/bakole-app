class Employer{
  final String firstName, lastName, sex, email, phoneNumber, password, deviceToken, rating;

  Employer({this.firstName, this.lastName, this.sex, this.email, this.phoneNumber, this.password, this.deviceToken, this.rating});

  factory Employer.fromJson(Map <String, dynamic> json){
    return Employer(
      firstName: json['firstName'],
      lastName: json['lastName'],
      sex: json['sex'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      deviceToken: json['deviceToken'],
      rating: json['rating']
    );
  }

  Map<String, dynamic> toMap(Employer employer){
    return {
      "firstName": employer.firstName,
      "lastName": employer.lastName,
      "sex": employer.sex,
      "email": employer.email,
      "phoneNumber": employer.phoneNumber,
      "password": employer.password,
      "deviceToken" : employer.deviceToken,
      "rating" : employer.rating
    };
  }

  bool ratingExists(){
    if(this.rating != null && double.parse(this.rating) > 0.0){
      return true;
    }
    else return false;
  }
}