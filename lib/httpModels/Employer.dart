class Employer{
  final String firstName, lastName, sex, email, phoneNumber, password;

  Employer({this.firstName, this.lastName, this.sex, this.email, this.phoneNumber, this.password});

  factory Employer.fromJson(Map <String, dynamic> json){
    return Employer(
      firstName: json['firstName'],
      lastName: json['lastName'],
      sex: json['sex'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password']
    );
  }

  Map<String, dynamic> toMap(Employer employer){
    return {
      "firstName": employer.firstName,
      "lastName": employer.lastName,
      "sex": employer.sex,
      "email": employer.email,
      "phoneNumber": employer.phoneNumber,
      "password": employer.password
    };
  }
}