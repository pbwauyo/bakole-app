class Job {
  final String employerName;
  final String employerEmail;
  final String employerDeviceToken;
  final String description;
  final String category;
  final String fee;
  final String location;
  final String startTime;
  final String startDate;

  Job({this.employerName, this.employerEmail, this.employerDeviceToken, this.description, this.category, this.fee, this.location, this.startTime, this.startDate});

  factory Job.fromJson(Map<String, dynamic> map){
  
    return Job(
      employerName: map['employerName'],
      employerEmail: map['employerEmail'],
      employerDeviceToken: map['employerDeviceToken'],
      description: map['description'],
      category: map['category'],
      fee: map['fee'],
      location: map['place'],
      startTime: map['time'],
      startDate: map['date']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'employerName' : employerName,
      'employerEmail' : employerEmail,
      'employerDeviceToken' : employerDeviceToken,
      'description' : description,
      'category' : category,
      'fee' : fee,
      'place' : location,
      'time' : startTime,
      'date' : startDate
    };
  }

  @override
  String toString() {
    
    return "\n employerName: $employerName\n employerEmail: $employerEmail\n description: $description\n category: $category\n fee: $fee\n place: $location\n startTime: $startTime\n startDate: $startDate\n";
  }



}