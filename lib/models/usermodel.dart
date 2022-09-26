// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.username,
    // required this.fullname,
    required this.email,
    this.bio,
    // required this.phone,
    required this.password,
  });

  String? username;
  // String fullname;
  String email;
  String? bio;
  // int phone;
  String password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        // fullname: json["fullname"],
        email: json["email"],
        bio: json["bio"],
        // phone: json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        // "fullname": fullname,
        "email": email,
        "bio": bio,
        // "phone": phone,
        "password": password,
      };
}
