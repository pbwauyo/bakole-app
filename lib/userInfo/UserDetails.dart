import 'package:bakole/constants/Constants.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/httpModels/Job.dart'as _Job;
import 'package:bakole/httpModels/Worker.dart';
import 'package:bakole/userInfo/tabs/JobTab.dart';
import 'package:bakole/userInfo/tabs/Profile.dart';
import 'package:bakole/userInfo/tabs/Reviews.dart';
import 'package:bakole/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

Map<String, dynamic> _createUserDetails(String userType, dynamic user){

  if(userType == UserType.WORKER){
    Worker worker = user as Worker;

    return {
      "name" : formatName(worker.firstName, worker.lastName),
      "rating" : worker.rating,
      "email" : worker.email,
      "phone" : worker.phoneNumber,
      "sex" : worker.sex,
      "averagePay" : worker.averagePay,
      "skillStatus" : worker.skillStatus,
      "category" : worker.category
    };
  }
  else{
    Employer employer = user as Employer;
    return {
      "name" : formatName(employer.firstName, employer.lastName),
      "rating" : employer.rating,
      "email" : employer.email,
      "phone" : employer.phoneNumber,
      "sex" : employer.sex,
    };
  }
}

class UserDetails extends StatefulWidget{
  final String userType;
  final dynamic user;
  final Map<String, dynamic> userDetails;
  final _Job.Job job;

  UserDetails({@required this.userType, @required this.user, this.job}): userDetails = _createUserDetails(userType, user);

  @override
  State<UserDetails> createState() {

    return UserDetailsState(userDetails: userDetails);
  }
}

class UserDetailsState extends State<UserDetails>{
  final Map<String, dynamic> userDetails;

  UserDetailsState({@required this.userDetails});

  String name;
  String rating;
  String email;
  String phone;
  String sex;
  String averagePay;
  String skillStatus;
  String category;

  List<Widget> tabs;

  @override
  void initState() {
    super.initState();

    name = userDetails["name"];
    rating = userDetails["rating"] ?? "0.0";
    email = userDetails["email"];
    phone = userDetails["phone"];
    sex = userDetails["sex"];
    averagePay = userDetails["averagePay"];
    skillStatus = userDetails["skillStatus"];
    category = userDetails["category"];

    tabs  = [
      Profile(
        userType: widget.userType,
        name: name,
        rating: rating,
        email: email,
        phone: phone,
        sex: sex,
        averagePay: averagePay,
        skillStatus: skillStatus,
        category: category,
      ),
      Reviews(
        email: email,
        userType: widget.userType,
      ),
      JobTab(job: widget.job, worker: widget.user as Worker,)
    ];
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => CurrentTab(),
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate(
                    <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 160,
                            width: double.infinity,
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/cleaning.jpg"),
                              color: Colors.grey,
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.fromLTRB(16.0, 150, 16.0, 5.0),
                            child: Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0
                                          ),
                                        ),
                                      ),

                                      RatingBar(
                                        onRatingUpdate: (value){
                                        },
                                        allowHalfRating: true,
                                        unratedColor: Colors.grey,
                                        itemSize: 20.0,
                                        initialRating: double.parse(rating),
                                        itemBuilder: (context, index){
                                          return IconTheme(
                                            data: IconThemeData(
                                                color: Colors.amber
                                            ),
                                            child: Icon(Icons.star),
                                          );
                                        },
                                        itemCount: 5,
                                        ignoreGestures: true,
                                      ),

                                      SizedBox(
                                        height: 15.0,
                                      ),

                                      Consumer<CurrentTab>(
                                        builder:(context, _currentTab, _) => Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Material(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.circular(10.0),
                                                child: InkWell(
                                                  onTap: (){
                                                    _currentTab.tabIndex = 0;
                                                  },
                                                  splashColor: Colors.black26,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      IconTheme(
                                                        data: IconThemeData(
                                                            color: Colors.blueAccent
                                                        ),
                                                        child: Icon(Icons.person),
                                                      ),
                                                      Container(
                                                        child: Text("Profile"),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Material(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.circular(10.0),
                                                child: InkWell(
                                                  onTap: (){
                                                    _currentTab.tabIndex = 1;
                                                  },
                                                  splashColor: Colors.black26,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      IconTheme(
                                                        data: IconThemeData(
                                                            color: Colors.blueAccent
                                                        ),
                                                        child: Icon(Icons.favorite),
                                                      ),
                                                      Container(
                                                        child: Text("Reviews"),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: (){
                                                    _currentTab.tabIndex = 2;
                                                  },
                                                  splashColor: Colors.black26,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        IconTheme(
                                                          data: IconThemeData(
                                                              color: Colors.blueAccent
                                                          ),
                                                          child: Icon(Icons.business_center),
                                                        ),
                                                        Container(
                                                          child: Text("Job"),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                Positioned(
                                  top: -15,
                                  left: 5,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/cleaning.jpg"),
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          AppBar(
                            elevation: 0.0,
                            backgroundColor: Colors.transparent,
                          )
                        ],
                      ),

                      Consumer<CurrentTab>(
                          builder: (context, _currentTab, _) => tabs[_currentTab.index]
                      )
                    ]
                )
            ),

          ],
        ),

      ),
    );
  }
}

class CurrentTab with ChangeNotifier{

  int _index = 0;

  set tabIndex(int index){
    this._index = index;
    notifyListeners();
  }

  get index => this._index;
}