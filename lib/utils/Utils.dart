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