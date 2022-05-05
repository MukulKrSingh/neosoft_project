import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neosoft_project/Services/database_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/user_model.dart';

class SelectedUsersPage extends StatefulWidget {
  const SelectedUsersPage({Key? key}) : super(key: key);

  @override
  State<SelectedUsersPage> createState() => _SelectedUsersPageState();
}

class _SelectedUsersPageState extends State<SelectedUsersPage> {
  SharedPreferences? prefs;
  late DataBaseServices db;
  @override
  void initState() {
    db = DataBaseServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.getDataFromDb(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].login),
                leading: ClipOval(
                    child: Image.network(snapshot.data![index].avatarUrl),
                    ),
                    );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  getDataFromDB() async {
    prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> userMap = jsonDecode(prefs?.getString('user') ?? "");
    User user = User.fromJson(userMap);
  }
}
