import 'package:bakole/employer/Profile.dart';
import 'package:bakole/httpModels/Employer.dart';
import 'package:bakole/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AddJob.dart';
import 'Home.dart';
import 'searchJobs.dart';
import 'ViewJobs.dart';



class EmployerActivity extends StatefulWidget{
  EmployerActivity(this.employer);
  final Employer employer;

  @override
  createState() => EmployerActivityState();
}

class EmployerActivityState extends State<EmployerActivity>{
  var _index = 0;

  final widgets = <Widget>[Consumer<EmployerProvider>(builder: (_, employerProvider,__) => Home(employer: employerProvider.employer)),
                            ViewJobs(), 
                            SearchJobs(),
                            Consumer<EmployerProvider>(builder: (_, employerProvider, __) => Profile(employer: employerProvider.employer)),];
  final appBarTitles = <String>["How can we help you?", "Job history", "","Your Profile"];
  // ignore: non_constant_identifier_names
  final SIGN_OUT = "Sign out";
  
  @override
  Widget build(context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[_index]),
        actions: <Widget>[
          Visibility(
            visible: _index == 3, //only show if on Profile tab
            child: PopupMenuButton<String>(
                onSelected: (value) async{
                  final phoneId = await getPhoneId();
                  await signOut(phoneId);
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                itemBuilder: (context){
                  return <PopupMenuItem<String>>[
                    PopupMenuItem<String>(
                      value: SIGN_OUT,
                      child: Text(SIGN_OUT),
                    ),
                  ];
              }
            ),
          )
        ],
      ),
      body: ChangeNotifierProvider(
        builder: (context) => EmployerProvider(employer: widget.employer),
        child: SafeArea(
          child: widgets[_index],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0XFFE5E5E5),
          primaryColor: Colors.cyan,
        ),
        
        child: BottomNavigationBar(
          currentIndex: _index,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.cyan[400],
          unselectedItemColor: Colors.cyan,
          
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(
                "Home",
              ),
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Icons.view_headline,
              ),
              title: Text(
                "Your Jobs",
              ),
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              title: Text(
                "Search jobs",
              ),
            ),

            BottomNavigationBarItem(

              icon: Icon(
                Icons.person,
              ),
              title: Text(
                "Profile",
              ),
            ),
          ],

          onTap: (index){
            setState(() {
              _index = index;
            });
          },
        ),
      ),
  );
  }
}

class EmployerProvider with ChangeNotifier{
  Employer employer;
  EmployerProvider({this.employer}){
    notifyListeners();
  }

  get getEmployer => employer;

  set setEmployer(Employer employer) {
    this.employer = employer;
    notifyListeners();
  }
}


