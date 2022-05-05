import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User(
    this.login,
    this.id,
    this.avatarUrl,
    this.url,
    //this.isCheck,
  );

  @override
  String toString() {
    return '{${this.login},${this.id},${this.avatarUrl},${this.url}}';
  }

  final String login;
  final int id;
  final String avatarUrl;
  final String url;
  //bool isCheck = false;

  factory User.fromJson(Map<String, dynamic> json) => User(
        json["login"],
        json["id"],
        json["avatar_url"],
        json["url"],
        //json["isCheck"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "avatar_url": avatarUrl,
        "url": url,
        //"isCheck":isCheck,
      };
}
