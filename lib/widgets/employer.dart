import 'package:bakole/httpModels/employer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../EmployerPages/addJob.dart';
import '../EmployerPages/home.dart';
import '../EmployerPages/searchJobs.dart';
import '../EmployerPages/viewJobs.dart';

class EmployerActivity extends StatefulWidget{
  EmployerActivity(this.employer);
  final Employer employer;

  @override
  createState() => EmployerActivityState();
}

class EmployerActivityState extends State<EmployerActivity>{
  var _index = 0;
  final widgets = <Widget>[Consumer<EmployerProvider>(builder: (_, employerProvider,__) => Home(employer: employerProvider.employer)), 
                            Consumer<EmployerProvider>(builder: (_, employerProvider, __) => AddJob(employer: employerProvider.employer)), 
                            ViewJobs(), 
                            SearchJobs()];
  
  @override
  Widget build(context) { 
    
    
    return Scaffold(
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
                Icons.add,
              ),
              title: Text(
                "Post Job",
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


