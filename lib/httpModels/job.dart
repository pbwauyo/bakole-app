class Job {
  final String employerEmail;
  final String description;
  final String category;
  final String fee;
  final String location;
  final String startTime;

  Job({this.employerEmail, this.description, this.category, this.fee, this.location, this.startTime});

  factory Job.fromJson(Map<String, dynamic> map){
  
    return Job(
      employerEmail: map['poster'],
      description: map['description'],
      category: map['category'],
      fee: map['fee'],
      location: map['location'],
      startTime: map['startTime']
    );
  }

  Map<String, String> toJson(){
    return {
      'poster' : employerEmail,
      'description' : description,
      'category' : category,
      'fee' : fee,
      'location' : location,
      'startTime' : startTime
    };
  }



}