
import 'package:flutter/material.dart';
import 'package:neosoft_project/Services/database_services.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
      builder:
          (BuildContext context, AsyncSnapshot<List<List<String>?>?> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(snapshot.data![index]![0]),
                  leading:
                      ClipOval(child: Image.network(snapshot.data![index]![1])),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
