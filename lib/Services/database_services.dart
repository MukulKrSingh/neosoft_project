
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/user_model.dart';



class DataBaseServices {
  SharedPreferences? prefs;
  List<String> userStringList = [];
  late List<User> selectedUserList = [];
  late Map<String, dynamic> userMap = {};
  List<List<String>?>? listOfUserFromPrefs = [];
  //int uniqueUser = 0;
  int uniqueUser = 0;
  int i = 0;

  DataBaseServices();

  Future<List<List<String>?>?> getDataFromDb() async {
    prefs = await SharedPreferences.getInstance();

    while (true) {
      if (prefs?.getStringList(i.toString()) != null) {
        listOfUserFromPrefs?.add(prefs?.getStringList(i.toString()));
      }
      i++;
      if (prefs?.getStringList(i.toString()) == null) {
        break;
      }
      //print('in loop');
    }
    return listOfUserFromPrefs;
  }

  addDataToDb(List<List<String>> selectedUsersList) async {
    //List<String> userStringList = [];
    prefs = await SharedPreferences.getInstance();
    prefs?.clear();
    for (var user in selectedUsersList) {
      //print(user[1]);
      prefs?.setStringList(uniqueUser.toString(), user);
      uniqueUser++;
    }
  }
}
