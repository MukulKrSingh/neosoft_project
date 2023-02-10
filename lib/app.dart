// ignore_for_file: prefer_const_constructors

//

import 'package:flutter/material.dart';


import 'Views/selected_users_page.dart';
import 'Views/users_list_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Git Hub Users List'),
            bottom: const TabBar(
              tabs: [
                Tab(text:'Git Hub Users' ,),
                Tab(text: 'Selected Users',),

              ],
            ),
          
          ),
          // ignore: prefer_const_literals_to_create_immutables
          body: TabBarView(children: [
            UserListPage(),
            SelectedUsersPage(),
            
          ]),
        ),
      ),
    );
  }
}
