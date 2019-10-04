import 'package:bakole/httpModels/worker.dart';
import 'package:bakole/workerPages/history.dart';
import 'package:bakole/workerPages/home.dart';
import 'package:bakole/workerPages/jobs.dart';
import 'package:bakole/workerPages/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkerActivity extends StatefulWidget{
  final Worker worker;
  WorkerActivity({@required this.worker});
  
  @override
  createState() => WorkerActivityState();
}

class WorkerActivityState extends State<WorkerActivity>{
  

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => TabIndex()),
        ChangeNotifierProvider(builder: (_) => WorkerProvider(worker: widget.worker))
      ],
      
      child: Scaffold(
        appBar: AppBar(
          title: Text("How can we help you?"),
        ),
        body: Body(),
        bottomNavigationBar: BottomNavBar(),
      ),
      
    );
  }
}

class Body extends StatefulWidget{
  @override
  createState() => BodyState();
}

class BodyState extends State<Body>{
  
  final List<Widget>  widgets = [Consumer<WorkerProvider>(builder: (_, workerProvider, __) => WorkerHomePage(workerId: workerProvider.worker.id,)), 
                                  WorkerJobPage(), 
                                  WorkerHistoryPage(), 
                                  WorkerProfilePage()];
 
  @override
  build(context) => Consumer<TabIndex>(
                      builder: (context, tabIndex, _) {
                        print(tabIndex.currentIndex);
                        return widgets[tabIndex.currentIndex];
                        }
                    );
}

class BottomNavBar extends StatefulWidget{
  @override
  createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar>{

  @override
  Widget build(BuildContext context) {
    
    return Consumer<TabIndex>(

      builder: (context, tab, _) => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.lime[50],
        ),
        child: BottomNavigationBar(
          currentIndex: tab.tabIndex,
          onTap: (index){
            print(index);
            tab.setCurrentIndex = index;
          },
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.blue[400],
          unselectedItemColor: Colors.cyan,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business_center),
              title: Text("Jobs")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text("History"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile")
            )
          ],
        ),
      ),
    );
  }
}

class WorkerProvider with ChangeNotifier{
  Worker worker;
  WorkerProvider({@required this.worker}){
    notifyListeners();
  }

}

class TabIndex with ChangeNotifier{
  int tabIndex = 0;

  //getter
  get currentIndex => tabIndex;

  //setter
  set setCurrentIndex(int index){
    tabIndex = index;
    print("notifying");
    notifyListeners();
  } 

}
