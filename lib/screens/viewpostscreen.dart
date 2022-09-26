import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/models/userpostmodel.dart';
import 'package:instagram/utils/userpost.dart';

class ViewPostScreen extends StatefulWidget {
  const ViewPostScreen({Key? key}) : super(key: key);

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  final List<UserPostModel> userposts = Get.arguments[0]['posts'];
  final dynamic id = Get.arguments[0]['id'];
  @override
  void initState() {
    var matchingIndex = userposts.indexWhere((post) => post.id == id);
    var removingPost = userposts.removeAt(matchingIndex);
    userposts.insert(0, removingPost);
    print(removingPost);
    print(userposts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Posts',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: userposts.length,
                itemBuilder: (context, index) {
                  return UserPostComponent(post: userposts[index]);
                }),
          ),
        ],
      ),
    );
  }
}
