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
  );

  final String login;
  final int id;
  final String avatarUrl;
  final String url;

  factory User.fromJson(Map<String, dynamic> json) => User(
        json["login"],
        json["id"],
        json["avatar_url"],
        json["url"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "avatar_url": avatarUrl,
        "url": url,
      };
}
