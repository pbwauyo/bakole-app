class Job {
  final String employerName;
  final String employerEmail;
  final String description;
  final String category;
  final String fee;
  final String location;
  final String startTime;

  Job({this.employerName, this.employerEmail, this.description, this.category, this.fee, this.location, this.startTime});

  factory Job.fromJson(Map<String, dynamic> map){
  
    return Job(
      employerName: map['employerName'],
      employerEmail: map['employerEmail'],
      description: map['description'],
      category: map['category'],
      fee: map['fee'],
      location: map['place'],
      startTime: map['time']
    );
  }

  Map<String, String> toJson(){
    return {
      'employerName' : employerName,
      'employerEmail' : employerEmail,
      'description' : description,
      'category' : category,
      'fee' : fee,
      'place' : location,
      'time' : startTime
    };
  }



}