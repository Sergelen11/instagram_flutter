// To parse this JSON data, do
//
//     final userPostModel = userPostModelFromJson(jsonString);

import 'dart:convert';

List<UserPostModel> userPostModelFromJson(String str) =>
    List<UserPostModel>.from(
        json.decode(str).map((x) => UserPostModel.fromJson(x)));

String userPostModelToJson(List<UserPostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserPostModel {
  UserPostModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.photoUrl,
    required this.absoluteUrl,
    required this.comments,
    required this.likes,
    required this.v,
  });

  String id;
  UserId userId;
  String description;
  String photoUrl;
  String absoluteUrl;
  List<dynamic> comments;
  List<Like> likes;
  int v;

  factory UserPostModel.fromJson(Map<String, dynamic> json) => UserPostModel(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        description: json["description"],
        photoUrl: json["photoUrl"],
        absoluteUrl: json["absoluteUrl"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "description": description,
        "photoUrl": photoUrl,
        "absoluteUrl": absoluteUrl,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "__v": v,
      };
}

class Like {
  Like({
    required this.userId,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  UserId userId;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        userId: UserId.fromJson(json["userId"]),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId.toJson(),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class UserId {
  UserId({
    required this.id,
    required this.username,
    required this.password,
    this.fullname,
    required this.email,
    this.phone,
    required this.createdAt,
    required this.v,
  });

  String id;
  String username;
  String password;
  String? fullname;
  String email;
  int? phone;
  DateTime createdAt;
  int v;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        username: json["username"],
        password: json["password"],
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "password": password,
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
