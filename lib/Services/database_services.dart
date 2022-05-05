import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../Models/user_model.dart';

class DataBaseServices {
  SharedPreferences? prefs;
  List<String> userStringList = [];
  late List<User> selectedUserList = [];
  late Map<String, dynamic> userMap = {};
  List<String>? listOfUserFromPrefs = [];

  DataBaseServices();

  Future<List<User>> getDataFromDb() async {
    prefs = await SharedPreferences.getInstance();
    listOfUserFromPrefs = prefs!.getStringList('users');
    print(listOfUserFromPrefs!.length);
    for (var singleUser in listOfUserFromPrefs!) {
      
        userMap.addAll(jsonDecode(singleUser));
      
    }
    print('Map length ${userMap.length}');

    for (var keys in userMap.values) {
      selectedUserList.add(User.fromJson(userMap[keys]));
    }

    print('get from DB ${selectedUserList.length}');

    return selectedUserList;
  }

  addDataToDb(List<User> user) async {
    //List<String> userStringList = [];

    for (var singleUser in user) {
      userStringList.add(jsonEncode(singleUser));
    }

    print('In addToDb');
    print(userStringList.length);

    prefs = await SharedPreferences.getInstance();
    prefs?.setStringList('users', userStringList);
  }
}
