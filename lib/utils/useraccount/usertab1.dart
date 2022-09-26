import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/models/userpostmodel.dart';
import 'package:instagram/utils/routes.dart';

class UserTab1 extends StatefulWidget {
  const UserTab1({Key? key, required this.userId, required this.userposts})
      : super(key: key);
  final String userId;
  final List<UserPostModel>? userposts;
  @override
  State<UserTab1> createState() => _UserTab1State();
}

class _UserTab1State extends State<UserTab1> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.userposts!.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(viewpostRoute, arguments: [
                  {
                    "posts": widget.userposts,
                    "id": widget.userposts![index].id
                  },
                ]);
              },
              child: Container(
                color: Colors.grey[400],
                child: CachedNetworkImage(
                  imageUrl: widget.userposts![index].photoUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        });
  }
}
