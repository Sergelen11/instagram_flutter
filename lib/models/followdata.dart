// To parse this JSON data, do
//
//     final followData = followDataFromJson(jsonString);

import 'dart:convert';

FollowData followDataFromJson(String str) =>
    FollowData.fromJson(json.decode(str));

String followDataToJson(FollowData data) => json.encode(data.toJson());

class FollowData {
  FollowData({
    required this.follower,
    required this.following,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String follower;
  String following;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory FollowData.fromJson(Map<String, dynamic> json) => FollowData(
        follower: json["follower"],
        following: json["following"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "follower": follower,
        "following": following,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

IsFollowing isFollowingFromJson(String str) =>
    IsFollowing.fromJson(json.decode(str));

String isFollowingToJson(FollowData data) => json.encode(data.toJson());

class IsFollowing {
  IsFollowing({required this.isFollowing});

  bool isFollowing;

  factory IsFollowing.fromJson(Map<String, dynamic> json) => IsFollowing(
        isFollowing: json["isFollowing"],
      );

  Map<String, dynamic> toJson() => {
        "isFollowing": isFollowing,
      };
}

// To parse this JSON data, do
//
//     final myFollowing = myFollowingFromJson(jsonString);

MyFollowing myFollowingFromJson(String str) =>
    MyFollowing.fromJson(json.decode(str));

String myFollowingToJson(MyFollowing data) => json.encode(data.toJson());

class MyFollowing {
  MyFollowing({
    required this.follower,
    required this.following,
  });

  List<dynamic> follower;
  List<Following> following;

  factory MyFollowing.fromJson(Map<String, dynamic> json) => MyFollowing(
        follower: List<dynamic>.from(json["follower"].map((x) => x)),
        following: List<Following>.from(
            json["following"].map((x) => Following.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "follower": List<dynamic>.from(follower.map((x) => x)),
        "following": List<dynamic>.from(following.map((x) => x.toJson())),
      };
}

class Following {
  Following({
    required this.id,
    required this.follower,
    required this.following,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  Follow follower;
  Follow following;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Following.fromJson(Map<String, dynamic> json) => Following(
        id: json["_id"],
        follower: Follow.fromJson(json["follower"]),
        following: Follow.fromJson(json["following"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "follower": follower.toJson(),
        "following": following.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Follow {
  Follow({
    required this.id,
    required this.username,
    required this.password,
    this.bio,
    required this.email,
    required this.createdAt,
    required this.v,
    this.fullname,
    this.phone,
  });

  String id;
  String username;
  String password;
  String? bio;
  String email;
  DateTime createdAt;
  int v;
  String? fullname;
  int? phone;

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
        id: json["_id"],
        username: json["username"],
        password: json["password"],
        bio: json["bio"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        fullname: json["fullname"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "password": password,
        "bio": bio,
        "email": email,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "fullname": fullname,
        "phone": phone,
      };
}
