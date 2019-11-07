import 'package:bakole/constants/Constants.dart';
import 'package:device_id/device_id.dart';

Future<String> getPhoneId() async{
  String id = "";

  try{
    id = await DeviceId.getID;
    return id;
  }catch(error){
    print(error);
    return id;
  }
}

Future<bool> signOut(String phoneId) async{
  final String url = "$AWS_SERVER_URL/users/$phoneId";

  try {
    final response = await httpClient.delete(url);
    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }

  }catch(err){
    print(err);
    return false;
  }

}