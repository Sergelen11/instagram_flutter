// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:io';
import 'package:instagram/models/followdata.dart';
import 'package:instagram/models/loginusermodel.dart';
import 'package:instagram/models/postmodel.dart' as postA;
import 'package:http/http.dart' as http;
import 'package:instagram/models/usermodel.dart';
import 'package:instagram/models/userpostmodel.dart' as postB;

class RemoteServices {
  Future<UserModel?> getUserData(
      {String? token, required String userId}) async {
    var client = http.Client();
    token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MmU5ZGJlZmE4NmYxYmM3Zjc5YmUwMjYiLCJpYXQiOjE2NjA2NTYwNjZ9.e-PfagLZEylXHPoRallbmiWlJ3b-M3_ShfisFddULUw';
    var uri = Uri.parse('http://localhost:3000/profile/${userId}');
    var headers = {
      HttpHeaders.authorizationHeader: token,
    };
    var response = await client.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      // print(json);
      return userModelFromJson(json);
    }
    return null;
  }

  Future<UserModel> getMyInfo({required String token}) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/user');
    // print('this is token : $token');
    var headers = {
      HttpHeaders.authorizationHeader: token,
    };
    var response = await client.get(uri, headers: headers);

    var json = response.body;
    // print(json);
    return userModelFromJson(json);
  }

  Future<List<postA.PostModel>?> getPosts({required String token}) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/allpost');
    var headers = {
      HttpHeaders.authorizationHeader: token,
    };
    var response = await client.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      print('posts : $json');
      return postA.postModelFromJson(json);
    }
    return null;
  }

  Future<List<postA.Comment>> getComments({
    required String? postId,
    required String? token,
  }) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/comments/$postId');
    print(token);
    var headers = {
      HttpHeaders.authorizationHeader: token!,
    };
    var response = await client.get(uri, headers: headers);
    var json = response.body;
    return postA.commentFromJson(json);
  }

  Future<int> createComment({
    required String? description,
    required String? token,
    required String? postId,
  }) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/comment/$postId');
    var headers = {
      HttpHeaders.authorizationHeader: token!,
    };
    var body = {"description": "$description"};
    var response = await client.post(uri,
        headers: {
          "Content-Type": "application/json",
          "authorization": "$token"
        },
        body: jsonEncode(body));
    var json = response.body;
    print(json);
    // return postA.commentFromJson(json);
    return response.statusCode;
  }

  Future<List<postB.UserPostModel>> getUserPosts({
    required String? token,
  }) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/post');
    var headers = {
      HttpHeaders.authorizationHeader: token!,
    };
    var response = await client.get(uri, headers: headers);
    var json = response.body;
    // print(json);
    return postB.userPostModelFromJson(json);
  }

  Future<MyFollowing> Following({
    required String? token,
  }) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/following');
    var headers = {
      HttpHeaders.authorizationHeader: token!,
    };
    var response = await client.get(uri, headers: headers);
    var json = response.body;
    print(json);
    return myFollowingFromJson(json);
  }

  Future<http.StreamedResponse> FollowUser({
    required String token,
    required String userId,
  }) async {
    var postUri = Uri.parse('http://localhost:3000/follow');

    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
    request.headers['authorization'] = token;
    request.fields["following"] = userId;

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<MyFollowing> isUserFollowing({
    required String? token,
    required String? userId,
  }) async {
    // print(token);
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/userfollowing/${userId}');
    var headers = {HttpHeaders.authorizationHeader: token!};
    var response = await client.get(uri, headers: headers);
    var json = response.body;
    print(json);
    return myFollowingFromJson(json);
  }

  // Future<dynamic> upload({
  //   required String? token,
  //   required String? userId,
  // }) async {
  //   // print(token);
  //   var client = http.Client();
  //   var uri = Uri.parse('http://localhost:3000/userfollowing/${userId}');
  //   var headers = {HttpHeaders.authorizationHeader: token!};
  //   var response = await client.get(uri, headers: headers);
  //   var json = response.body;
  //   print(json);
  //   return myFollowingFromJson(json);
  // }
  Future<IsFollowing?> isFollowed({
    required String token,
    required String userId,
  }) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/isfollowing/${userId}');
    var headers = {HttpHeaders.authorizationHeader: token};
    var response = await client.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return isFollowingFromJson(json);
    }
    return null;
  }

  Future<String> deletePost({
    required String token,
    required String postId,
  }) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/post/${postId}');
    var headers = {HttpHeaders.authorizationHeader: token};
    var response = await client.delete(uri, headers: headers);
    var json = response.body;
    return json;
  }

  Future<List<postB.UserPostModel>?> getAnotherUserPosts({
    required String token,
    required String userId,
  }) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/userposts/${userId}');
    var headers = {HttpHeaders.authorizationHeader: token};
    var response = await client.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return postB.userPostModelFromJson(json);
    }
    return null;
  }

  Future<List<postA.Like>?> likePost(
      {required String id, required String token}) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/post/like/${id}');
    var headers = {
      HttpHeaders.authorizationHeader: token,
    };
    var response = await client.post(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      // return postA.likefromLikeModel(json);
    }
    return null;
  }

  Future<postA.IsLiked?> isUserLiked({required String id}) async {
    var usertoken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MmU5ZGJlZmE4NmYxYmM3Zjc5YmUwMjYiLCJpYXQiOjE2NjAwNTU4ODF9.99Yg4O_Zn9DFhyW0m_haafwhrlc7tkx03s1kT-ZMK4k';
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/post/isLiked/${id}');
    var headers = {
      HttpHeaders.authorizationHeader: usertoken,
    };
    var response = await client.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return postA.isLikedFromJson(json);
    }
    return null;
  }

  Future<UserModel?> RegisterUser({
    required String bio,
    required String email,
    required String password,
    required String username,
  }) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/register');
    var body = {
      "username": "$username",
      "email": "$email",
      "bio": "$bio",
      "password": "$password"
    };
    // print(body);

    var response = await client.post(uri,
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    // print(response.toString());
    if (response.statusCode == 200) {
      var json = response.body;
      // print(json);
      return userModelFromJson(json);
    }
    return null;
  }

  Future<LoginUserModel?> LoginUser({
    required String email,
    required String password,
  }) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:3000/login');
    var body = {"email": "$email", "password": "$password"};
    // print(jsonEncode(body));

    var response = await client.post(uri,
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    // print(response.toString());
    if (response.statusCode == 200) {
      var json = response.body;
      // print(json);
      return loginUserModelFromJson(json);
    }
    return null;
  }

  // ignore: non_constant_identifier_names
  Future<http.StreamedResponse> NewPost({
    required String description,
    required File file,
    required String token,
  }) async {
    var postUri = Uri.parse('http://localhost:3000/upload');

    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
    request.headers['authorization'] = token;
    request.fields["description"] = description;
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('file', file.path);

    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();
    return response;
  }
}

// ignore: non_constant_identifier_names
Future<http.StreamedResponse> NewPostServerless({
  required String description,
  required File file,
  required String token,
}) async {
  var postUri = Uri.parse(
      'https://test-bucket-serverless-demo.s3.amazonaws.com/9f8a3942-65e5-473e-9e0f-0b9401d8dae7%2B.jpeg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZZAIA6YXPKKKQXMG%2F20220914%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220914T015108Z&X-Amz-Expires=30000&X-Amz-Signature=aa1d222d98ca1611497a3223b9318d1de7696e35fc9cbcb611cc476509f6ac00&X-Amz-SignedHeaders=host');
  http.MultipartRequest request = new http.MultipartRequest("PUT", postUri);
  http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('file', file.path);

  request.files.add(multipartFile);

  http.StreamedResponse response = await request.send();
  return response;
}
