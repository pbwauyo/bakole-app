import 'package:http/http.dart' as http;

//const String _LOCAL_IP_ADDRESS = "192.168.1.127"; //MiFi
const String _LOCAL_IP_ADDRESS = "10.10.2.91"; //PlanetSys
//const String _LOCAL_IP_ADDRESS = "192.168.43.7";
const String _PORT = "3000";
const String _AWS_DNS_ADDRESS = "ec2-18-218-191-0.us-east-2.compute.amazonaws.com";
const String AWS_SERVER_URL = "http://$_LOCAL_IP_ADDRESS:$_PORT";

const String WORKER = "worker";
const String EMPLOYER = "employer";
final httpClient = http.Client();

final Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

class UserType{
  static const String WORKER = "worker";
  static const String EMPLOYER = "employer";
}

class Status{
  static const String PENDING = "Pending";
  static const String ACTIVE = "Active";

  static const String ACCEPTED = "Accepted";
  static const String DECLINED = "Declined";
}

class Progress{
  static const String NOT_STARTED = "Not Started";
  static const String STARTED = "Started";
  static const String FINISHED = "Finished";
  static const String IN_PROGRESS = "In Progress";
}