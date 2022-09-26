// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
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
  List<Comment> comments;
  List<Like> likes;
  int v;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        description: json["description"],
        photoUrl: json["photoUrl"],
        absoluteUrl: json["absoluteUrl"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "description": description,
        "photoUrl": photoUrl,
        "absoluteUrl": absoluteUrl,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "__v": v,
      };
}

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    required this.userId,
    required this.description,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  UserId userId;
  String description;
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userId: UserId.fromJson(json["userId"]),
        description: json["description"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]!),
        updatedAt: DateTime.parse(json["updatedAt"]!),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId.toJson(),
        "description": description,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
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

// To parse this JSON data, do
//
//     final isLiked = isLikedFromJson(jsonString);

IsLiked isLikedFromJson(String str) => IsLiked.fromJson(json.decode(str));

String isLikedToJson(IsLiked data) => json.encode(data.toJson());

class IsLiked {
  IsLiked({
    required this.isLiked,
  });

  bool isLiked;

  factory IsLiked.fromJson(Map<String, dynamic> json) => IsLiked(
        isLiked: json["isLiked"],
      );

  Map<String, dynamic> toJson() => {
        "isLiked": isLiked,
      };
}

class IsLikedClass {}
