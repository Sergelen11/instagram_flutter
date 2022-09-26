import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/models/postmodel.dart';
import 'package:instagram/services/remoteservices.dart';
import 'package:instagram/utils/comment.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);
  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final commentController = TextEditingController();
  final String postId = Get.arguments[0]['postId'];
  final String token = Get.arguments[0]['token'];
  final List<Comment> comments = Get.arguments[0]['comments'];

  late int status;
//  final difference = date2.difference(birthday).inDays;
  @override
  void initState() {
    // getComments();
    // print(date2);
    // print(comments.runtimeType);
    super.initState();
  }

  // getComments() async {
  //   comments = await RemoteServices().getComments(postId: postId, token: token);
  //   print(comments);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back)),
        title: const Text('Comments'),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return CommentComponent(
            comment: comments[index],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            SizedBox(
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30 / 2),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                      helperStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                status = await RemoteServices().createComment(
                    description: commentController.text,
                    token: token,
                    postId: postId);
                if (status == 200) {
                  commentController.text = '';
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
