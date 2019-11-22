import 'package:bakole/constants/Constants.dart';
import 'package:device_id/device_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class FadedLine extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 1,
      margin: EdgeInsets.only(bottom: 8),
      width: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [ Colors.black12, Colors.black54, Colors.black12],
          stops: const [0.0, 0.5, 1.0]
        )
      ),
    );
  }
}

class Dot extends StatelessWidget{
  final int statusIndex;
  final List<Color> colors = [Colors.orange, Colors.green];

  Dot({@required this.statusIndex});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: colors[statusIndex]
      ),
    );
  }
}

String capitaliseFirstLetter(String string){
  String str1 = string[0];
  String str2 = string.substring(1);

  return str1.toUpperCase() + str2.toLowerCase();
}

class ContinuousTextAnim extends StatefulWidget{
  final text;
  ContinuousTextAnim(this.text);

  @override
  State<ContinuousTextAnim> createState() {

    return _ContinuousTextAnimState(this.text);
  }
}

String formatName(String fName, String lName){
  return "${fName ?? ""} ${lName ?? ""}";
}

class _ContinuousTextAnimState extends State<ContinuousTextAnim>{

  final String text;

  _ContinuousTextAnimState(this.text);

  @override
  Widget build(BuildContext context) {

    return Container(

      child: Text(this.text,
        style: TextStyle(
            color: Colors.green,
            fontSize: 16.0
        ),
      ),
    );
  }
}

void showErrorSnackBar(GlobalKey<ScaffoldState> key, {error}){
  key.currentState.showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                  color: Colors.red
              ),
              child: Icon(Icons.error),
            ),

            Text(error != null? error.toString() : "error has occured")
          ],

        ),
      )
  );
}
