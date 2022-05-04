import 'package:dio/dio.dart';
import 'package:neosoft_project/Models/user_model.dart';

class ApiServices {
  //late Dio _dio;
  // ignore: constant_identifier_names
  static const String _GITHUB_LIST_USER_URL = 'https://api.github.com/users';
  Response? _response2;
  List<User>? userList2;

  ApiServices() {
    //_dio = Dio();
    //initializeInterceptor();
  }

  // initializeInterceptor() {
  //   _dio.interceptors.add(InterceptorsWrapper(
  //     onError: (error, errorInterceptorHandler) {
  //       print(error.message);
  //     },
  //     onRequest: (request, requestInterceptorHandler) {
  //       print("${request.method} | ${request.path}");
  //     },
  //     onResponse: (response, responseInterceptorHandler) {
  //       print('${response.statusCode} ${response.statusCode} ${response.data}');
  //     },
  //   ));
  // }

  Future<List<User>> getUsersFromApi() async {
    Response response;
    late List<User> usersList;
    final Dio _dio = Dio();
    try {
      //response from API
      print('In API SERVICE');
      response = await _dio.get(_GITHUB_LIST_USER_URL);
      if (response.statusCode == 200) {
        print(response.statusCode);
        //Turning all user  data received  in to List of Users
        List<dynamic> getAllUsersData = response.data as List;
        //Mapping users  chatto list acording to index i.e. usersList[0].login.
        usersList = getAllUsersData.map((e) => User.fromJson(e)).toList();
        print(usersList.length);
        return usersList;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return usersList;
  }

  // getUsers() async {
  //   Dio _dio2 = Dio();
  //   print('Inside getUser 2');
  //   _response2 = await _dio2.get(_GITHUB_LIST_USER_URL);
  //   print(_response2?.statusCode);
  // }
}
